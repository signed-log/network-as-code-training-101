# Lab Source of Truth

## Nicolas FORMICHELLA

## Solutions utilisées

- Nautobot
- Ansible

## Méthode de configuration

### RESTCONF

RESTCONF est un protocole transactionnel basé sur les modèles YANG et sur un API Rest, supporté par les équipements Arista.

Or, un soucis lié aux ACL, qui sont soit-disant non supportées, nous empêche de l'utiliser dans ce lab.

### GNMI

GNMI est un protocole transactionnel, supporté par les équipements Arista. Il est basé sur gRPC. 

Malgré la présence d'un module Ansible générique gRPC, il est plus complexe à mettre en place sur Ansible.

### NETCONF

NETCONF est un protocole transactionnel, supporté par les équipements Arista.

On a pu tenter une configuration via NETCONF, mais cela a échoué.

Des erreurs liées au lock de la configuration ont été rencontrées, Ansible quittant après chaque erreur, sans release le lock, il est impossible de continuer la configuration, la lockant à l'infini.

On pourrait ajouter un `block` et un `rescue` pour relacher le lock en cas d'erreur, mais cela est fastidieux, sans compter que cela ne garantit pas que le lock soit bien relaché.

### CLI

Le module Ansible eos permet de gérer les équipements réseau Arista. Il utilise la ligne de commande EOS.

#### Compromis

La CLI n'étant pas transactionnelle, nous devons trouver un compromis.

On pourrait `delete` les éléments de configuration précédemment, mais cela est fastidieux et peux causer des pertes de services (notemment des sessions BGP).

### Problèmes rencontrés

Dans le cadre de ce lab, nous allons utiliser la CLI, mais nous devons être conscient des limites de cette approche.

Nous avons aussi pu rencontrer des problèmes de corruption hardware liées à l'utilisation du module `eos_bgp_global`.

```bash
> router bgp 65001
% Unavailable command (function not supported on this platform)
```

Seul une destruction du lab et un redéploiement de celui-ci a permis de résoudre le problème.

Dans un mode de remplacement de configuration, donner une commande de suppression d'un élément de configuration qui n'existe pas génère une erreur.

```c
no neighbor 10.0.0.1 remote-as 65001
```

Est impossible si le voisin n'existe pas.

### Avantages

- Simple à mettre en place
- Simple à comprendre

### Limites

- Non transactionnel
- Peut causer des pertes de services

## Playbook

Nous allons créer un playbook qui va appliquer la configuration de notre lab.

### Inventaire dynamique

Pour avoir une SOT (Single Source of Truth), nous allons utiliser un inventaire dynamique.

```shell
ansible-galaxy collection install networktocode.nautobot
```

```yaml
---
plugin: networktocode.nautobot.gql_inventory
api_endpoint: http://172.100.100.6:8000
token: aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
query:
  devices:
    location: name
    role: name
    interfaces:
      name:
      ip_addresses: address
    bgp_routing_instances:
      router_id:
        host:
      endpoints:
        autonomous_system: asn
        peer:
          source_ip: address
          routing_instance:
            device: name
group_by: role.name
```

Ces informations sont récupérées depuis Nautobot au moyen de son API GraphQL.

### Playbook

Dans ce playbook, nous allons appliquer la configuration de notre lab, en utilisant à la fois les modules Ansible eos applicatif (module interface par exemple) et la CLI directement (pour le module BGP).

En utilisant les variables de l'inventaire dynamique, nous :

- Récupérons l'AS de notre équipement
- Récupérons les interfaces de notre équipement en les filtrant pour ne garder que les interfaces de type Ethernet (ceci sera utile pour la configuration OSPF)
- On sait que tous les équipements ont une session BGP entre eux, on peut donc assumer les voisins comme étant les autres équipements et pas les notres. 
  - Pour celà, on va utilser les filtres jinja2 pour ne garder que les voisins qui ne sont pas nous et les formater dans un format adapté pour le module `eos.eos_bgp_global` :
    - `groups['all']` : Récupère tous les hôtes dans l'inventaire Ansible actuel.
    - `reject('equalto', inventory_hostname)` : Cette commande filtre l'hôte actuel de la liste de tous les hôtes.
    - `map('extract', hostvars, 'interfaces')` : Cette commande extrait la variable 'interfaces' des variables d'hôte de chaque hôte.
    - `map('selectattr', 'name', 'equalto', 'loopback0')` : Cette commande sélectionne les interfaces dont le nom est `loopback0`.
    - `flatten` : Cette commande aplati la double-liste des interfaces en une seule liste.
    - `first` : Cette commande sélectionne la première interface de la liste.
    - `dict2items` : Cette commande convertit le dictionnaire des attributs d'interface en une liste de paires clé-valeur.
    - `selectattr('key', 'equalto', 'ip_addresses')` : Cette commande sélectionne l'attribut 'ip_addresses' dans la liste.
    - `map(attribute='value')` : Cette commande extrait la valeur de l'attribut `ip_addresses`.
    - `flatten` : Cette commande aplati la liste des adresses IP.
    - `first` : Cette commande sélectionne la première adresse IP de la liste.
    - `dict2items` : Cette commande convertit le dictionnaire des attributs d'adresse IP en une liste de paires clé-valeur.
    - `selectattr('key', 'equalto', 'address')` : Cette commande sélectionne l'attribut `address`.
    - `map(attribute='value')` : Cette commande extrait la valeur de l'attribut `address`.
    - `map('regex_replace', '/.*$', '')` : Cette commande supprime le masque de sous-réseau de l'adresse IP.
    - `map('regex_replace', '^', 'peer=')` : Cette commande ajoute `peer=` au début de l'adresse IP, ce qui crée une clé-valeur `peer=adresse_IP`.
    - `community.routeros.list_to_dict` : Cette commande convertit la liste de paires clé-valeur en un dictionnaire.
    - `combine({'remote_as': as_number})` : Cette commande ajoute l'attribut `remote_as` avec une valeur de `as_number` au dictionnaire.
- On utilise ensuite le module `eos.eos_hostname` pour configurer le nom d'hôte de l'équipement.
- On utilise ensuite le module `eos.eos_l2_interfaces` pour s'assurer que les interfaces demandées sont bien présentes.
- On utilise le module `eos.eos_l3_interfaces` pour configurer les addresses IP des interfaces.
  - Comme toutes les interfaces n'ont pas d'addresse IPv6, mais que certaines en ont, on doit employer le filtre `default('')` pour ne pas essayer de configurer une adresse IPv6 sur une interface qui n'en a pas en ajoutant une chaîne vide.
  - Ceci va causer une erreur, mais c'est une erreur attendue, pour la gérer, on utilise `ignore_errors: true`.
  - Afin de maintenir la gestion des erreurs, on utilise le module `ansible.builtin.fail` pour gérer les erreurs. 
    - Si `Incomplete command` est présent dans le message d'erreur, on ignore l'erreur. Si ce n'est pas le cas, on échoue le playbook.
- On utilise ensuite le module `eos.eos_bgp_global` pour configurer les sessions BGP.
  - On récupère la variable au dessus en la complémentant avec les informations de l'AS obtenu de l'inventaire dynamique.
  - On utilise le mode `rendered` du module pour que soit générée les commandes de configuration BGP CLI.
  - A cause du bug, on récupère donc la CLI pour l'exécuter directement avec `eos.eos_command`.
    - Afin de garder une transactionnalité, on entre dans une session de configuration, on exécute les commandes, puis on sort de la session de configuration avec `commit`.
      - ce qui applique à la `running-config` les modifications de la session.

## Conclusion

- que pensez-vous de la solution réalisée : quelles sont ses avantages par rapport à une gestion manuelle et quelles sont ses limites / faiblesses ?

La solution réalisée est simple à mettre en place et à comprendre. Elle permet de gérer la configuration de plusieurs équipements en même temps, ce qui est un avantage par rapport à une gestion manuelle.

Cependant, elle n'est pas transactionnelle, ce qui peut causer des pertes de services car des sessions ou des interfaces peuvent tomber.

### Points d'amélioration

- Ne pas avoir à recourir à la CLI manuellement et utiliser un modèle transactionel.
- Meilleure gestion des erreurs (notemment sur les adresses IPv6).
- Pouvoir gérer les interfaces qui ont de multiples adresses IP.
- Adapter le modèle de données venant de Nautobot pour séparer les adresses IPv4 et IPv6 plus proprement.
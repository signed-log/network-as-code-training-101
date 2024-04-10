# Lab Source of Truth

## Solutions utilisées

- Nautobot
- Ansible

## Méthode de configuration

### CLI

Le module Ansible eos permet de gérer les équipements réseau Arista. Il utilise la ligne de commande EOS.

Ceci cause des problèmes dans notre cas

En effet, dans un mode de remplacement de configuration, donner une commande de suppression d'un élément de configuration qui n'existe pas génère une erreur.

```shell
no neighbor 10.0.0.1 remote-as 65001
```

Est impossible si le voisin n'existe pas.

#### Compromis

La CLI n'étant pas transactionnelle, nous devons trouver un compromis.

On pourrait `delete` les éléments de configuration précédemment, mais cela est fastidieux et peux causer des pertes de services (notemment des sessions BGP).

On pourrait aussi utiliser gNMI, qui lui est transactionnel, pour appliquer les sessions BGP, mais cela est plus complexe, Ansible ne supportant pas gNMI nativement.

### Problèmes rencontrés

Dans le cadre de ce lab, nous allons utiliser la CLI, mais nous devons être conscient des limites de cette approche.

Nous avons aussi pu rencontrer des problèmes de corruption hardware liées à l'utilisation du module `eos_bgp_global`.

```bash
> router bgp 65001
% Unavailable command (function not supported on this platform)
```

Seul une destruction du lab et un redéploiement de celui-ci a permis de résoudre le problème.



### RESTCONF

RESTCONF est un protocole transactionnel, supporté par les équipements Arista.

Or, un soucis lié aux ACL, qui sont soit-disant non supportées, nous empêche de l'utiliser dans ce lab.

### GNMI

GNMI est un protocole transactionnel, supporté par les équipements Arista. Il est basé sur gRPC. 

Malgré la présence d'un module Ansible générique gRPC, il est plus complexe à mettre en place sur Ansible.

### NETCONF

NETCONF est un protocole transactionnel, supporté par les équipements Arista.

On a pu tenter une configuration via NETCONF, mais cela a échoué.

Des erreurs liées au lock de la configuration ont été rencontrées, Ansible quittant après chaque erreur, sans release le lock, il est impossible de continuer la configuration, la lockant à l'infini.

On pourrait ajouter un `block` et un `rescue` pour relacher le lock, mais cela est fastidieux.

## CLI

Après avoir tenté de configurer les équipements via NETCONF, nous allons utiliser la CLI.

### Avantages

- Simple à mettre en place
- Simple à comprendre

### Limites

- Non transactionnel
- Peut causer des pertes de services


## Playbook

Nous allons créer un playbook qui va appliquer la configuration de notre lab.

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

On pourrait `delete` les éléments de configuration, mais cela est fastidieux et peux causer des pertes de services (notemment des sessions BGP).

On pourrait aussi utiliser gNMI, qui lui est transactionnel, pour appliquer les sessions BGP, mais cela est plus complexe.

Dans le cadre de ce lab, nous allons utiliser la CLI, mais nous devons être conscient des limites de cette approche.

### RESTCONF

RESTCONF est un protocole transactionnel, supporté par les équipements Arista.

Or, un soucis lié aux ACL nous empêche de l'utiliser dans ce lab.

### GNMI

GNMI est un protocole transactionnel, supporté par les équipements Arista. Il est basé sur gRPC. Malgré la présence d'un module Ansible générique gRPC, il est plus complexe à mettre en place sur Ansible.

### NETCONF

NETCONF est un protocole transactionnel, supporté par les équipements Arista.

C'est cela que nous allons utiliser.

## Playbook

Nous allons créer un playbook qui va appliquer la configuration de notre lab.

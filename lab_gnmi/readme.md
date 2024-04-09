# Lab gNMI


## Pré-requis :

* Installer Docker engine :

    [Documentation d'installation de Docker](https://docs.docker.com/engine/install/ubuntu/)

    Testé avec Docker version 25.0.3

* Installer containerlab

        [Documentation d'installation de Containerlab](https://containerlab.dev/install/#__tabbed_1_1)

* Récupérer l'image SR-LINUX :

        docker pull ghcr.io/nokia/srlinux:23.10.2

* Ajouter l'image cEOS :

        docker import cEOS64-lab-4.30.5M.tar.xz ceos:4.30.5M

## 1) Lancement et accès à l'infrastructure

Lancement des containeurs

    containerlab deploy

Connexion SSH aux switchs:

    ssh admin@clab-lab_gnmi-sw1

Lancement de la CLI gNMIc

    docker run --network host --rm ghcr.io/openconfig/gnmic -a clab-lab_gnmi-sw1:6030 --insecure -u admin -p admin capabilities

## 2) Découverte du protocole gNMI

### 2.1) Configuration du protocole gNMI sur sw1

:question: Afficher la configuration gnmi sur sw1

:question: Afficher l'état opérationnel du protocole gnmi sur sw1


### 2.2) Utilisation du protocole gNMI

:question: Récupérer le nom des interfaces sur sw1

:question: Récupérer l'état opérationnel de l'interface ethernet1/1

:question: Créer une souscription pour recevoir le nombre d'octets passé sur l'interface ethernet1/1 toutes les 10s

:question: Créer une souscription pour recevoir toute changement d'état d'opérationnel des interfaces

:info: Tester la réception des messages de souscription en shuttant l'interface sur un extrémité

:question: Modifier l'état opérationnel de l'interface ethernet1/1

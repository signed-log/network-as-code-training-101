# network-as-code-training-101

Ce projet propose un ensemble de travaux pratiques permetant de monter en compétence sur les outils et protocoles utilisés pour automatiser la gestion d'une infrastructure réseau.

Les labs proposés utilisent les OS réseaux EOS et SR-linux.

Une aide sur les commandes CLI de eos est disponible [ici](eos_commands.md)

Une aide sur les commandes CLI de sr-linux est disponible [ici](srlinux_commands.md)

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

* Créer l'image de management des eqts :

        docker build -t lab-mgmt:latest . -f lab-mgmt.dockerfile
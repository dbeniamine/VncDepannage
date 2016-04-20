# Vnc Dépannage

Ce dépôt propose un système simple d'aide au dépannage basé sur x11vnc et ssh.

## Principe

Une personne que l'on appellera C a besoin d'assistance, elle appelle alors la
personne responsable du dépannage (D) et lance le client `./depannage-client.sh`
qui se connecte a un serveur (S).

    C --> S

D utilise le script `./depannage` pour se connecter alors au serveur puis a C
d'où il lance la VNC.

    C  --> S <-- D
    C <--> S <-- D

## Sécurité

* Le système ne marche qu'a l'initiative de C, et C peux rompre la connexion a
tout moment.
* Toutes les données passent par SSH et sont donc crypté.
* Sur le client le serveur ssh est éteint par défaut un parfeu `ufw` est
utilisé pour renforcer la sécurité.
* Sur le serveur tous les clients se connectent au même utilisateur qui a
comme shell `/bin/false`. Autrement dit cet utilisateur ne peux rien faire
d'autre qu'ouvrir une connexion sans shell.

## Installation

Cette installation suppose que vous avez déjà un serveur fonctionnel avec ssh
installé et que D peux s'y connecter via une clef rsa.

### Côté dépanneur

Clonez le dépôt:

    git clone https://github.com/dbeniamine/VncDepannage

Modifiez les variables au début des deux scripts `depannage.sh` et
`depannage-client.sh` pour utiliser votre serveur.

Installez xvn4viewer.

Vous êtes prêt !

### Côté serveur

Créez un utilisateur nommé `depannage` (par exemple) avec comme shell
`/bin/false`.

### Côté client

Clonez le dépôt:

    git clone https://github.com/dbeniamine/VncDepannage

Modifiez les variables au début des deux scripts `depannage.sh` et
`depannage-client.sh` pour utiliser votre serveur.

1. Créez une clef rsa `ssh-keygen -t rsa` et copiez la clef publique dans le
`.ssh/authorized_keys` de l'utilisateur crée préalablement sur le serveur afin
de permettre la connexion `C --> S`.
2. Installez `ssh`, `ssh-server`, `x11vnc` et `ufw`
3. Désactivez le serveur ssh: `sudo systemctl disable ssh`
4. Activez le parfeu: `sudo systemctl enable ufw`
5. Ajoutez la clef publique de l'utilisateur D sur le serveur dans le
`~/.ssh/authorized_keys` du client afin de permettre la connexion `C <-- S`
6. Placez le fichier `depannage.desktop` sur le bureau du client et modifiez
le fichier pour ajuster le chemin vers le script `depannage-client.sh`.

## Testez

* Côté client double cliquez sur le bouton depannage sur le bureau.
* Côté assistance lancez `./depannage.sh` et entrez le nom de l'utilisateur.

La Vnc devrait fonctionner.

En cas de soucis relisez cette aide, testez les différentes connexions ssh
manuellement. Si le problème persiste ouvrez une "issue".

# Licence

Ceci est un logiciel libre distribué sur licence Gpv Version 3 ou supérieur,
cf `licence.txt`.

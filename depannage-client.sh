#!/bin/bash

# Copyright (C) 2016  Beniamine, David <David@Beniamine.net>
# Author: Beniamine, David <David@Beniamine.net>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

user=depannage
host=myhost
Lport=5904
Rport=22
ufwuse=false

echo "Mise en route du serveur ssh"
sudo service ssh start
if [ ! -z "$(sudo which ufw)" ] && [ ! -z "$(sudo ufw status | grep active)" ]
then
    echo "Ouverture du parfeu"
    sudo ufw allow ssh
    ufwuse=true
fi

echo "Connexion au serveur d'aide"
echo "Tapez Ctrl+C pour interompre la connexion"
ssh $user@$host -R $Lport:localhost:$Rport -N

echo "Connexion terminée"
echo "Extinction du serveur ssh"
sudo service ssh stop
if $ufwuse
then
    echo "Restauration du parefeu"
    sudo ufw delete allow ssh
fi
echo "Arret de toutes les connexions vnc encore actives"
killall x11vnc
echo "Depannage terminé, au revoir"

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


host0="myhost"
args0="-A"
tun0="-L 5902:localhost:5901"

host1="localhost"
args1="-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p 5904"
tun1="-L 5901:localhost:5900"

echo "Please enter the name of the user you want to help"
read user
(sleep 10 && xvnc4viewer 127.0.0.1:5902) &

ssh $args0 $tun0 $host0 ssh $args1 $tun1 $user@$host1 x11vnc -display :0

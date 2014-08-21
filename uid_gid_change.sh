#!/bin/bash
if [[ $# -lt 4 ]] ; then
    echo 'Usage: uid_gid_change.sh <username> <group name> <new UID> <new GID>'
    exit 0
fi
OLD_UID=$(grep $1 /etc/passwd | cut -d ':' -f 3)
OLD_GID=$(grep $1 /etc/passwd | cut -d ':' -f 4)

usermod -u $3 $1    
groupmod -g $4 $2
find / -user $OLD_UID -exec chown -h $3 {} \;
find / -group $OLD_GID -exec chgrp -h $4 {} \;
usermod -g $4 $1


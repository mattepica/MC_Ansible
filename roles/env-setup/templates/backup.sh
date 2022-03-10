#!/bin/bash

 function rcon {
 	 /opt/shared/mcrcon/mcrcon -H 127.0.0.1 -P 25576 -p {{ mc_pwd }} "$1"
 }

 FILENAME="server-"$(date +%F-%H-%M)".tar.gz"
 rcon "save-off"
 rcon "save-all"
 tar -cvpzf {{ users[0].home }}/backups/$FILENAME {{ users[0].home }}/server
 rcon "save-on"

 ## Delete older backups
 find {{ users[0].home }}/backups/ -type f -mtime +7 -name '*.gz' -delete
 echo $FILENAME > {{ users[0].home }}/backups/lastFile.dat

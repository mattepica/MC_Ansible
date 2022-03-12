#!/bin/bash

 function rcon {
 	 /opt/shared/mcrcon/mcrcon -H 127.0.0.1 -P 25576 -p {{ mcc_pwd }} "$1"
 }

 FILENAME="server-"$(date +%F-%H-%M)".tar.gz"
 rcon "save-off"
 rcon "save-all"
 tar -cvpzf {{ dir }}/backups/$FILENAME {{ dir }}/server
 rcon "save-on"

 ## Delete older backups
 find {{ dir }}/backups/ -type f -mtime +7 -name '*.gz' -delete
 echo $FILENAME > {{ dir }}/backups/lastFile.dat

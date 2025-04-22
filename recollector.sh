#!/bin/bash

if [ $2 ]; then
    NAME_DIR=$2
else
    NAME_DIR="$1.0"
fi

FILE=$SCRIPT_DIR/logs/red/$NAME_DIR/all_pings.log
LOG_FILE=$SCRIPT_DIR/logs/red/$NAME_DIR/valid_ip.log

if [ ! -d $SCRIPT_DIR/logs/red/$NAME_DIR ]; then
    mkdir -p $SCRIPT_DIR/logs/red/$NAME_DIR
fi
touch $FILE
rm -f $LOG_FILE
touch $LOG_FILE

for IP in $(seq 1 254); do
    {
        echo "Pinging $1.$IP"
        SYSTEM="fallo"
        ping -c 1 $1.$IP | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 >>$LOG_FILE &
        HOST="$(ping -c 1 $1.$IP | grep "bytes from" | cut -d " " -f 6 &)"
        case $HOST in
        'ttl=64')
            SYSTEM="Linux"
            ;;
        'ttl=128')
            SYSTEM="Windows"
            ;;
        esac
        NAME=$(nslookup $1.$IP | grep "name =" | cut -d "=" -f 2)
        if [ $NAME ]; then
            echo $1.$IP $NAME $SYSTEM >>$FILE
        fi
    } &
done
wait

#!/bin/bash
FILE=$SCRIPT_DIR/logs/red/$1.0/all_pings.log

if [ ! -d $SCRIPT_DIR/logs/red/$1.0 ]; then
    mkdir -p $SCRIPT_DIR/logs/red/$1.0
fi
touch $FILE

for IP in `seq 1 254`; do {
    echo "Pinging $1.$IP"
    SYSTEM="fallo"
    ping -c 1 $1.$IP | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 >> $SCRIPT_DIR/logs/red/$1.0/valid_ip.log &
    HOST="$(ping -c 1 $1.$IP | grep "bytes from" | cut -d " " -f 6 &)"
    case $HOST in
     'ttl=64')
        SYSTEM="Linux"
        ;;
     'ttl=128')
        SYSTEM="Windows"
        ;;
    esac
    NAME=`nslookup $1.$IP | grep "name =" | cut -d "=" -f 2`
    if [ $NAME ]; then
        echo $1.$IP $NAME $SYSTEM >> $FILE
    fi
} &
done
wait
#!/bin/bash

source "$SCRIPT_DIR/utils/network.sh"

ip=""
directorio=""
netmask=""

# Parseo de argumentos
while [[ "$#" -gt 0 ]]; do
    case $1 in
    -i | --ip)
        if [[ "$2" == -* ]]; then
            echo "Error: Argumento no válido $2"
            exit 1
        fi

        ip="$2"
        shift
        ;;
    -d | --directorio)
        if [[ "$2" == -* ]]; then
            echo "Error: Argumento no válido $2"
            exit 1
        fi

        directorio="$2"
        shift
        ;;
    -n | --netmask)
        if [[ "$2" == -* ]]; then
            echo "Error: Argumento no válido $2"
            exit 1
        fi

        netmask="$2"
        shift
        ;;
    *)
        echo "Opción desconocida: $1"
        exit 1
        ;;
    esac
    shift
done

# Uso de los flags
echo "directorio: $directorio"
echo "netmask: $netmask"
echo "ip: $ip"

# ASIGNAMOS EL directorio DEL DIRECTORIO
if [ $directorio == "" ]; then
    directorio=$ip
fi

# CREAMOS EL DIRECTORIO
if [ ! -d $SCRIPT_DIR/logs/red/$directorio ]; then
    mkdir -p $SCRIPT_DIR/logs/red/$directorio
fi

# ASIGNAMOS LOS directorioS DE LOS ARCHIVOS
FILE=$SCRIPT_DIR/logs/red/$directorio/all_pings.log
LOG_FILE=$SCRIPT_DIR/logs/red/$directorio/valid_ip.log

# CREAMOS LOS ARCHIVOS
touch $FILE
rm -f $LOG_FILE
touch $LOG_FILE

PARSE_IP="$(IpToBin $ip)"

echo "PARSE_IP: $PARSE_IP"

# for IP in $(seq 1 254); do
#     {
#         echo "Pinging $1.$IP"
#         SYSTEM="fallo"
#         ping -c 1 $1.$IP | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 >>$LOG_FILE &
#         HOST="$(ping -c 1 $1.$IP | grep "bytes from" | cut -d " " -f 6 &)"
#         case $HOST in
#         'ttl=64')
#             SYSTEM="Linux"
#             ;;
#         'ttl=128')
#             SYSTEM="Windows"
#             ;;
#         esac
#         NAME=$(nslookup $1.$IP | grep "name =" | cut -d "=" -f 2)
#         if [ $NAME ]; then
#             echo $1.$IP $NAME $SYSTEM >>$FILE
#         fi
#     } &
# done
# wait

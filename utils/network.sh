function IpToBin() {
    local ip="$1"
    IFS='.' read -r o1 o2 o3 o4 <<<"$ip"
    o1=$(echo "obase=2;$o1" | bc)
    o2=$(echo "obase=2;$o2" | bc)
    o3=$(echo "obase=2;$o3" | bc)
    o4=$(echo "obase=2;$o4" | bc)
    # Asegurarse de que cada octeto tenga 8 bits
    o1=$(printf "%08d" "$o1")
    o2=$(printf "%08d" "$o2")
    o3=$(printf "%08d" "$o3")
    o4=$(printf "%08d" "$o4")
    # Imprimir la IP en binario
    echo "$o1.$o2.$o3.$o4"
}

function getNetworkIp() {
    local ip="$(echo $1 | tr -d '.')"
    local mascara=""
    local total=$2
    for j in $(seq 1 32); do
        if [[ $total -eq 0 ]]; then
            netmask="${netmask}0"
        else
            total=$((total - 1))
            netmask="${netmask}1"
        fi
    done
    echo "Net: $netmask"
    echo "IP: $ip"
    resultado=$((2#$netmask & 2#$ip))
    printf "%032b\n" "$resultado"

}
# a=$((2#1101)) # 13 en decimal
# b=$((2#1011)) # 11 en decimal

# resultado=$((a & b)) # AND bit a bit

# # Mostrar el resultado en binario
# printf "%04b\n" "$resultado"

a=$(IpToBin 172.168.15.6)
getNetworkIp $a 24

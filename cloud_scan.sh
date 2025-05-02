#!/bin/bash

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <target-ip-or-hostname> <service-type>"
    echo "Available service types: ec2, rds, k8s, docker, storage, lb, vpn, monitoring, marketplace, full"
    exit 1
fi

TARGET=$1
SERVICE=$2

declare -A PORTS
PORTS[ec2]="22,80,443,8080,8443,3306,5432,27017,3389"
PORTS[rds]="3306,33060,5432,27017,1433,1521"
PORTS[k8s]="6443,10250,10255,10257,10259,8472"
PORTS[docker]="2375,2376,4789,7946"
PORTS[storage]="80,443,8080,9000,9443"
PORTS[lb]="80,443,8080,8000,8888,8443"
PORTS[vpn]="22,1194,443,500,4500,1701,1723"
PORTS[monitoring]="5601,9200,5044,9090,3000"
PORTS[marketplace]="80,443,8000-8100,9000-9100"

echo "[*] Scanning target: $TARGET"
echo "[*] Service type: $SERVICE"

if [[ "$SERVICE" == "full" ]]; then
    echo "[*] Running full TCP scan (all ports)..."
    nmap -sS -Pn -T4 -p- "$TARGET" -oA "scan-$TARGET-full"
else
    PORT_RANGE=${PORTS[$SERVICE]}
    if [[ -z "$PORT_RANGE" ]]; then
        echo "[!] Invalid service type: $SERVICE"
        exit 2
    fi
    echo "[*] Scanning ports: $PORT_RANGE"
    nmap -sS -Pn -T4 -p "$PORT_RANGE" "$TARGET" -oA "scan-$TARGET-$SERVICE"
fi

echo "[*] Scan complete. Output saved to scan-$TARGET-$SERVICE.*"

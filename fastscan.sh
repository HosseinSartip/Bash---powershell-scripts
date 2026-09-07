#!/bin/bash
# Simple Bash TCP Port Scanner
# chmod +x fastscan.sh
# Usage: ./fastscan.sh <IP> <START_PORT> <END_PORT>
# ./fastscan.sh 192.168.1.10 1 65535

TARGET=$1
START=$2
END=$3

scan_port() {
    PORT=$1

    timeout 1 bash -c "echo >/dev/tcp/$TARGET/$PORT" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "OPEN: $PORT"
    fi
}

export TARGET

for PORT in $(seq $START $END)
do
    scan_port $PORT &
done

wait

echo "Finished."

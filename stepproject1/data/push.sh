#!/bin/bash
function send_push_gw () {
        cat << EOF | curl --data-binary @- http://localhost:9091/metrics/job/my-job/instance/localhost
        my_disk_usage $1
EOF
}
while true; do
        DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)
        send_push_gw $DISK_USAGE
        sleep 5
done


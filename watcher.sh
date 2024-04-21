#!/bin/bash
NAMESPACE="sre"
DEPLOYMENT="swype-app"
MAX_RESTARTS=4

while true; do
    NUM_RESTARTS=$(kubectl get pods -n ${NAMESPACE} -l app=${DEPLOYMENT} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")
    echo "$DEPLOYMENT has $NUM_RESTARTS restarts"
    if [ $NUM_RESTARTS -ge $MAX_RESTARTS ]; then
        echo "$DEPLOYMENT has exceeded $((MAX_RESTARTS - 1)) restarts"
        kubectl scale deployment ${DEPLOYMENT} -n ${NAMESPACE} --replicas=0
        break
    fi
    sleep 60s
done
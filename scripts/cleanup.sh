#!/bin/bash

evicted_pods=$(kubectl get pods --all-namespaces --field-selector=status.phase=Failed | grep Evicted | awk '{print $2}')

for pod in $evicted_pods; do
  kubectl delete pod $pod --namespace=$(kubectl get pods --all-namespaces --field-selector=status.phase=Failed | grep $pod | awk '{print $1}')
done

echo "Evicted pods cleanup completed."
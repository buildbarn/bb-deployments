#!/bin/bash
kubectl apply -f bb-namespace.yaml
for file in config/*.yaml; do
  kubectl apply -f $file
done
for file in *.yaml; do
  kubectl apply -f $file
done

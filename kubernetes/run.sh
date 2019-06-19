#!/bin/bash
kubectl create -f bb-namespace.yaml
for file in config/*.yaml; do
  kubectl create -f $file
done
for file in *.yaml; do
  kubectl create -f $file
done

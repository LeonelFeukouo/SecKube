#!/bin/sh

decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | base64 -d
}

echo "Enter token: "
read TOKEN
echo "Enter kubernetes API host:"
read K8S

echo "Creating configuration for https://$K8S"

DECODE=$(decode_base64_url $(echo -n $TOKEN | cut -d "." -f 2) | jq .)

echo "With token:"
echo $DECODE

echo "Press any key to continue..."
read continue

if [ -f kubeconfig ]
then
	rm ./kubeconfig
fi
touch ./kubeconfig
export KUBECONFIG=./kubeconfig
kubectl config set-credentials seckube --token="$TOKEN" 
kubectl config set-cluster exploited --insecure-skip-tls-verify=true --server=https://$K8S
kubectl config set-context exploited --cluster=exploited --user=seckube
kubectl config use-context exploited
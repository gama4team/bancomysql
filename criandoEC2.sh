#!/bin/bash

cd 0-terraform
/usr/bin/terraform init
/usr/bin/terraform fmt
/usr/bin/terraform apply -auto-approve

echo "Aguardando criação de maquinas ..."
sleep 10 # 10 segundos

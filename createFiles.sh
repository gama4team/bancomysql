cd 0-terraform

echo "[ec2-db]" > ../1-ansible/hosts # cria arquivo
echo "$(/usr/bin/terraform output | grep private | awk '{print $2;exit}')" >> ../1-ansible/hosts # captura output faz split de espaco e replace de ",

echo "Aguardando criação de maquinas ..."
sleep 20 # 20 segundos

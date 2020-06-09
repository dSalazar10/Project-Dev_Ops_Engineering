echo "Enter the Bastion Host's Public IP Address:"
read BIP
PROJ=$PWD
cd ~/Downloads/
chmod 400 bastion-key.pem
scp -i bastion-key.pem jenkins-key.pem ubuntu@$BIP:/home/ubuntu/jenkins-key.pem
scp -i bastion-key.pem $PROJ/banner.txt ubuntu@$BIP:/etc/update-motd.d/00-header
ssh -i bastion-key.pem ubuntu@$BIP
#rm bastion-key.pem
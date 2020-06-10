echo "Enter the Bastion Host's Public IP Address:"
read BIP
PROJ=$PWD
cd ~/Downloads/
chmod 400 bastion-key.pem
echo $'Copying the Jenkins Key and Login Script...\n'
scp -i bastion-key.pem jenkins-key.pem ubuntu@$BIP:/home/ubuntu/jenkins-key.pem
scp -i bastion-key.pem $PROJ/Remote/banner.txt ubuntu@$BIP:/home/ubuntu/jenkins-login.sh
scp -i bastion-key.pem $PROJ/Remote/setup.txt ubuntu@$BIP:/home/ubuntu/setup.sh
echo $'Logging Into Secure Shell...\n'
ssh -i bastion-key.pem ubuntu@$BIP
#rm bastion-key.pem
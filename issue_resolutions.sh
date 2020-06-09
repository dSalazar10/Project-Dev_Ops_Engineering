This will create a plugin file and fill it with some useful plugins and then automatically install it
sudo touch /usr/share/jenkins/plugins.txt && sudo /bin/su -c "echo $'aqua-microscanner\nblueocean\npipeline-aws\nsaferestart' >> /usr/share/jenkins/plugins.txt" && /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt;

Memory Issues With Docker in EC2:
1) This will expand the storage to 500GiB for all docker images
sudo /bin/su -c "echo $'{\n\t\"storage-driver\" : \"aufs\",\n\t\"storage-opts\" : [\"dm.basesize=500G\"]\n}' > /etc/docker/daemon.json && systemctl daemon-reload && systemctl restart docker && chmod 666 /var/run/docker.sock" 
2) This is how you expand the EBS Volume in AWS: 
- Navigate to ec2
- Look at the details of your instance and locate root device and block device
- click on the path and select EBS ID
- click actions in the volume panel
- select modify volume
- enter the desired volume size
- ssh into instance
- run lsblk to see available volumes and note the size
- run sudo growpart /dev/xvda1 1 on the volume you want to resize
- run sresize2fs /dev/xvda1


Docker images used in pipeline:
- beevelop/ionic
- node:12

If jenkins complains about permissions
sudo echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

To restart docker
systemctl daemon-reload && systemctl restart docker && chmod 666 /var/run/docker.sock

Visualize docker memory usage
docker system df
cd /var/lib/docker && du -shc *

Bring up ec2 with following qualities:
1. Inbound runes 22, 33222
2. IAM instance profile minecraft-server
3. Termination protection on - it's a pet :)

IAM user for start/stop:
1. modify to only work on this server

Cloudwatch events scheduled to:
1. Take a snapshot of the root volume nightly
2. Stop every day at 20:00 - let's not run up bills

SSH to ec2 and do the following:
```
sudo su -
cd /opt/
tar tf /tmp/minecraft.tar.gz 
tar xf /tmp/minecraft.tar.gz 
useradd minecraft
systemctl enable /opt/minecraft/minecraft.service
systemctl enable /opt/minecraft/minecraft-update-ip.service
systemctl status minecraft
systemctl status minecraft-update-ip
apt install unzip
cd /tmp/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
/usr/local/bin/aws --version
apt install default-jre
java -version
apt upgrade
cd /opt/minecraft/
tail -f minecraft.log 
```
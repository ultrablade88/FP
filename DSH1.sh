#!/bin/bash 
sudo yum update -y
sudo yum install git -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo hostnamectl set-hostname DSH1
sudo usermod -a -G docker ec2-user
sudo su -
usermod -a -G root ec2-user
sudo su - ec2-user
sudo chmod 777 /etc/environment
{
echo " export REGION=$(curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//') " 
echo " export INSTANCE_ID=$(curl -s 169.254.169.254/latest/meta-data/instance-id)" 
echo " export AZ=$(curl -s 169.254.169.254/latest/meta-data/placement/availability-zone) "
echo " export AMI_ID=$(curl -s 169.254.169.254/latest/meta-data/ami-id) "
echo " export INSTANCE_TYPE=$(curl -s 169.254.169.254/latest/meta-data/instance-type) "
echo " export MAC=$(curl -s 169.254.169.254/latest/meta-data/mac)" 
} >> /etc/environment
source /etc/environment
{
echo " export VPC_ID=$(curl -s 169.254.169.254/latest/meta-data/network/interfaces/macs/"$MAC"/vpc-id)"
echo " export SG_ID=$(curl -s 169.254.169.254/latest/meta-data/network/interfaces/macs/"$MAC"/security-group-ids)"  
echo " export KEY_PAIR=$(curl -s 169.254.169.254/latest/meta-data/public-keys | sed 's/0=//')" 
echo " export SUBNET_ID=$(curl -s 169.254.169.254/latest/meta-data/network/interfaces/macs/"$MAC"/subnet-id)" 
} >> /etc/environment
source /etc/environment
aws autoscaling create-launch-configuration --launch-configuration-name DSHLC --image-id "$AMI_ID" --instance-type "$INSTANCE_TYPE" --security-groups "$SG_ID" --key-name "$KEY_PAIR" --region "$REGION"
aws autoscaling create-auto-scaling-group --auto-scaling-group-name DSHAS --launch-configuration-name DSHLC --min-size 0 --max-size 3 --desired-capacity 0 --availability-zones "$AZ" --vpc-zone-identifier "$SUBNET_ID" --region "$REGION"
aws autoscaling attach-instances --instance-ids "$INSTANCE_ID" --auto-scaling-group-name DSHAS --region "$REGION"
docker swarm init 
DSM=$(docker swarm join-token manager)
DSW=$(docker swarm join-token worker)
aws ssm put-parameter  --name 'MT' --type SecureString --value "{$DSM}" --region $REGION
aws ssm put-parameter  --name 'WT' --type SecureString --value "{$DSW}" --region $REGION
sleep 3m
docker service create --replicas 5 -p 8080:80 --name nginx nginx:alpine
$ git clone https://github.com/stefanprodan/swarmprom.git
$ cd swarmprom

ADMIN_USER=admin \
	ADMIN_PASSWORD=admin \
	SLACK_URL=https://hooks.slack.com/services/TOKEN \
	SLACK_CHANNEL=devops-alerts \
	SLACK_USER=alertmanager \
docker stack deploy -c docker-compose.yml 


sleep 17m
aws ssm delete-parameter --name 'WT' --region $REGION
aws ssm delete-parameter --name 'MT' --region $REGION
aws autoscaling delete-auto-scaling-group --auto-scaling-group-name DSHAS
aws autoscaling delete-launch-configuration  ----launch-configuration-name  DSHLC


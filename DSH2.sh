#!/bin/bash 
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo hostnamectl set-hostname DSH2
sudo usermod -a -G docker ec2-user
sudo su -
usermod -a -G root ec2-user
sudo su - ec2-user
sudo chmod 777 /etc/environment
{
echo " export REGION=$(curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//') " 
echo " export INSTANCE_ID=$(curl -s 169.254.169.254/latest/meta-data/instance-id)" 
} >> /etc/environment
source /etc/environment
sleep 2m
aws autoscaling attach-instances --instance-ids "$INSTANCE_ID" --auto-scaling-group-name DSHAS --region $REGION
MT=$(aws ssm get-parameter  --name 'MT' --with-decryption --query 'Parameter.Value' --output text --region $REGION  | sed 's/[{}]//g' )
eval "$MT"

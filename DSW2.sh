#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo hostnamectl set-hostname DSW2
sudo usermod -a -G docker ec2-user
sudo su -
sudo su - ec2-user
usermod -a -G root ec2-user
{
echo "export REGION=$(curl -s 169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//') "
echo " export INSTANCE_ID=$(curl -s 169.254.169.254/latest/meta-data/instance-id)" 
} >> /etc/environment
source /etc/environment
sleep 2m
aws autoscaling attach-instances --instance-ids "$INSTANCE_ID" --auto-scaling-group-name DSWAS --region $REGION
WT=$(aws ssm get-parameter  --name 'WT' --with-decryption --query 'Parameter.Value' --output text --region $REGION | sed 's/[{}]//g' )
eval "$WT"


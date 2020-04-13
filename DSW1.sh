#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo hostnamectl set-hostname DSW1
sudo chmod 777 /etc/environment
sudo usermod -a -G docker ec2-user
sudo su -
sudo su - ec2-user
usermod -a -G root ec2-user


#recive dynamic information

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
echo " export SG_ID=$(curl -s 169.254.169.254/latest/meta-data/network/interfaces/macs/"$MAC"/security-group-ids)"  
echo " export KEY_PAIR=$(curl -s 169.254.169.254/latest/meta-data/public-keys | sed 's/0=//')" 
echo " export SUBNET_ID=$(curl -s 169.254.169.254/latest/meta-data/network/interfaces/macs/"$MAC"/subnet-id)" 
} >> /etc/environment
source /etc/environment

#create Lunch Configuration

aws autoscaling create-launch-configuration --launch-configuration-name DSWLC --image-id "$AMI_ID" --instance-type "$INSTANCE_TYPE" --security-groups "$SG_ID" --key-name "$KEY_PAIR" --region "$REGION"

#create ASG & attch instance to ASG

aws autoscaling create-auto-scaling-group --auto-scaling-group-name DSWAS --launch-configuration-name DSWLC --min-size 0 --max-size 4 --desired-capacity 0 --availability-zones "$AZ" --vpc-zone-identifier "$SUBNET_ID" --region "$REGION"
aws ec2 replace-iam-instance-profile-association --FPM_role-instanceprofile --iam-instance-profile Name=YourReplacementRole-Instance-Profile  --region "$REGION"
aws autoscaling attach-instances --instance-ids "$INSTANCE_ID" --auto-scaling-group-name DSWAS --region $REGION
sleep 2m

#Docker Swarm

WT=$(aws ssm get-parameter  --name 'WT' --with-decryption --query 'Parameter.Value' --output text --region $REGION | sed 's/[{}]//g' )
eval "$WT"


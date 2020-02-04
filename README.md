# FP

Use Jenkins (freestyle or pipeline is up to you) with Terraform or Cloud Formation to create the following infrastructure:
1. VPC 172.20.0.0/20
3. 2 Subnets covering 3 AZ's, each one of size /24
3. Internet Gateway, routing tables, security groups, autoscaling groups, target groups, IAM role.
4. Automatically create an autoscaling group and install 2 docker swarm hosts in it and automatically create a swarm cluster.
5. Automatically configure autoscaling group which starts 3 docker swarm worker nodes and automate their join to the cluster.
6. Automate the creation of a Route53 private hosted zone.
7. Make sure each server registers itself in that private route53 hostedzone using a userdata script.
8. Using Ansible, make sure all servers operating systems are fully updated and installed with vim, htop, sysstat.
9. Automatically create an nginx service in the swarm cluster (make sure that SG's are allowing access).
10. Automate the deployment of "swarmprom" project inside the swarm cluster.

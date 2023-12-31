# Minecraft-Deployment

A fully automated deployment of a minecraft server utilizing infrastructure as code. The provisioning and deployment of the instance is done using Terraform. While the automation of the minecraft server itself is done using Ansible. Using these two tools you can have a fully automated setup of a Minecraft server.

### Broad Overview
The security groups are configured to allow inbound/outbound traffic on ports 25565 & 22 from CIDR 0.0.0.0/0 AKA anywhere so be careful.
###
The following things need to be pre-installed on the system
1. AWS CLI
2. Terraform
3. Ansible
###
The deployment is broken up into essentially two parts Terraform and Ansible. 
Terraform is used to provision the AWS instance which includes the security group rules and public key assigned to the instance.
On the other hand, Ansible is used once the instance has been created in order to download the server files and setup the systemd service.
Important to note, Ansible creates a systemd service called "mcserver.service" which handles the Minecraft server java process.
The systemd service has benefits such as the fact that it auto starts the Minecraft server on startup.

###
The following things need to be pre-configured on the AWS side of things. 
1. You need to have a SSH public and private key already created. The public key will be added to the variables.tf file as explained below.
2. Your AWS credentials need to be placed in your .aws/credentials file. The location of the .aws/credentials file depends on the system. Although on MacOS it's located at ```~/.aws/credentials```

## Setup
1. Clone the repository locally
2. Put your aws credentials in .aws/credentials


## Terraform
1. Navigate to Minecraft-Deployment/Terraform/
2. Run ```terraform init``` This should intialize the project for Terraform through your account.
3. Edit the variables.tf file and change the ssh_public_key variable so that default = is assigned to your SSH public key.
4. Run ```terraform apply``` You'll be prompted to confirm the action type "yes" if you agree.
5. Once the Terraform deployment finishes you should see "Apply complete" followed by 
```
Outputs:
instance_id = "{ID}"
instance_public_ip = "{IP}"
```
6. Copy the IP address displayed in the output as "instance_public_ip"

## Ansible
1. Navigate to Minecraft-Deployment/Ansible/
2. Run ```ansible-playbook main.yaml -i {ip},``` Where {ip} is the ip address you copied. Notice the trailing comma and make sure to include it because Ansible requires the IPs to be in the form of a list.
3. You'll be prompted to add the SSH key to your known_hosts file. Type "yes" if you agree.
4. Wait till the Ansible playbook finishes and you should see the value ```ok=12``` on your first run.

## Once finished
It can take up to 5 minutes for the Minecraft server to be up and running. Although, the TTL depends on system specs/instance flavor chosen.

### Resources Cited
1. https://www.digitalocean.com/community/tutorials/how-to-create-a-minecraft-server-on-ubuntu-22-04

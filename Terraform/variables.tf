variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  #Change this value to change the name of the instance
  default     = "Minecraft-Deployment"
}

variable "instance_flavor" {
  description = "Instance flavor to use on AWS"
  type        = string
  #Change this value to change the name of the instance
  default     = "t2.small"
}

variable "ssh_key_name" {
  description = "Name of the SSH key to assign to the instance"
  type        = string
  #Change this value to change the SSH key which will be added to the instance. (Must be already imported on account)
  default     = "minecraft_key"
}

variable "ssh_public_key" {
  description = "Name of the SSH key to assign to the instance"
  type        = string
  #Change this value to change the SSH key which will be added to the instance. (Must be already imported on account)
  default     = "change"
}
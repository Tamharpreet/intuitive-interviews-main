############################
# VPC
############################

module "vpc" {
    source = "./modules/vpc"
    region = var.region
    admin_password = var.admin_password
    admin_username = var.admin_username
}


############################
# S3
############################

module "s3" {
    source = "./modules/s3"
    region = var.region
   
}



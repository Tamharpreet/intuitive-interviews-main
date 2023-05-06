############################
# Virtual Networks
############################

module "virtual-network" {
    source = "./modules/virtual-network"
    location = var.location
    admin_password = var.admin_password
    admin_username = var.admin_username
}


############################
# Storage Account
############################

module "storage-account" {
    source = "./modules/storage-account"
    location = var.location
    account_tier = var.account_tier
}



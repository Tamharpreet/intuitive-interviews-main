variable "location" {
    type = string
}
variable "account_tier" {
    type = string
}
variable "admin_password" {
    type = string
    sensitive = true
}
variable "admin_username" {
    type = string
}

variable "bucket_name" {
    type = string
}
variable "key_name"{
    type = string
    sensitive = true
}

variable "region" {
    type = string
}
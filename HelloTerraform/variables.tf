variable "vpc_name" {
  default = "minhquang-tf-vpc"
}

variable "cidrvpc" {
    default = "10.0.0.0/16"
}

variable "tags" {
    default = {
        Name = "minhquang-tf-vpc"
        Owner="minhquang"
    }
}

variable "az_count" {
    default = 3
}
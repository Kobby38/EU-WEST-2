variable "region-name" {
    description = "made region a variable"
    default = "eu-west-2"
    type=string
  }

variable "cidr-for-vpc" {
    description = "the-cidr for-eu-west-2-for-vpc"
    default = "10.0.0.0/16"
    type=string
  }

variable "cidr-for-public-subnet-1" {
    description = "public cidr"
    default = "10.0.100.0/24"
    type=string
  }

variable "AZ-1" {
    description = "availability zone"
    default = "eu-west-2a"
    type=string
  }

variable "cidr-for-public-subnet-2" {
    description = "public cidr"
    default = "10.0.102.0/24"
    type=string
  }

variable "AZ-2" {
    description = "availability zone"
    default = "eu-west-2b"
    type=string
  }

variable "cidr-for-public-subnet-3" {
    description = "public cidr"
    default = "10.0.103.0/24"
    type=string
  }

variable "AZ-3" {
    description = "availability zone"
    default = "eu-west-2c"
    type=string
  }

variable "cidr-for-private-subnet-1" {
    description = "private cidr"
    default = "10.0.110.0/24"
    type=string
  }

variable "AZ-4" {
    description = "availability zone"
    default = "eu-west-2a"
    type=string
  }

variable "cidr-for-private-subnet-2" {
    description = "private cidr"
    default = "10.0.111.0/24"
    type=string
  }

variable "AZ-5" {
    description = "availability zone"
    default = "eu-west-2b"
    type=string
  }

variable "internet-gateway-association" {
    description = "association of internet gateway with route"
    default = "0.0.0.0/0"
    type=string
  }

variable "elastic-ip" {
    description = "elastic ip for NAT Gateway"
    default = "10.0.0.6"
    type=string
  }

variable "eip" {
    description = "elastic ip for NAT Gateway"
    default = "10.0.0.6"
    type=string
  }
  
variable "nat-gateway-destination-cidr-block" {
    description = "destination route for nat gateway"
    default = "0.0.0.0/0"
    type=string
  }

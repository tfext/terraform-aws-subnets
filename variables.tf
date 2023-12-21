variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
  description = "VPC to create the subnets in"
}

variable "cidr_block" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Parent CIDR block. A block for each subnet will be calculated using subnet_cidr_bits. Mutually exclusive with cidr_blocks."
}

variable "subnet_cidr_bits" {
  type    = number
  default = 2
  description = "Number of CIDR bits to use for the subnet"
}

variable "route_table_ids" {
  type = list(string)
  description = "One or more route tables to add the subnets to"
}

variable "subnet_count" {
  type = number
  description = "Number of subnets to create"
}

variable "subnet_type" {
  type    = string
  default = "private"
  description = "Create either public or private subnets"
}

variable "extra_tags" {
  type    = map(string)
  default = null
  description = "Additional tags to add to the subnets"
}

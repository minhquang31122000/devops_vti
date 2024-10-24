
env_prefix                             = "dev"
vpc_name                               = "mq-peter-vpc"
cidrvpc                                = "10.0.0.0/16"
enable_nat_gateway                     = true
single_nat_gateway                     = true
enable_dns_hostnames                   = true
create_database_subnet_group           = true
create_database_subnet_route_table     = true
create_database_internet_gateway_route = true
enable_flow_log                        = true
create_flow_log_cloudwatch_iam_role    = true
create_flow_log_cloudwatch_log_group   = true
eks_config = {
  cluster_name                                   = "mq-petereks"
  cluster_version                                = "1.30"
  min_size                                       = 3
  max_size                                       = 9
  eks_managed_node_group_defaults_instance_types = ["t2.large", "t2.medium", "t2.xlarge"]
  instance_type                                  = "t2.medium"
  instance_types                                 = ["t2.large", "t2.medium", "t2.xlarge"]
  manage_aws_auth_configmap                      = true
  endpoint_public_access                         = true
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::629526135429:user/joe-dev"
      username = "joe-dev"
      groups   = ["system:masters"]
    },
  ]
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"],
  eks_cw_logging                       = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}
vm-config = {
  vm1 = {
    instance_type = "t2.small",
    tags = {
      "ext-name" = "vm2"
      "funct"    = "purpose test"
    }
  },
  vm2 = {
    instance_type = "t2.medium",
    tags          = {}
  }
}
bastion_definition = {
  "bastion" = {
    associate_public_ip_address = false
    bastion_ami                 = "ami-0d9144c9f9b4eea3b"
    bastion_instance_class      = "t3.medium"
    bastion_monitoring          = true
    bastion_name                = "bastion"
    bastion_public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqHr3P6FDNyOcPmchBp0HCfJIum76yvxd9jYBva2i02Xop0EPwulCj7PNVy1j7p88xMo5OEtOcf3jV/xmlQJwZHO4FVX1c1KI8iFjrEg3UTRfy0maLCsljSbfhJYZ40yWtLAFOfUiaR3l5X2ziGXnjXgiEHRi2uHl1voziSpCxP/y1w5aB8cZMnuSIN8pZS+q6B7bS6oYy0S9BE3OkdstDobunQZOmfvK3KCg+JWn6NQDvoNkCc6wk2E455KINO1ZtJApteYVUXSHRwkEe4DQxVy1sXfqee2rbrJdn3dIdBDNEVOsdhEGt2B3FAQpQ/mqYGRUTagC2Y6fbQF1s9lSTlyhLNOljDBH4MpBoCWfadjPS+hY808qbZbQIulw2NyyIc6LLLpuoiIpFJodd+eH6q8OGn9pCwNeFgxdzbFXvDD5OiKamO0eQND/pHGbh3uXbYObIsvQznu/K9kR2p9d5pxdW/ADCPF8xi4D77yT5rqqqygYPHAY3+VESB9zvW5GaRs4MCS7c4e7Yd4onpQw8vvvV/ZvPYNOmbzC1L9beP9LaBAJqlM+VT5K+f6rCNlbNFd7y0k8CMpsT0vWWB3Q2D2iV8Fr2XGBwuSnSlWHY0hYMHwJqhYwD02xA+WY/Rk097oRqVwd5w6yeOnxkrIkXYBxVu05C2+MCAZjtqJvD7w== minhquang311255@gmail.com"
    trusted_ips                 = ["118.68.122.237/32"]

    user_data_base64 = null
    ext-tags = {
      "fucnt" = "mq-peter-demo-tf"
    }
  }
}
cluster_endpoint_public_access = true

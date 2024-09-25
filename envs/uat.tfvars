vpc_name = "dev_env"
cidrvpc  = "20.0.0.0/16"
vm-config = {
  vm1 = {
    instance_type = "t2.medium",
    tags = {
      "ext-name" = "vm2"
    }
  },
  vm2 = {
    instance_type = "t2.large",
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
    user_data_base64            = null
    ext-tags = {
      "fucnt" = "minhquang-demo-tf"
    }
  }
}

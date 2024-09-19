output "bastion_key_pair_name" {
  value = aws_key_pair.bastion_keypair.key_name
}

output "bastion_public_ip" {
  value = module.ec2_instance.public_ip
}

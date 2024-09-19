resource "aws_key_pair" "bastion_keypair" {
  key_name   = var.bastion_name
  public_key = var.bastion_public_key
  tags       = var.default_tags
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                        = var.bastion_name
  associate_public_ip_address = var.associate_public_ip_address
  ami                         = var.bastion_ami
  instance_type               = var.bastion_instance_class
  subnet_id                   = var.public_subnet_id
  user_data_base64            = var.user_data_base64
  volume_tags                 = var.default_tags
  tags                        = var.default_tags
  monitoring                  = var.bastion_monitoring
  key_name                    = aws_key_pair.bastion_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-2"
}

## Creates an AWS Lightsail Instance.
resource "aws_lightsail_instance" "lightsail_instance" {
  name              = "instance_name" ## Name of lightsail instance in AWS
  availability_zone = "ap-southeast-sa"
  blueprint_id      = var.lightsail_blueprints["wordpress"] ## Options for "wordpress", "wordpress_multi" or "nginx"
  bundle_id         = "nano_2_0"                            ## Options for instance size
}

## Creates a static public IP address on Lightsail
resource "aws_lightsail_static_ip" "static_ip" {
  name = "static_ip_name" ## Name of static IP in AWS
}

## Attaches static IP address to Lightsail instance
resource "aws_lightsail_static_ip_attachment" "static_ip_attach" {
  static_ip_name = aws_lightsail_static_ip.static_ip.id
  instance_name  = aws_lightsail_instance.lightsail_instance.id
}


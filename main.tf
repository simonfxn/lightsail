provider "aws" {
  profile = "default"
  region  = "ap-southeast-2"
}


resource "aws_lightsail_key_pair" "skypc_key_pair" {
  name = "skypc_key_pair"
}

resource "aws_lightsail_instance" "web_skypc" {
  name              = "web_skypc"
  availability_zone = "ap-southeast-2a"
  blueprint_id      = "wordpress"
  bundle_id         = "nano_2_2"
  key_pair_name     = "skypc_key_pair"
  depends_on    = [aws_lightsail_key_pair.skypc_key_pair]
  tags = {
    Name = "Skypc Web"
  }
}



resource "aws_lightsail_instance_public_ports" "web_80_443" {
  instance_name = aws_lightsail_instance.web_skypc.name

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

    port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }

    port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
}





resource "aws_lightsail_static_ip" "skypc_ip" {
  name = "skypc_ip"
}

resource "aws_lightsail_static_ip_attachment" "attach_ip" {
  static_ip_name = aws_lightsail_static_ip.skypc_ip.id
  instance_name  = aws_lightsail_instance.web_skypc.id
}


output "ip" {
  value = "${aws_lightsail_static_ip.skypc_ip.ip_address}"
}

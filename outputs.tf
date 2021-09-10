output "ip" {
  value = "${aws_lightsail_static_ip.skypc_ip.ip_address}"
}

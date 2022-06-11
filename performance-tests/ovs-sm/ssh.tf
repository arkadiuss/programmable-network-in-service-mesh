resource "tls_private_key" "cluster_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "private_key" {
    content  = tls_private_key.cluster_keypair.private_key_openssh
    filename = "private_key.pem"
}
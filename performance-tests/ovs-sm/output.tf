resource "local_file" "private_key" {
  content  = tls_private_key.cluster_keypair.private_key_openssh
  filename = "private_key.pem"
  file_permission = "0600"
}

output "az_bastion_connect_command" {
  value = "az network bastion ssh --name \"${azurerm_bastion_host.k8s_cluster_bastion.name}\" --resource-group \"${azurerm_resource_group.main.name}\" --target-resource-id \"/subscriptions/9f460d30-ff1a-42a0-b396-a091b6bdd620/resourceGroups/ovs-sm-rg/providers/Microsoft.Compute/virtualMachineScaleSets/ovs-sm-vmss/virtualMachines/1\" --auth-type \"ssh-key\" --username \"${azurerm_linux_virtual_machine_scale_set.k8s_cluster.admin_username}\" --ssh-key \"${local_file.private_key.filename}\""
}
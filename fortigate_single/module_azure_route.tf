module "module_azure_route" {
  for_each = var.routes

  source = "../azure/modules/azure_route"

  resource_group_name     = module.module_azure_resource_group.resource_group.name
  name                    = each.value.name
  address_prefix          = each.value.address_prefix        
  next_hop_in_ip_address  = module.module_azure_network_interface[each.value.next_hop_in_ip_address].network_interface.private_ip_address
  next_hop_type           = each.value.next_hop_type         
  route_table_name        = each.value.route_table_name     
}

output "routes" {
  value = module.module_azure_route[*]
}
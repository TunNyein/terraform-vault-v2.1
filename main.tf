resource "vault_auth_backend" "auth_userpass" {
  for_each = local.teams
  type = each.value.auth_type
  path = each.key

}

resource "vault_generic_endpoint" "team_users" {
  for_each = local.users
  depends_on           = [vault_auth_backend.auth_userpass]
  path                 = "auth/${each.value.user_path}/users/${each.key}"
  
   
  data_json = jsonencode({
    password = each.value.password
    policies = each.value.policy     #[each.value.policy]

  })
    
}


resource "vault_mount" "kvv2-mount" {
  for_each = local.secret_mount_path

  path = each.key
  type = each.value.secret_version
}

resource "vault_kv_secret_v2" "secrets" {
  depends_on = [ vault_mount.kvv2-mount ]
  for_each = local.secrets
  mount                      = each.value.secret_mount_path
  name                       = each.key
  
  data_json                  = jsonencode(
  {
    access_key = each.value.access_key,
    secret_access_key = each.value.secret_access_key
  }
  )
}

resource "vault_policy" "policy_team1" {
  for_each = local.team_policies
  name = each.key
  policy = file (each.value.policy_cab)
  
  
}























 # Define the secret_mounts

# resource "vault_auth_backend" "auth" {
#   for_each = local.enable_auth
#   path = each.key
#   type = each.value.type

# }

# resource "vault_generic_endpoint" "u1" {
#   depends_on           = [vault_auth_backend.auth]
#   for_each             = local.users
#   path                 = "auth/${each.value.path}/users/${each.key}"
                         
#   data_json = jsonencode({
#     password = each.value.password
#   })
# }


# resource "vault_mount" "secret-path" {
#   for_each    = local.secret_mount
#   path        = each.key
#   type        = each.value.type
#   description = each.value.description
# }
 
#  resource "vault_kv_secret_v2" "secret" {
#   depends_on                 = [ vault_mount.secret-path ]
#   for_each                   = local.secrets
#   mount                      = each.value.mount
#   name                       = each.key
#   data_json                  = jsonencode(
#   {
#     access_key = each.value.access_key
#     secret_access_key = each.value.secret_access_key
#   }
#   )
  
# }
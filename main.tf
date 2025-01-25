
# Define the secret_mounts

resource "vault_auth_backend" "auth" {
  for_each = local.enable_auth
  path = each.key
  type = each.value.type

}

resource "vault_generic_endpoint" "u1" {
  depends_on           = [vault_auth_backend.auth]
  for_each             = local.users
  path                 = "auth/${each.value.path}/users/${each.key}"
                         
  data_json = jsonencode({
    password = each.value.password
  })
}


resource "vault_mount" "secret-path" {
  for_each    = local.secret_mount
  path        = each.key
  type        = each.value.type
  description = each.value.description
}
 
 resource "vault_kv_secret_v2" "secret" {
  depends_on                 = [ vault_mount.secret-path ]
  for_each                   = local.secrets
  mount                      = each.value.mount
  name                       = each.key
  data_json                  = jsonencode(
  {
    access_key = each.value.access_key
    secret_access_key = each.value.secret_access_key
  }
  )
  
}
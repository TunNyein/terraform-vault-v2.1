resource "vault_kv_secret_v2" "kvv2_team2_secret" {
  for_each = {
    "aws-master-account" = {
      username = "admin"
      password = "pa55w0rd"
      region = "singapore"
    }
    "aws-dev-account" = {
      username = "dev-admin"
      password = "dev-pa55w0rd"
      region = "japan"
    }
    "aws-shipping-account" = {
      username = "shipping-admin"
      password = "shipping-pa55w0rd"
      region = "myanmar"
    }
  }
  mount    = vault_mount.team2_kvv2_mount.path
  name     = each.key
  data_json = jsonencode(each.value)
}
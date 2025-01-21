# Enable Vault Auth Method and create Path

resource "vault_auth_backend" "devops_team1" {
  type = "userpass"
  path = "devops_team1"
}

resource "vault_generic_endpoint" "devops_team1_users" {
  for_each = {
    "user01" = {
      password = "password",
      policies: ["devops_team1_policy"]
    }
    "user02" = {
      password = "password"
      policies: ["devops_team1_policy"]
    }
  }

  path       = "auth/devops_team1/users/${each.key}"  
  depends_on = [vault_auth_backend.devops_team1]

  data_json = jsonencode({
    password = each.value.password
    policies = join(",", each.value.policies)  
  })
}


resource "vault_auth_backend" "devops_team2" {
  type = "userpass"
  path = "devops_team2"
}

resource "vault_generic_endpoint" "devops_team2_users" {
  for_each = {
    "user01" = {
      password = "password",
      "policies": ["devops_team2_policy"]
    }
    "user02" = {
      password = "password"
    }
  }

  path       = "auth/devops_team2/users/${each.key}"  
  depends_on = [vault_auth_backend.devops_team2]

  data_json = jsonencode({
    password = each.value.password
  })
}



resource "vault_auth_backend" "infra_team1" {
  type = "userpass"
  path = "infra_team1"
}

resource "vault_generic_endpoint" "infra_team1_users" {
  for_each = {
    "user01" = {
      password = "password",
      "policies": ["infra_team1_policy"]
    }
    "user02" = {
      password = "password"
    }
  }

  path       = "auth/infra_team1/users/${each.key}"  
  depends_on = [vault_auth_backend.infra_team1]

  data_json = jsonencode({
    password = each.value.password
  })
}

resource "vault_auth_backend" "infra_team2" {
  type = "userpass"
  path = "infra_team2"
}


resource "vault_generic_endpoint" "infra_team2_users" {
  for_each = {
    "user01" = {
      password = "password",
      "policies": ["infra_team2_policy"]
    }
    "user02" = {
      password = "password"
    }
  }

  path       = "auth/infra_team2/users/${each.key}"  
  depends_on = [vault_auth_backend.infra_team2]

  data_json = jsonencode({
    password = each.value.password
  })
}




# Enable Secret / Create Path / Select Secret Engine

resource "vault_mount" "kvv2-devops-team1" {
  path        = "kvv2_devops_team1"
  type        = "kv-v2"
  
}

resource "random_password" "devops_t1_password" {
  length           = 16
  special          = true
}

resource "vault_kv_secret_v2"  "aws_devrole_team1_secrets" {
   for_each = {
    "aws-master-account" = {
      username = "admin"
      password = random_password.devops_t1_password.bcrypt_hash
    }
    "aws-dev-account" = {
      username = "admin"
      password = random_password.devops_t1_password.bcrypt_hash
    }
 }
  mount = vault_mount.kvv2-devops-team1.path
  name       = each.key
  data_json = jsonencode(each.value) 
}


resource "vault_mount" "kvv2-devops-team2" {
  path        = "kvv2_devops_team2"
  type        = "kv-v2"
  
}

resource "vault_kv_secret_v2"  "aws_devrole_team2_secrets" {
   for_each = {
    "aws-master-account" = {
      username = "admin"
      password = "password"
    }
    "aws-dev-account" = {
      username = "admin"
      password = "password"
    }
 }
  mount = vault_mount.kvv2-devops-team2.path
  name       = each.key
  data_json = jsonencode(each.value) 
}


resource "vault_mount" "kvv2-infra-team1" {
  path        = "kvv2_infra_team1"
  type        = "kv-v2"
  
}

resource "vault_kv_secret_v2"  "aws_infra_team1_secrets" {
   for_each = {
    "aws-master-account" = {
      username = "admin"
      password = "password"
    }
    "aws-dev-account" = {
      username = "admin"
      password = "password"
    }
 }
  mount      = vault_mount.kvv2-infra-team1.path
  name       = each.key
  data_json = jsonencode(each.value) 
}


resource "vault_mount" "kvv2-infra-team2" {
  path        = "kvv2_infra_team2"
  type        = "kv-v2"
  
}


resource "vault_kv_secret_v2"  "aws_infra_team2_secrets" {
   for_each = {
    "aws-master-account" = {
      username = "admin"
      password = "password"
    }
    "aws-dev-account" = {
      username = "admin"
      password = "password"
    }
 }
  mount      = vault_mount.kvv2-infra-team2.path
  name       = each.key
  data_json = jsonencode(each.value) 
}


# Create Policies 

resource "vault_policy" "devops_team1_policy" {
  name = "devops_team1_policy"

  policy = <<EOT
path "kvv2_devops_team1/*" {
  capabilities = ["create", "delete", "read"]
}
EOT
}



resource "vault_policy" "devops_team2_policy" {
  name = "devops_team2_policy"

  policy = <<EOT
path "kvv2_devops_team2/*" {
  capabilities = ["create", "delete", "read"]
}
EOT
}

resource "vault_policy" "infra_team1_policy" {
  name = "infra_team1_policy"

  policy = <<EOT
path "kvv2_infra_team1/*" {
  capabilities = ["create", "delete", "read", "list"]
}
EOT
}

resource "vault_policy" "infra_team2_policy" {
  name = "infra_team2_policy"

  policy = <<EOT
path "kvv2_infra_team2/*" {
  capabilities = ["create", "delete", "read"]
}
EOT
}


# # Create Secret under path of Secret Engines
















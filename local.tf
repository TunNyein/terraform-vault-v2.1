
# Define the secret_mounts
locals {
  secret_mount = {
    "kvv2-team1" = {
      type        = "kv-v2"
      description = "Enable secret engine for team1"
    }
    "kvv2-team2" = {
      type        = "kv-v2"
      description = "Enable secret engine for team2"
    }
    "kvv2-team3" = {
      type        = "kv-v2"
      description = "Enable secret engine for team3"
    }
  }
}

# Define the secrets for each team
locals {
  secrets = {
    "aws-master" = {
      access_key      = "xxxxxeeef12"
      secret_access_key = "eefi344545"
      mount     = "kvv2-team1"  # Mapping the secret to the mount path
    }
    "aws-dev" = {
      access_key      = "xxxxxeeef12"
      secret_access_key = "eefi344545"
      mount      = "kvv2-team2"  # Mapping the secret to the mount path
    }
    "aws-prod" = {
      access_key      = "xxxxxeeef12"
      secret_access_key = "eefi344545"
      mount      = "kvv2-team3"  # Mapping the secret to the mount path
    }
  }
}



locals {
  enable_auth = {
    team1 = {
      type = "userpass"
    }

    team2 = {
      type = "userpass"
    }
     team3 = {
      type = "userpass"
    }
  }
}


locals {
  users = {
    team1_user = {
        path = "team1"
        password = "12345" 
    }
    team2_user= {
        path = "team2"
        password = "12345" 
    }
    team3_user= {
        path = "team3"
        password = "12345" 
    }
  }
}

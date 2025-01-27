locals {
  teams = {
    team1 = {
      auth_type = "userpass"
      
    }

    team2 = {
      auth_type = "userpass"
      
    }

    team3 = {
      auth_type = "userpass"
      
    }

    admin_team = {
      auth_type = "userpass"
      
    }

  }
}


locals {
  users = {
    john = {
      user_path = "team1"
      password = "Password"
      policy = "team1_policy"
    }

     david = {
      user_path = "team2"
      password = "Password"
      policy = "team2_policy"
    }
    mgmg = {
      user_path = "team3"
      password = "Password"
      policy = "team3_policy"
    }
    team1_admin = {
      user_path = "admin_team"
      password = "Password"
      policy = "master_policy"
    }
    team2_admin = {
      user_path = "admin_team"
      password = "Password"
      policy = "master_policy"
    }
    master = {
      user_path = "admin_team"
      password = "Password"
      policy = "master_policy"
    }
    
  }
}

locals {
  secret_mount_path = {
    kvv2_team1 = {
      secret_version = "kv-v2"
    }
    kvv2_team2 = {
      secret_version = "kv-v2"
    }
    kvv2_team3 = {
      secret_version = "kv-v2"
    }
  }
}

locals {
  secrets = {
    aws-master = {
      access_key = "xxxx"
      secret_access_key = "xxxxx"
      secret_mount_path = "kvv2_team1"
    }

    gcp-master = {
      access_key = "xxxx"
      secret_access_key = "xxxxx"
      secret_mount_path = "kvv2_team2"
    }
    azure-master = {
      access_key = "xxxx"
      secret_access_key = "xxxxx"
      secret_mount_path = "kvv2_team3"
    }
    azure-dev = {
      access_key = "xxxx"
      secret_access_key = "xxxxx"
      secret_mount_path = "kvv2_team3"
    }
  }
}

locals {
  team_policies = {
    
    team1_policy = {
      policy_cab = "${path.root}/policy/kvv2-team1.hcl"
    }
    team2_policy = {
      policy_cab = "${path.root}/policy/kvv2-team2.hcl"
    }
    team3_policy = {
      policy_cab = "${path.root}/policy/kvv2-team3.hcl"
    }
    master_policy = {
      policy_cab = "${path.root}/policy/master-policy.hcl"
    }
  } 
}



# # Define the secret_mounts
# locals {
#   secret_mount = {
#     "kvv2-team1" = {
#       type        = "kv-v2"
#       description = "Enable secret engine for team1"
#     }
#     "kvv2-team2" = {
#       type        = "kv-v2"
#       description = "Enable secret engine for team2"
#     }
#     "kvv2-team3" = {
#       type        = "kv-v2"
#       description = "Enable secret engine for team3"
#     }
#   }
# }

# # Define the secrets for each team
# locals {
#   secrets = {
#     "aws-master" = {
#       access_key      = "xxxxxeeef12"
#       secret_access_key = "eefi344545"
#       mount     = "kvv2-team1"  # Mapping the secret to the mount path
#     }
#     "aws-dev" = {
#       access_key      = "xxxxxeeef12"
#       secret_access_key = "eefi344545"
#       mount      = "kvv2-team2"  # Mapping the secret to the mount path
#     }
#     "aws-prod" = {
#       access_key      = "xxxxxeeef12"
#       secret_access_key = "eefi344545"
#       mount      = "kvv2-team3"  # Mapping the secret to the mount path
#     }
#   }
# }



# locals {
#   enable_auth = {
#     team1 = {
#       type = "userpass"
#     }

#     team2 = {
#       type = "userpass"
#     }
#      team3 = {
#       type = "userpass"
#     }
#   }
# }


# locals {
#   users = {
#     team1_user = {
#         path = "team1"
#         password = "12345" 
#     }
#     team2_user= {
#         path = "team2"
#         password = "12345" 
#     }
#     team3_user= {
#         path = "team3"
#         password = "12345" 
#     }
#   }
# }

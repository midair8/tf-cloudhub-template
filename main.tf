terraform {
  required_providers {
    anypoint = {
      source  = "mulesoft-anypoint/anypoint"
      version = "1.5.5"
    }
  }
}

provider "anypoint" {
  client_id     = var.client_id
  client_secret = var.client_secret
}

resource "anypoint_env" "env" {
  org_id = var.org_id
  name   = var.env_name
  type   = var.env_type
}

resource "anypoint_vpc" "vpc" {
  org_id     = var.org_id
  owner_id   = var.owner_id
  name       = var.vpc_name
  region     = var.vpc_region
  cidr_block = var.vpc_cidr_block

  associated_environments = [
    anypoint_env.env.id
  ]

  firewall_rules {
    cidr_block = "0.0.0.0/0"
    from_port  = 8081
    protocol   = "tcp"
    to_port    = 8082
  }

  firewall_rules {
    cidr_block = var.vpc_cidr_block
    from_port  = 8091
    protocol   = "tcp"
    to_port    = 8092
  }
}

resource "anypoint_dlb" "dlb" {
  vpc_id = anypoint_vpc.vpc.id
  org_id = var.org_id
  name   = var.dlb_name

  ssl_endpoints {
    public_key_label = var.dlb_ssl_endpoints_public_key_label
    public_key       = var.dlb_ssl_endpoints_public_key

    private_key_label = var.dlb_ssl_endpoints_private_key_label
    private_key       = var.dlb_ssl_endpoints_private_key

    mappings {
      input_uri         = "{app}/"
      app_name          = "{app}"
      app_uri           = "/"
      upstream_protocol = "http"
    }
  }

  depends_on = [
    anypoint_vpc.vpc
  ]
}
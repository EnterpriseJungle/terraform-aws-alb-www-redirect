
===sample implementation

    provider "aws" {
      region  = "us-east-1"
      profile = "prod"
    }

    module "www_redirect" {
      source         = "github.com/enterprisejungle/terraform-aws-alb-www-redirect"
      zone_name      = "enterprisealumni.com"
      cert_arn       = "arn:aws:acm:us-east-1:999999999999:certificate/*snip*"
      subnets        = ["subnet-aaaaaaaa", "subnet-bbbbbbbb", "subnet-cccccccc", "subnet-dddddddd"]
      securitygroups = ["sg-00000000"]
    }

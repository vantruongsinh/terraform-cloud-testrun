terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_networkfirewall_rule_group" "Stateful-FWRuleGroup-Rule2" {
  name = "Stateful-FWRuleGroup-Rule2"
  description = "Testing123"
  capacity = 3000
  type = "STATEFUL"
  rule_group {
    rule_variables {
      ip_sets {
        key = "SUBNET1"
        ip_set {
          definition = ["10.0.1.0/24"]
        }
      }
      ip_sets {
        key = "SUBNET2"
        ip_set {
          definition = ["10.0.2.0/24"]
        }
      }
      ip_sets {
        key = "SUBNET3"
        ip_set {
          definition = ["10.0.3.0/24"]
        }
      }
                
    }
    rules_source {
        stateful_rule {
          action = "PASS"
          header {
                    destination      = "ANY"
                    destination_port = "ANY"
                    direction        = "FORWARD"
                    protocol         = "TCP"
                    source           = "ANY"
                    source_port      = "ANY"
                  }
          rule_option {
                    keyword  = "sid:1"
                }
        }
        stateful_rule {
          action = "PASS"
          header {
                    destination      = "$SUBNET3"
                    destination_port = "ANY"
                    direction        = "FORWARD"
                    protocol         = "TCP"
                    source           = "ANY"
                    source_port      = "ANY"
                  }
          rule_option {
                    keyword  = "sid:2"
                }
        }
      }
      stateful_rule_options {
            rule_order = "STRICT_ORDER"
      }
    }           
  }

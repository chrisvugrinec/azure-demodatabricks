module "customers" {
  source      = "./customers"
  location    = var.location
  tags        = var.tags
  rg-name     = var.rg-name
  logretention_days_default = var.logretention_days_default
}


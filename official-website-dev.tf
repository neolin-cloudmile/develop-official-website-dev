# Add the vm-bastionhost instance
module "vm-bastionhost" {
  source                 = "./bastionhost"
  instance_name          = "official-website-dev-bastionhost"
  instance_zone          = "asia-east1-a"
  instance_type          = "n1-standard-2"
  instance_imagetype     = "debian-cloud/debian-9"
  instance_subnetwork    = "official-website-public-subnet-1"
}

# Add the instance for bastionhost
module "vm-bastionhost" {
  source                 = "./bastionhost"
  instance_name          = "official-website-dev-bastionhost"
  instance_zone          = "asia-east1-a"
  instance_type          = "n1-standard-2"
  instance_imagetype     = "debian-cloud/debian-9"
  instance_subnetwork    = var.official-website-public-subnet-1
}
# Create container cluster - gke
module "container-cluster" {
  source                              = "./gke-cluster"
  cluster_name                        = "official-website-dev-cluster"
  cluster_location                    = "asia-east1"
  cluster_init_node                   = "3"
  cluster_network                     = var.develop-network-sharedvpc 
  cluster_subnetwork                  = var.official-website-private-subnet-k8s 
  cluster_secondary_rangename         = "official-website-dev-pods"
  cluster_service_secondary_rangename = "official-website-dev-services"
}
# Create Cloud SQL for MySQL, inlcude HA function, Private IP
module "db-mysql" {
  source              = "./database"
  db_name             = "db-mysql-dev"
  db_region           = "asia-east1"
  db_version          = "MYSQL_5_7"
  db_type             = "db-n1-standard-2"
  db_private_network  = var.develop-network-sharedvpc
  db_backup_time      = "04:00"
  db_maintenance_day  = "7"
  db_maintenance_hour = "7"
  db_disk_size        = "100"
  db_disk_type        = "PD_HDD"
  resource_timeout    = "20m"
}

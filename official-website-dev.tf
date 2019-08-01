# Add the vm-bastionhost instance
module "vm-bastionhost" {
  source                 = "./bastionhost"
  instance_name          = "official-website-dev-bastionhost"
  instance_zone          = "asia-east1-a"
  instance_type          = "n1-standard-2"
  instance_imagetype     = "debian-cloud/debian-9"
  instance_subnetwork    = "var.official-website-public-subnet-1"
}
module "official-website-dev-cluster" {
  source                              = "./gke"
  cluster_name                        = "official-website-dev-cluster"
  cluster_location                    = "asia-east1"
  cluster_init_node                   = "3"
  cluster_network                     = "${google_compute_network.official-website-dev.name}"
  cluster_subnetwork                  = "${google_compute_subnetwork.private-subnet-k8s.name}" 
  cluster_secondary_rangename         = "official-website-dev-cluster-pod-1"
  cluster_service_secondary_rangename = "official-website-dev-cluster-services-1"
}

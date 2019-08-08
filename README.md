# develop-official-website-dev
## Deploy the infra
1. Enable API:Kubernetes Engine API, Memorystore for Redis API, Service Networking API, Cloud SQL Admin API, Container Analysis API, Binary Authorization API, Web Security Scanner API<br />
2. Create a bastion host on public-1<br />
3. Create a privatei cluster of container clsuter(GKE)<br />
4. Create a memorystore for redis from host proejct<br />
5. Create a Cloud SQL for MySQL<br />

## Command Line
1. Check project<br />
gcloud projects list<br />
2. Change the current project<br />
gcloud config set project project-name<br />
3. List the networks<br />
gcloud compute networks list<br />
4. List the subnets<br />
gcloud compute networks subnets list<br />
5. Describe the subnets<br />
gcloud compute networks subnets describe official-website-public-subnet-2 --region=asia-east1<br />
6. List the instance of GKE<br />
gcloud compute instances list<br />
7. List the container cluster<br /> 
gcloud container clusters list<br />
8. Describe the container cluster<br />
gcloud container clusters describe official-website-dev-cluster --region=asia-east1<br />
9. Get-credentitals container cluster<br />
gcloud container clusters get-credentials official-website-dev-cluster --region asia-east1
10. List usable of container subnets
gcloud beta container subnets list-usable --project [SERVICE_PROJECT_ID] --network-project [HOST_PROJECT_ID]
11. Using Cloud Shell to access a private cluster - use dig to find the external IP address of your Cloud Sell<br />
dig +short myip.opendns.com @resolver1.opendns.com<br />
12. Lists Cloud SQL instances in a given project<br />
gcloud sql instances list<br />
13. Lists the backups of Cloud SQL<br />
gcloud sql backups list --instance=official-website-dev-mysql<br />
14. List existing images<br />
gcloud container images list<br />
15. List the images in the default repository (us.gcr.io)<br />
gcloud container images list --repository=gcr.io/myproject<br />
16. List the images in a specified repository, e.g. asia<br />
gcloud container images list --repository=asia.gcr.io/official-website-dev<br />


## Reference Link
1. Cloud SDK - gcloud reference - overview
https://cloud.google.com/sdk/gcloud/reference/
2. Kubernetes Engine - Setting up clusters with shared VPC<br />
https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc<br />
3. Kubernetes Engine - Setting up a private cluster<br />
https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters<br />
4. Kubernetes Engine - Creating a VPC-native cluster<br />
https://cloud.google.com/kubernetes-engine/docs/how-to/alias-ips<br />
5. Virtual Privaet Cloud - Alias ranges overview<br />
https://cloud.google.com/vpc/docs/alias-ip<br />
6. Quickstart for Cloud SQL for MySQL
https://cloud.google.com/sql/docs/mysql/quickstart
7. Cloud SQL - MySQL - private IP<br />
https://cloud.google.com/sql/docs/mysql/private-ip#network_requirements<br />
8. Cloud SQL - MySQL - Configuring private IP connectivity<br />
https://cloud.google.com/sql/docs/mysql/configure-private-ip<br />
9. Cloud SQL - MySQL - Overview of the high availability configuration<br />
https://cloud.google.com/sql/docs/mysql/high-availability<br />
10. GitHub - terraform-provider-google - google_service_networking_connection error<br />
https://github.com/terraform-providers/terraform-provider-google/issues/3294<br />
11. Cloud SQL - MySQL - Connecting from Google Kubernetes Engine<br />
https://cloud.google.com/sql/docs/mysql/connect-kubernetes-engine<br />
12. VPC - Special configurations - Configuring private services access - procedure<br />
https://cloud.google.com/vpc/docs/configure-private-services-access?hl=en_US&_ga=2.98105372.-209726674.1565071015#procedure<br />
13. Cloud SDK - gcloud container images<br />
https://cloud.google.com/sdk/gcloud/reference/container/images/list<br />
14. Kubernetes Engine Tutorials - Deploying a containerized web application<br />
https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app<br />
15. Kubernetes Engine > How-to guides > Configurung cluster networking > clusters with shared VPC<br />
https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc<br />
16. Kubernetes Engine > How-to guides > Configuring cluster networking > Clusters with shared VPC > Creating additional firewall rules<br />
https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-shared-vpc#creating_additional_firewall_rules<br />
17. Cloud IAM > Managing roles and permissions > Creating and managing custom roles<br />
https://cloud.google.com/iam/docs/creating-custom-roles<br />

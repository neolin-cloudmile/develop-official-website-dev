# develop-official-website-dev
## Deploy the infra
1. Enable API:Kubernetes Engine API, Memorystore for Redis API, Service Networking API, Cloud SQL Admin API, Container Analysis API, Binary Authorization API, Web Security Scanner API, Cloud Build API, Google Container Registry API, Cloud Source Repositories API<br />
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
gcloud compute networks subnets describe official-website-private-subnet-k8s --region=asia-east1<br />
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
17. List the namespace of GKE<br />
kubectl get namespace<br />
18. List the pods of designation namespace<br /> 
kubectl get pods -n kube-system<br />
17. Describe the pods<br />
kubectl describe pods secret-test-pod<br />
18.Build a Image and push to gcr<br />
export PROJECT_ID="$(gcloud config get-value project -q)"<br />
docker build -t asia.gcr.io/${PROJECT_ID}/secret-pod:v1<br />
gcloud docker -- push asia.gcr.io/${PROJECT_ID}/secret-pod:v1<br />
19. List the images for designation repository<br />
gcloud container images list --repository=asia.gcr.io/official-website-dev<br />
20. Create the Secret<br />
kubectl apply -f https://k8s.io/examples/pods/inject/secret.yaml<br />
21. Delete the Secret<br />
kubectl delete -f https://k8s.io/examples/pods/inject/secret.yaml<br />
22. Define container environment variables with data from multiple Secrets<br />
kubectl create secret generic db-user --from-literal=db-username='db-admin'<br />
23. Delete the secret<br />
kubectl delete secret db-user<br />
24. List the secret of GKE<br />
kubectl get secret test-secret<br />
25. Describe the secret of GKE<br />
kubectl describe secret test-secret<br />
26. Describe the secret of GKE via yaml<br />
kubectl get secret describe test-secret -o yaml<br />
27. Deploy container<br />
kubectl apply -f secret-pod.yaml<br />
28. Delete container<br />
kubectl delete -f secret-pod.yaml<br />
29. Get a Shell to a Running Container<br />
kubectl exec -it secret-test-pod -- /bin/bash<br />
30. Connect with the mysql client<br />
mysql --host=[CLOUD_SQL_PUBLIC_IP_ADDR] --user=root --password<br />
mysql --host=cloudsql-proxy-service --user=$username --password=$password<br />
31. kubectl create secret generic cloudsql-instance-credentials<br /> 
kubectl create secret generic cloudsql-instance-credentials --from-file=credentials.json="xxxxx-xxxxx.json"<br />
32. List the secret<br />
kubectl get secret<br />
33. Describe the deployment<br />
kubectl describe deployment wordpress<br />
34.<br />
kubectl logs -l app=wordpress -c web<br/ >
35.<br />
kubectl logs -l app=wordpress -c cloudsql-proxy<br />
36. Create secondary ip address on existing subnet<br />
gcloud compute networks subnets update official-website-private-subnet-k8s --add-secondary-ranges official-website-dev-pods=10.8.0.0/14,official-website-dev-services=10.137.0.0/20 --region=asia-east1<br />
37. Show the currect project<br />
gcloud config get-value project<br />
38. Add Host Service Agent User to service account of GKE of service project<br />
gcloud projects add-iam-policy-binding [HOST_PROJECT_ID] \<br />
    --member serviceAccount:service-[SERVICE_PROJECT_1_NUM]@container-engine-robot.iam.gserviceaccount.com \<br />
    --role roles/container.hostServiceAgentUser<br />
39. List a project's usable subnets and secondary IP ranges<br />
gcloud container subnets list-usable \<br />
    --project [SERVICE_PROJECT_ID] \<br />
    --network-project [HOST_PROJECT_ID]<br />
40. SSH to node of GKE from Cloud Shell<br />
gcloud compute ssh gke-official-website-dev-default-pool-11c63745-gvf2 --project official-website-dev --zone asia-east1-c<br />
41. List Service APIs<br />
gcloud services list --enabled | grep container<br />
42. Enable the Service APIs<br />
gcloud services enable sourcerepo.googleapis.com<br />

## Reference Link
### GCP
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
10. Cloud SQL - MySQL - Connecting from Google Kubernetes Engine<br />
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
18. gcloud compute networks subnets update<br />
https://cloud.google.com/sdk/gcloud/reference/compute/networks/subnets/update<br />
19. gcloud services list<br />
https://cloud.google.com/sdk/gcloud/reference/services/list<br />
20. Creating GKE private clusters with network proxies for master access<br />
https://cloud.google.com/solutions/creating-kubernetes-engine-private-clusters-with-net-proxies<br />
21. Pushing and pulling images<br />
https://cloud.google.com/container-registry/docs/pushing-and-pulling<br />
22. Can't pull image from public Docker Hub<br />
https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#docker_hub<br />
23. Using Container Registry's Docker Hub mirror<br />
https://cloud.google.com/container-registry/docs/using-dockerhub-mirroring<br />


### Kubernetes & Other
1. Kubernetes Online Documents
https://kubernetes.io/docs/home/
2. Github - Firewall change required by network admin<br />
https://github.com/kubernetes/ingress-gce/issues/584<br />
3. johnwu - GKE connect to CloudSQL<br />
https://blog.johnwu.cc/article/gcp-kubernetes-connect-to-cloudsql.html<br />
4. johnwu - GKE deploy docker images for toolbox<br />
https://blog.johnwu.cc/article/gcp-kubernetes-deploy-docker-image.html<br />
5. Kuberbetes - Tasks - Inject Data Into Application - Distribute Credentials Securely Using Secrets<Br /> 
https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/<br />
6. Kubernetes - Concepts - Configuration - Secrets<br />
https://kubernetes.io/docs/concepts/configuration/secret/<br />
7. Linux vBird - Vi<br />
http://linux.vbird.org/linux_basic/0310vi/0310vi-fc4.php<br />
8. GitHub - terraform-provider-google - google_service_networking_connection error<br />
https://github.com/terraform-providers/terraform-provider-google/issues/3294<br />
9. Using Google Cloud SQL from a WordPress Deployment<br />
https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/tree/master/cloudsql<br />
10. Google Cloud Build deploy to GKE Private Cluster<br />
https://stackoverflow.com/questions/51944817/google-cloud-build-deploy-to-gke-private-cluster<br />
11. Using Container Registry's Docker Hub mirror<br />
https://cloud.google.com/container-registry/docs/using-dockerhub-mirroring<br />

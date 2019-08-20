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
19. Describe the pods<br />
kubectl describe pods secret-test-pod<br />
20. Build a Image and push to gcr<br />
export PROJECT_ID="$(gcloud config get-value project -q)"<br />
docker build -t asia.gcr.io/${PROJECT_ID}/secret-pod:v1 .<br />
gcloud docker -- push asia.gcr.io/${PROJECT_ID}/secret-pod:v1<br />
21. List the images for designation repository<br />
gcloud container images list --repository=asia.gcr.io/official-website-dev<br />
22. Create the Secret<br />
kubectl apply -f https://k8s.io/examples/pods/inject/secret.yaml<br />
23. Delete the Secret<br />
kubectl delete -f https://k8s.io/examples/pods/inject/secret.yaml<br />
24. Define container environment variables with data from multiple Secrets<br />
kubectl create secret generic db-user --from-literal=db-username='db-admin'<br />
25. Delete the secret<br />
kubectl delete secret db-user<br />
26. List the secret of GKE<br />
kubectl get secret test-secret<br />
27. Describe the secret of GKE<br />
kubectl describe secret test-secret<br />
28. Describe the secret of GKE via yaml<br />
kubectl get secret describe test-secret -o yaml<br />
29. Deploy container<br />
kubectl apply -f secret-pod.yaml<br />
30. Delete container<br />
kubectl delete -f secret-pod.yaml<br />
31. Get a Shell to a Running Container<br />
kubectl exec -it secret-test-pod -- /bin/bash<br />
32. Connect with the mysql client<br />
mysql --host=[CLOUD_SQL_PUBLIC_IP_ADDR] --user=root --password<br />
mysql --host=cloudsql-proxy-service --user=$username --password=$password<br />
33. kubectl create secret generic cloudsql-instance-credentials<br /> 
kubectl create secret generic cloudsql-instance-credentials --from-file=credentials.json="xxxxx-xxxxx.json"<br />
34. List the secret<br />
kubectl get secret<br />
35. Describe the deployment<br />
kubectl describe deployment wordpress<br />
36. Show logs by label<br />
kubectl logs -l app=wordpress -c web<br/ >
37.Shoe logs by container<br />
kubectl logs -l app=wordpress -c cloudsql-proxy<br />
38. Create secondary ip address on existing subnet<br />
gcloud compute networks subnets update official-website-private-subnet-k8s --add-secondary-ranges official-website-dev-pods=10.8.0.0/14,official-website-dev-services=10.137.0.0/20 --region=asia-east1<br />
39. Show the currect project<br />
gcloud config get-value project<br />
40. Add Host Service Agent User to service account of GKE of service project<br />
gcloud projects add-iam-policy-binding [HOST_PROJECT_ID] \<br />
    --member serviceAccount:service-[SERVICE_PROJECT_1_NUM]@container-engine-robot.iam.gserviceaccount.com \<br />
    --role roles/container.hostServiceAgentUser<br />
41. List a project's usable subnets and secondary IP ranges<br />
gcloud container subnets list-usable \<br />
    --project [SERVICE_PROJECT_ID] \<br />
    --network-project [HOST_PROJECT_ID]<br />
42. SSH to node of GKE from Cloud Shell<br />
gcloud compute ssh gke-official-website-dev-default-pool-11c63745-gvf2 --project official-website-dev --zone asia-east1-c<br />
43. List Service APIs<br />
gcloud services list --enabled | grep container<br />
44. Enable the Service APIs<br />
gcloud services enable sourcerepo.googleapis.com<br />
45. List .git file<br />
find . -type f | grep -i ".git"<br />
46. Connect to bastion from Cloud Shell<br />
gcloud compute ssh official-website-dev-bastionhost --zone asia-east1-a -- -A<br />
47. List Containers by Pod<br />
kubectl get pods -n default -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' | sort<br />
48. List Container name by Pod<br />
kubectl get pods esp-echo-84949c578-nfrz4 -n default -o jsonpath='{.spec.containers[*].name}'<br />
49. Connect to a container from multi containers of single Pod<br />
kubectl exec -it esp-echo-84949c578-nfrz4 -c echo -- /bin/bash<br />
50.<br />
docker pull casperfrx/mongodb-shell<br />
docker images -a<br />
docker tag casperfrx/mongodb-shell asia.gcr.io/official-website-dev/mongo-shell:v1<br />
docker push asia.gcr.io/official-website-dev/mongo-shell:v1<br />


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
24. Binary Authorization - Quickstart<br />
https://cloud.google.com/binary-authorization/docs/quickstart<br />
25. Cloud NAT - Example GKE Setup<br />
https://cloud.google.com/nat/docs/gke-example<br />
26. Getting vulnerabilities and metadata for images<br />
https://cloud.google.com/container-registry/docs/get-image-vulnerabilities<br />
27. Cloud NAT - Shared VPC<br />
https://cloud.google.com/nat/docs/overview#shared_vpc<br />
28. Google-managed encryption keys<br />
https://cloud.google.com/storage/docs/encryption/default-keys<br />
29. Resource Quotas<br />
https://cloud.google.com/compute/quotas<br />
30. Getting started with GitLab CI/CD and Google Cloud Platform<br />
https://about.gitlab.com/2018/04/24/getting-started-gitlab-ci-gcp/<br />
31. How to set up Gitlab CI/CD with Google Cloud Container Registry and Kubernetes<br />
https://medium.com/@davivc/how-to-set-up-gitlab-ci-cd-with-google-cloud-container-registry-and-kubernetes-fa88ab7b1295<br />
32. Gitlab Runner talking to GCR<br />
https://stroebitzer.com/2018/09/28/gitlab-gcr.html<br />
33.Architectural overview of Cloud Endpoints<br />
https://cloud.google.com/endpoints/docs/openapi/architecture-overview<br />
34. About Cloud Endpoints<br />
https://cloud.google.com/endpoints/docs/openapi/about-cloud-endpoints<br />
35. Getting started with Cloud Endpoints on GKE<br />
https://cloud.google.com/endpoints/docs/openapi/get-started-kubernetes-engine<br />
36. Deleting an API and API instances<br />
https://cloud.google.com/endpoints/docs/openapi/deleting-an-api-and-instances<br />
37. Cloud SQL for MySQL - Importing data into Cloud SQL
https://cloud.google.com/sql/docs/mysql/import-export/importing
38. Stackdriver Monitoring - documentation<br />
https://cloud.google.com/monitoring/docs/<br />
39. Stackdriver Monitoring - Creating Charts<br />
https://cloud.google.com/monitoring/charts/<br />
40 .Stackdriver Monitoring - Using dashboards<br />
https://cloud.google.com/monitoring/charts/dashboards<br />
41. Exporting with the Logs Viewer<br />
https://cloud.google.com/logging/docs/export/configure_export_v2<br />
42. Cloud Storage - Creating storage buckets<br />
https://cloud.google.com/storage/docs/creating-buckets<br />


### MongoDB Atlas
1. MongoDB Atlas - GCP<br />
https://docs.atlas.mongodb.com/reference/google-gcp/<br />
2. MongoDB Atlas - The mongo Shell<br />
https://docs.mongodb.com/manual/mongo/<br />
3. MongoDB Atlas - mongo Shell Quick Reference<br />
https://docs.mongodb.com/manual/reference/mongo-shell/<br />
4. MongoDB Atlas - Set up a Network Peering Connection<br />
https://docs.atlas.mongodb.com/security-vpc-peering/<br />

### Kubernetes & Others 
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
12. List All Container Images Running in a Cluster<br />
https://kubernetes.io/docs/tasks/access-application-cluster/list-all-running-container-images/<br />

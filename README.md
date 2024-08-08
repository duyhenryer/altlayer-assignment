# Altlayer-Assignment

## Prerequisites:

```sh
kubectl
helm 
flux
awscli 
```
## Diagram Basic 
![Diagram](./images/diagram.png)

## Mission 1: Terraform: EKS
* Go the folder [terraform](../terraform/README.md)
- I dont't have a bastion host or a VPN. I need to enable a `public_endpoint` as well to access it from my laptop.
- I created a `workflow` to manage tf code with easy collaboration between within the team.
- Have using S3 to Backend store state
- Using terraform module vpc and eks 

***Verify the Cluster***
Use `kubectl` commands to verify your cluster configuration.
```sh
π altlayer-assignment ✗ ❯ kubectl cluster-info
Kubernetes control plane is running at https://FA20253D29D0BC2E5BCF3FF54999478A.gr7.ap-southeast-1.eks.amazonaws.com
CoreDNS is running at https://FA20253D29D0BC2E5BCF3FF54999478A.gr7.ap-southeast-1.eks.amazonaws.com/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```
Now verify that all three worker nodes are part of the cluster.
```sh
π altlayer-assignment ✗ ❯ kubectl get node
NAME                                             STATUS   ROLES    AGE    VERSION
ip-10-0-28-201.ap-southeast-1.compute.internal   Ready    <none>   114m   v1.29.6-eks-1552ad0
ip-10-0-61-137.ap-southeast-1.compute.internal   Ready    <none>   115m   v1.29.6-eks-1552ad0
```
Ready to use.

## Mission 2: CICD
The token is very important for authentication between the cluster and the GitHub repository. 
So I decided bootstrap via Deploy Keys. 
Run the bootstrap.
```sh
π altlayer-assignment ✗ ❯ flux bootstrap git \
  --branch=main \
  --url=ssh://git@github.com/duyhenryer/altlayer-assignment\
  --private-key-file=/Users/duy.dovan/.ssh/me/id_ed25519 \
  --components-extra=image-reflector-controller,image-automation-controller \
  --path=kubernetes/clusters/demo
```

[Bootstrap docs](https://fluxcd.io/flux/installation/bootstrap/github/)
## Mission 3: EKS Monitoring
Tasks:
1. Deploy kube-prometheus-stack via FluxCD
  - Go to the folder `kubernetes/infra/controllers/` to deploy it.
2. Grafana (more)
  - Access to link: [http://grafana.duyne.me ](http://grafana.duyne.me)
  - user/pass: `admin/dem@123`
  - Dashboard for Kubernetes and Ingress-Nginx

## Mission 4: Sample App Deployment
Tasks:
1. Dockerize your Hello World web app.
  - A simple app with FastAPI to easy test.
  - Have `workflow` to build and push Github Registry
  - Using Github Action
2. Create a helm chart for it.
  - I created a helm-chart in folder `helm`. Its sample chart to deploy.
  - Using Github Action
  - Have `workflow` to release chart via OCI of Github
3. Deploy it via FluxCD.
  - I deployed app in folder `kubernetes/apps`
  - Access to link: [http://apps.duyne.me/](http://apps.duyne.me/)
  - Test via `curl`
    ```
    π altlayer-assignment ✗ ❯ curl http://apps.duyne.me
    {"message":"Hello, World! - Altlayer "}
    ```

## Mission 5: Stress Testing

```
artillery run test.yml --record --key a9_z9KbVQvrs77iQYnZnur9-mMLW3UFhCBa
```

## Todo more 
- Automate image updates
- SSL
- Autoscale via Karpenter
docker run mcr.microsoft.com/mcr/hello-world

# App can run without modification
# We must map port since app is listening on 80
docker run -it -p 8080:80 mcr.microsoft.com/azuredocs/aci-helloworld
docker exec -it image /bin/sh


# Now lets deploy to k8s
az login --tenant TENANT_ID

az aks get-credentials -g rg-containers-k8s-demo -n containers-k8s-demo

kubectl get pod

# Create our pods
kubectl apply -f 01-deployment.yaml

# Create our service and show load balanced ip
kubectl apply -f 02-service.yaml

# Delete the load balanced service
kubectl delete svc aci-helloworld

# Deploy an ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.4/deploy/static/provider/cloud/deploy.yaml

# Create our clusterip service and ingress
kubectl apply -f 02-external-service.yaml
kubectl apply -f 03-ingress.yaml



# Clean up
kubectl delete ingress aci-helloworld-ingress
kubectl delete svc aci-helloworld
kubectl delete deployment aci-helloworld
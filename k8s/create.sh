microk8s kubectl create namespace $1
microk8s kubectl config set-context --current --namespace=$1
microk8s kubectl apply -f configmap.yaml
microk8s kubectl apply -f secret.yaml
microk8s kubectl apply -f ingress.yaml
microk8s kubectl apply -f deployment.yaml
microk8s kubectl apply -f service.yaml

export NEW_IP="$(microk8s kubectl get services/python-test -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
echo "IP=$NEW_IP"
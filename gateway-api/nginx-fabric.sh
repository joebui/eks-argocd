VERSION=v1.2.0

set -x

# kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml
# sleep 2
# kubectl apply -f https://github.com/nginxinc/nginx-gateway-fabric/releases/download/$VERSION/crds.yaml
# sleep 2
# kubectl apply -f https://github.com/nginxinc/nginx-gateway-fabric/releases/download/$VERSION/nginx-gateway.yaml
# sleep 2
# kubectl apply -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/$VERSION/deploy/manifests/service/loadbalancer-aws-nlb.yaml

kubectl delete -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/$VERSION/deploy/manifests/service/loadbalancer-aws-nlb.yaml
kubectl delete -f https://github.com/nginxinc/nginx-gateway-fabric/releases/download/$VERSION/nginx-gateway.yaml
kubectl delete -f https://github.com/nginxinc/nginx-gateway-fabric/releases/download/$VERSION/crds.yaml
kubectl delete -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml

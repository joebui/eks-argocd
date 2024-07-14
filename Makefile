apply:
	cd terraform && terraform init && terraform apply

destroy:
	cd terraform && terraform destroy

kube_config:
	AWS_REGION=ap-southeast-1 aws eks update-kubeconfig --name hello-world

argo_port:
	kubectl port-forward svc/argocd-server -n argocd 8080:443

argo_apply:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argo_delete:
	kubectl delete --ignore-not-found -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl delete namespace argocd

argo_admin:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

prom:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm upgrade --install prometheus prometheus-community/prometheus -f ./prometheus/values.yml -n default

prom_state_metrics:
	helm upgrade --install kube-state-metrics prometheus-community/kube-state-metrics -n default

alert_mana:
	helm upgrade --install alertmanager prometheus-community/alertmanager -f ./prometheus/values.yml -n default

traefik:
	helm repo add traefik https://traefik.github.io/charts
	kubectl create namespace traefik
	helm upgrade --install traefik traefik/traefik -f ./traefik/values.yml -n traefik

exporter:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm upgrade --install nginx prometheus-community/prometheus-nginx-exporter -f ./exporters/nginx-value.yml -n default

fluent:
	helm repo add fluent https://fluent.github.io/helm-charts
	helm upgrade --install fluent-bit fluent/fluent-bit -n default

grafana:
	helm repo add grafana https://grafana.github.io/helm-charts
	helm upgrade --install grafana grafana/grafana

istio:
	helm repo add istio https://istio-release.storage.googleapis.com/charts
	helm upgrade --install istio-base istio/base -n istio-system --create-namespace --wait
	helm upgrade --install istio-cni istio/cni -n istio-system --set profile=ambient --wait
	helm upgrade --install istiod istio/istiod -n istio-system --set profile=ambient --wait
	helm upgrade --install ztunnel istio/ztunnel -n istio-system --wait

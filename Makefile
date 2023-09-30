apply:
	cd terraform && terraform apply

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

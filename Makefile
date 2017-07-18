BRANCH?=master

# Refonte kubernetes
kube-build-refonte:
	docker build \
	-t darkilliant/kubernetes-refonte \
	kubernetes/builder/refonte \
	--build-arg BRANCH=${BRANCH}
kube-push-refonte:
	docker push darkilliant/kubernetes-refonte:latest
kube-deploy-refonte:
	kubectl create -f kubernetes/deployments/refonte.yaml
	kubectl create -f kubernetes/services/refonte.yaml
kube-update-refonte:
	kubectl apply -f kubernetes/deployments/refonte.yaml
	kubectl apply -f kubernetes/services/refonte.yaml
kube-runlocal-refonte:
	docker run --rm -p 10080:80 -it darkilliant/kubernetes-refonte:latest
kube-debuglocal-refonte:
	docker run --rm -it --entrypoint=bash darkilliant/kubernetes-refonte:latest

# Legacy kubernetes
kube-build-legacy:
	docker build \
	-t darkilliant/kubernetes-legacy \
	kubernetes/builder/legacy \
	--build-arg BRANCH=${BRANCH}
kube-push-legacy:
	docker push darkilliant/kubernetes-legacy:latest
kube-deploy-legacy:
	kubectl create -f kubernetes/deployments/legacy.yaml
	kubectl create -f kubernetes/services/legacy.yaml
kube-update-legacy:
	kubectl apply -f kubernetes/deployments/legacy.yaml
	kubectl apply -f kubernetes/services/legacy.yaml
kube-runlocal-legacy:
	docker run --rm -p 10080:80 -it darkilliant/kubernetes-legacy:latest
kube-debuglocal-legacy:
	docker run --rm -it --entrypoint=bash darkilliant/kubernetes-legacy:latest

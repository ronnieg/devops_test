# Task 2 - Minikube

4. Prepare local Kubernetes environment (using MiniKube) to run our application in pod/container. 
Store all relevant scripts (kubectl commands etc) in your forked repository.
5. Suggest & create minimal local infrastructure to perform functional testing/monitoring of our application pod.
Demonstrate monitoring of relevant results & metrics for normal app behavior and failure(s).

# Environment setup

## Tools
| Tool | Version | Description | URL |
| :--- | :------ | :---------- | :-- | 
| Docker| 20.10.8+ | Docker Desktop for local image build | TBD |
| minikube | v1.23.0 | Kubernetes runtime for local machine | TBD |
| helm | v3.7.2 | Kubernets manifests and templates manager | TBD |
| kubectl | 1.22.1 | Kubernetes control tool| TBD |
| helmfile | v0.142.0+ | Helm compose tool | TBD |

## Part 1 - Kubectl command for run application in pod

1. Run minikube
```bash
minikube start \
-p aged --kubernetes-version=v1.16.1 \
--cpus=2 --memory=2gb --disk-size=5gb
```

Result: 
```
> kubectl cluster-info
Kubernetes control plane is running at https://127.0.0.1:59660
KubeDNS is running at https://127.0.0.1:59660/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```
![Alt text](/result/task2/images/minikube_version.png?raw=true "Kubernetes version")

2. Run kubectl command for create pod

```bash
kubectl run dummy-webservice \
--image=yahorbukatkin/dummy-webservice:0.0.1 \
--port=8080
```

3. Port forward and check results
```bash
kubectl port-forward dummy-webservice 8080:8080
```
![Alt text](/result/task2/images/port_forward.png?raw=true "Port forward")

## Part 2 - Minimal local infrastructure

1. Prepare Environment

**Run Minikube**
```bash
minikube start \
-p aged --kubernetes-version=v1.19.0 \
--cpus=2 --memory=2gb --disk-size=5gb
minikube -p aged addons enable ingress
```
**Install cert-manager**
```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.yaml
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.6/deploy/manifests/00-crds.yaml
```

2. Install monitring

**Debug**
```bash
cd ~/devops_test/result/task2/prometheus-stack/
helmfile -f helmfile.yaml -n monitoring -e minikube template --args --debug
```

**Install**
```bash
cd ~/devops_test/result/task2/prometheus-stack/
helmfile -f helmfile.yaml -n monitoring -e minikube sync
```
If ingress doesn't work, please use port-forwarding.

3. Deploy application
**Install**
```bash
cd ~/devops_test/result/task2/dummy-webservice/helm/dummy-webservice/helmfile/
helmfile -f helmfile.yaml -n dummy-webservice -e local sync
```

Result:
![Alt text](/result/task2/images/result_1.png?raw=true "Webserver log")

## Part 3 - Monitoring
If ingress doesn't work, please use port-forwarding.

Pod results:
![Alt text](/result/task2/images/result_2.png?raw=true "Pod results")

**Grafana**
Login/password: admin/prom-operator

Dummy-weservice Pod in grafana:
![Alt text](/result/task2/images/result_3.png?raw=true "Pod in grafana")

Custom dashboard for node-exporter from sources:
![Alt text](/result/task2/images/result_4.png?raw=true "Custom dashboard")


**Prometheus**
Dummy-weservice Pod in prometheus:
![Alt text](/result/task2/images/result_5.png?raw=true "Pod in prometheus")
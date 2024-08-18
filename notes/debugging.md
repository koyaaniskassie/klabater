# disappearing node
Each time sealed secret is deployed node is lost and returns after few seconds
`kubectl get node`
if it returns it can't connect check kubelet
`systemctl status kubelet`
`journalctl -u kubelet`
mine was working so went further to check CRI. To find out what CRI i'm using checked
`systemctl cat kubelet` and there was --config-file with path, there might be also --container-runtime argument, but in this case it was onli path to config-file
there was `containerRuntimeEndpoint` and pointed to containerd
`systemctl status containerd` and it was also running without issue

`kubectl get nodes` returns it can't connect to API - port 8080

kube api server listens in default on 6443. Port 8080 was misleading
found using `netstat -tlpn | grep kube` or `ss -tlpn | grep kube`

issue still is there but can't find what exactly it is. For know cluster works, is operational, and crashes NOT always when deploying, for now, sealed secret and argocd helm chart

events show missing persistent volume- found out using `kubectl events`

`7m38s       Warning   InvalidDiskCapacity       Node/junkyard-01   invalid capacity 0 on image filesystem`

this started while deploying ArgoCD which needs persistent volumes. Need to check Container Storage Interface and Storage Driver

`crictl info`

Check for peristent volume
`kubectl get pv`
`kubectl get pvc --all-namespaces`

Check storage class
`kubectl get storageclass`

check if CSI is running
`kubectl get pods -n kube-system | grep -i storage`

check if containerd can pull image
`crictl pull nginx:latest`

check storage related config in kubelet
`grep -i storage /var/lib/kubelet/config.yaml`




helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm install sealed-secrets -n kube-system --set-string fullnameOverride=sealed-secrets-controller sealed-secrets/sealed-secrets

KUBESEAL_VERSION='0.27.1'
curl -OL "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION:?}/kubeseal-${KUBESEAL_VERSION:?}-linux-amd64.tar.gz"
tar -xvzf kubeseal-${KUBESEAL_VERSION:?}-linux-amd64.tar.gz kubeseal
sudo install -m 755 kubeseal /usr/local/bin/kubeseal
echo "installed sealed-secrets on cluster and kubeseal on your machine"

echo "downloading certificate"
kubeseal --fetch-cert >~/.kube/kubeseal_local_cert.pem
echo "certificate installed in ~/.kube/kubeseal_local_cert.pem"

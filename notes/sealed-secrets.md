To keep some secrets safe without need of external secret provider this cluster will use in some cases a Sealed-Secrets tool.

Made two scripts for that:
- sealed-secrets_init.sh will install sealed secrets on the cluster, install kubeseal on your machine and download certificate. This cert is renewed every 30 days.
- sealed-secrets_create_secret.sh will create secret based on provided json file and deploy if allowed to the cluster.



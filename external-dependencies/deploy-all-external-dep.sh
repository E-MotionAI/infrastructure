helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install mongodb -f mongo-db/values.yaml bitnami/mongodb
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install mongodb -f mongo-db/values.yaml bitnami/mongodb
chmod +x cloudflare-tunnel/deploy_tunnel.sh
cloudflare-tunnel/deploy_tunnel.sh
helm install postgres -f postgres-db/values.yaml oci://registry-1.docker.io/bitnamicharts/postgresql --namespace magic-key

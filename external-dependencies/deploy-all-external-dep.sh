helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
chmod +x cloudflare-tunnel/deploy_tunnel.sh
cloudflare-tunnel/deploy_tunnel.sh
helm install postgres -f postgres-db/values.yaml oci://registry-1.docker.io/bitnamicharts/postgresql --namespace magic-key

# Deploy keycloak - https://www.keycloak.org/getting-started/getting-started-kube

# 1. Setup certificates for ssl
# 1.1 Create a certificate with self signed key. example.cert example.key
# .key is a private key and a .cert is a public key.
# Browser (or other client) connects to your server over HTTPS. Then our server sends the public key to the client. The client
# checks the public key against a list of trusted certificate authorities (CAs). If the public key is valid, the client can trust the server.
# The private key is never sent to the client. It is used by the server to decrypt messages sent by the client.
# When someone encrypts data using your public key, only your private key can decrypt it. (TLS/SSL)
# You can sign data with your private key, and anyone with your public key can verify the signature. (JWT)
# Certificate binds the public key to an entity.
# openssl req -x509 -newkey rsa:2048 -nodes -keyout example.key -out example.crt -days 765

# Create a keystore p12 and add to a java keystore
# sudo openssl pkcs12 -export -out keycloak.p12 -inkey example.key -in example.crt -name keycloak-certificate
#password=test123
# Create a java keystore from the p12 file
# sudo keytool -importkeystore -srckeystore keycloak.p12 -destkeystore keycloak.jks -srcstoretype pkcs12

# Create a secret in kubernetes with the keystore
# kubectl create secret tls keycloak-tls --key="example.key" --cert="example.crt" -n magic-key

# 1.2. Setup keycloak on kubernetes
# minikube addons list
# minikube addons enable ingress
# kubectl create -f keycloak-ingress.yaml -n magic-key
# kubectl create -f keycloak.yaml -n magic-key

helm install keycloak bitnami/keycloak --version 24.4.9 -n magic-key -f keycloak/keycloak.yaml
Expose your service to the Internet using Cloudflare Tunnel.

## 🚀 Steps:

1. Install Cloudflared in your local machine.
2. Have a public domain name. example.com will be used for the sack of testing.
3. Run the following command to login into cloudflare:
```bash
cloudflared tunnel login
```

Add your domain to on Cloudfare dashboard. Dont forget to add the Cloudflare nameservers to your
domain like documented on Cloudflare.

4. Create a tunnel:
```bash
cloudflared tunnel create k8s-tunnel
```

The command above will output a tunnel ID and credentials file.

5. Create a secret in your Kubernetes cluster pointing to your tunnel credentials file:
```bash
kubectl create secret generic tunnel-credentials \
--from-file=credentials.json=<path of credential file>
```

5. Create a DNS record onto Cloudflare dashboard pointing to your tunnel id:
TYpe CNAME with Name as your domain name and IPv4 address as <tunnel ID>.cfargotunnel.com

6. Deploy the tunnel to your Kubernetes using deployment-manifest.yaml file. 
You can fine tune your routing on the configmap part of the deployment.

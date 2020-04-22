## nginx-lego

A custom nginx image built from [nginx:alpine](https://hub.docker.com/_/nginx) docker image with auto-renewing Letsencrypt SSL functionality.

nginx-lego image performs auto-instantiation / renewal of Letsencrypt SSL certificate using [LEGO](https://github.com/go-acme/lego) (Letsencrypt GO client) if the image is provided with a domain name and an admin email. These are specified by providing these environment variables to the image:
- SSL_DOMAIN
- SSL_ADMIN_EMAIL

To build the docker image:
```bash
docker build -t nginx-lego:alpine .
```

To run the docker image via command line (eg. for example.com domain):
```bash
docker run --rm -it -e SSL_DOMAIN=example.com -e SSL_ADMIN_EMAIL=admin@example.com nginx-lego:alpine
```

whereby passing the SSL_DOMAIN and SSL_ADMIN_EMAIL environment variables will instruct the nginx container to create and utilise an SSL cert for the domain name provided in SSL_DOMAIN and email any notifications to SSL_ADMIN_EMAIL.

The Dockerfile uses **nginx:alpine** as its base docker image and adds in the following customisation:
1. entrypoint.sh - A custom entrypoint script that does the following each time the image is started:
- initialises/renews the SSL cert
- runs the cron scheduler daemon (to periodically run the init/renew SSL script)
- starts nginx
- runs an infinite loop that reloads nginx configuration every 6 hours (to load a new SSL cert if the cert gets renewed)

2. init_or_renew_ssl - This script initialises the Letsencrypt SSL account/cert or renews the cert if the account / cert already exits within the docker image. Also links the current SSL cert (server.crt and server.key) in /etc/nginx via symbolic links.

<br/>

An example docker-compose.yml script is provided in this repository to demonstrate its usage.

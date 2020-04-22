#! /bin/sh

# SSL_DOMAIN and SSL_ADMIN_EMAIL environment variables must be present,
# otherwise we will not use letsencrypt

# Initialise or renew ssl cert
sh /etc/periodic/daily/init_or_renew_ssl

# Start cron daemon, SSL renewal will be run from cron.weekly
crond -L /var/log/crond.log

# Run nginx and a 6 hour loop to reload nginx configuration (to reload new SSL certs)
while :; do sleep 6h & wait ${!}; nginx -s reload; done & nginx -g "daemon off;"

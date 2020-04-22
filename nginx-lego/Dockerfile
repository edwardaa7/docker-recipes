FROM nginx:alpine

USER root

WORKDIR /etc/lego

RUN apk add curl openssl
RUN wget -O  lego.tar.gz `curl -Ls https://api.github.com/repos/xenolf/lego/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4`
RUN tar xf lego.tar.gz
RUN mv lego /usr/local/bin/lego

COPY entrypoint.sh /entrypoint.sh
COPY init_or_renew_ssl /etc/periodic/daily
RUN chmod a+rx /etc/periodic/daily/init_or_renew_ssl

EXPOSE 80
EXPOSE 443

VOLUME ["/etc/lego/accounts", "/etc/lego/certificates"]

CMD ["sh", "/entrypoint.sh"]

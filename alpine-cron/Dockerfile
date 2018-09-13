FROM alpine:latest

WORKDIR /app
ADD . /app

RUN cat /app/crontab >> /etc/crontabs/root
RUN touch /var/log/cron.log

CMD crond && tail -f /var/log/cron.log

# Stage 1, build all python dependencies for the project
FROM python:3.6-alpine3.4 AS builder

WORKDIR /app
ADD requirements.txt .

# All setup processes squashed to one layer
RUN apk add --update --no-cache openrc && \
    # Set local time to +8 UTC
    apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime && \
    echo "Asia/Kuala_Lumpur" >  /etc/timezone && \
    # Install build dependencies
    apk add --no-cache --virtual .build-deps \
        build-base \
        gcc \
        abuild \
        binutils \
        binutils-doc \
        gcc-doc \
        linux-headers \
        python3-dev \
        libffi-dev \
        openssl-dev \
        libxml2-dev \
        libxslt-dev && \
    apk add --no-cache libxml2 && \
    # Upgrade pip, install uwsgi, install Django dependencies
    pip install --upgrade pip && \
    pip install --no-cache-dir uwsgi && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del .build-deps


# Stage 2, copy all built python dependencies from Stage 1 and initialise app
FROM python:3.6-alpine3.4

COPY --from=builder /usr/lib /usr/lib
COPY --from=builder /usr/local /usr/local
COPY --from=builder /etc/localtime /etc/localtime
COPY --from=builder /etc/timezone /etc/timezone

WORKDIR /app
ADD uwsgi.ini .
ADD django_entrypoint.sh .
ADD project .

# Setup app stuff
RUN mkdir -p /var/log/project && \
    mkdir -p /var/log/uwsgi && \
    # Remove unwanted files
    find / -type d -name __pycache__ -exec rm -r {} + && \
    rm -rf /root/.cache /var/cache /usr/share/terminfo

# Run database migration and collectstatic, start uwsgi server and qcluster
CMD ["sh", "django_entrypoint.sh"]

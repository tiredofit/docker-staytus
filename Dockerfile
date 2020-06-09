FROM tiredofit/ruby:2.6-alpine
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

## Install Packages
RUN apk update && \
    apk add -t .staytus-build_deps \
        build-base \
        git \
        libc-dev \
        libsass \
        linux-headers \
        mariadb-dev \
        && \
    \
    apk update && \
    apk add -t .staytus-run_deps \
        mariadb-client \
        mariadb-connector-c \
        ruby-json \
        nodejs && \
    \
## Install Staytus
    \
    mkdir -p /app/staytus && \
    git clone https://github.com/adamcooke/staytus.git /app/staytus && \
    cd /app/staytus && \
    git fetch origin && \
    git checkout master && \
    \
    cd /app/staytus && \
    bundle install --deployment --without development:test && \
    \
## Cleanup
    apk del .staytus-build_deps && \
    rm -rf /var/cache/apk/* \
           /app/staytus/docker-start.sh \
           /app/staytus/doc \
           /app/staytus/DOCKER_README.md \
           /app/staytus/Dockerfile \
           /app/staytus/LICENSE \
           /app/staytus/README.md \
           /app/staytus/ROADMAP.md

### Networking Configuration
EXPOSE 8787

### Entrypoint Configuration
WORKDIR /app/staytus

### Add Files
ADD install/ /


# github.com/tiredofit/docker-staytus

[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/staytus.svg)](https://hub.docker.com/r/tiredofit/staytus)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/staytus.svg)](https://hub.docker.com/r/tiredofit/staytus)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/staytus.svg)]

## About

Dockerfile to build a [Staytus](https://github.com/adamcooke/staytus)  container image.

* This Container uses a [customized Alpine Linux base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) based on TRUNK compiled for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, mariadb-client, nano, vim) for easier management. It also supports sending to external SMTP servers..


[Changelog](CHANGELOG.md)

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Database](#database)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

## Prerequisites and Assumptions

This image assumes that you are using a reverse proxy such as [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) or [traefik](https://github.com/traefik/traefik).

You will also need an external MariaDB server for storage.

## Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/r/tiredofit/staytus) and is the recommended method of installation.


```bash
docker pull tiredofit/staytus:(imagetag)
```

The following image tags are available:

* `latest` - Most recent release of Staytus

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

## Configuration

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/assets/staytus` | Use this directory if you would like to copy custom themes to overwrite default on startup |

### Database

Create a MariaDB database and set the environment variables below to make connection.

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine) and [Ruby Image](https://hub.docker.com/r/tiredofit/ruby), below is the complete list of available options that can be used to customize your installation.

| Parameter | Description |
|-----------|-------------|
| `DB_HOST` | MariaDB Database hostname e.g. `staytus-db` |
| `DB_NAME` | Database Name e.g. `staytus` |
| `DB_USER` | Database User e.g. `user` |
| `DB_PASS` | Database Password e.g. `password` |
| `STAYTUS_SMTP_HOSTNAME` | SMTP Server Hostname e.g. `postfix-relay` |
| `STAYTUS_SMTP_PORT` | SMTP Server Port to connect to e.g. `25` |
| `STAYTUS_SMTP_USERNAME` | (optional) SMTP Username e.g. `user` |
| `STAYTUS_SMTP_PASSWORD` | (optional) SMTP Password e.g. `password` |

If you enable `DEBUG_MODE=TRUE` you will get increased verbosity in the logs.

### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `8787`    | Puma Web Daemon | 		    |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. staytus) bash
```

## References

* https://github.com/adamcooke/staytus


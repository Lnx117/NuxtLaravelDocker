#!/usr/bin/env bash

set -e

COMPOSE_FILE=compose.local.yaml
APP_SERVICE=app
REVERSE_PROXY_NETWORK=reverse-proxy
TEMP_DIR=tmp

docker network create --driver bridge $REVERSE_PROXY_NETWORK 2>/dev/null || true

docker compose -f $COMPOSE_FILE build

docker compose -f $COMPOSE_FILE run --rm --no-deps $APP_SERVICE npm install

docker compose -f $COMPOSE_FILE up -d

if [ "$1" == "--destruct" ]; then
    echo "Removing installation script"
    rm ./install.sh
fi

echo "The web app has been installed and run on http://localhost:3000."
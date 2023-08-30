#!/bin/bash

VERSION=$(git rev-parse --verify HEAD)
set -e
echo "Using version $VERSION"
echo "Building flutter web package"
fvm flutter build web
echo "Building docker image"
DOCKER_IMAGE=registry.gitlab.com/digital-pv/deployment/dpv-web:$VERSION
docker build -t $DOCKER_IMAGE .
echo "Pushing to registry"
docker push $DOCKER_IMAGE
echo "USE $DOCKER_IMAGE" in terraform deployments
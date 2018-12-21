#!/bin/bash

VERSION=$1

docker build -f Dockerfile -t ualex73/devolo-avpromanager .

# Tag it with a version
if [ ! -z "$VERSION" ]; then
  docker tag ualex73/devolo-avpromanager ualex73/devolo-avpromanager:${VERSION}
fi


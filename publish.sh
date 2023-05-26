#!/bin/bash

# npx @techdocs/cli publish \
# --publisher-type awsS3 \
# --storage-name tap-techdocs \
# --entity where-for-dinner/component/where-for-dinner
# Build the docker image
docker build . -t techdocs --no-cache

# Run the docer image to generate the site and upload it
# docker run --rm --env-file .env -v ./:/tmp/catalog/ techdocs /tmp/catalog/mkdocs.yaml awsS3 tap-techdocs
docker run --rm --env-file .env -v ./:/tmp/catalog/ techdocs /tmp/catalog/catalog-info.yaml awsS3 tap-techdocs
# Where For Dinner Techdocs Builder

This repo helps me build and publish technical documentation for a sample Backstage "System" called "Where For Dinner" and one of its Backstage "Components" called "Where For Dinner UI"

The [Dockerfile](Dockerfile) creates an image based on [Spotify/Techdocs]() and adds a script called [generateAndPublish.sh](generateAndPublish.sh) as the entrypoint.

To build the `techdocs` image run:

```bash
docker build . -t techdocs --no-cache
```

When called during a `docker run` of the `techdocs` image, the above script can build the techdocs and publish them to an AWS bucket (using creds in the `.env` file). The command line for this looks something like this...

```bash
docker run --rm --env-file .env -v ./:/tmp/catalog/ techdocs /tmp/catalog/catalog-info.yaml awsS3 tap-techdocs
```

The [catalog-info.yaml](catalog-info.yaml) in the root of this repo is used as a signpost to say which techdocs the script should attempt to build and publish.

Once you have built the `techdocs` image, you can use it anywhere you have a a similar `catalog-info.yaml` file. You are not restricted to only building Where For Dinner. 
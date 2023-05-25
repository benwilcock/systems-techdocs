# Build this docker image with `docker build . -t techdocs --no-cache`
# Put your environment variables into a .env file
# if publishing to awsS3, you must set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
# if publishing to googleGcs, you must set GOOGLE_APPLICATION_CREDENTIALS
# It can be run with:
# docker run --rm --env-file .env -v ./:/tmp/catalog/ techdocs /tmp/catalog/mkdocs.yaml awsS3 tap-techdocs

FROM spotify/techdocs

WORKDIR /app

COPY ./generateAndPublish.sh .

RUN apk --update add npm

RUN npm install @techdocs/cli

RUN apk --update add yq

ENTRYPOINT ["sh", "/app/generateAndPublish.sh"]

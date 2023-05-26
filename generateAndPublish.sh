#!/bin/bash

# Insert your CREDS into .env first
# Required environment variables:
# if publishing to awsS3, you must set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
# if publishing to googleGcs, you must set GOOGLE_APPLICATION_CREDENTIALS
# For more details see https://backstage.io/docs/features/techdocs/using-cloud-storage

# Checks a directory path to see if it contains a mkdocs yaml file
# Sets the mkdocsFileExists boolean accordingly
doesMkdocsFileExist() {
    mkdocs_yml_absolute_path=$(echo "$1"/mkdocs.yml)
    mkdocs_yaml_absolute_path=$(echo "$1"/mkdocs.yaml)

    if [ -f $mkdocs_yml_absolute_path ]; then
        mkdocsFileExists=true
    fi

    if [ -f $mkdocs_yaml_absolute_path ]; then
        mkdocsFileExists=true
    fi
}

# Generates and publishes TechDocs for a backstage yaml file
# Required parameters:
# Path to the root catalog yaml file
# Publisher type: awsS3 | googleGcs
# Storage name: Name of the bucket to publish to
generateAndPublish() {
    target_absolute_path=$1
    target_dir_path=$(dirname $target_absolute_path)

    mkdocsFileExists=false
    doesMkdocsFileExist $target_dir_path

    if [ "$mkdocsFileExists" = true ]; then

        namespace=$(yq e '.metadata.namespace' "$target_absolute_path" | head -n 1)
        
        if [ "$namespace" = "null" ]; then
            namespace="default"
        fi

        kind=$(yq e '.kind' "$target_absolute_path" | head -n 1)
        name=$(yq e '.site_name' "$target_absolute_path" | head -n 1)
        echo "Target:             " $target_absolute_path
        echo "Namespace/Kind/Name:" $namespace/$kind/$name
        echo "Running npx to generate techdocs"
        generate_output=$(npx @techdocs/cli generate --no-docker --source-dir $target_dir_path --output-dir $techdocs_temp_dir)
        echo "$generate_output"
        # check output for success before publishing
        if echo $generate_output | grep -q 'Successfully generated docs'; then
            npx @techdocs/cli publish --publisher-type $2 --storage-name $3 --entity $namespace/$kind/$name --directory $techdocs_temp_dir
        fi
    else
        echo "Target:             " $target_absolute_path
        echo "Note: mkdocs yaml file does not exist for" $target_absolute_path
    fi
}

# User clones the repo locally and passes in the path to root catalog yaml.
# TechDocs are generated and published for the root catalog yaml and the target yaml files listed within it.
# Required parameters:
# Path to the root catalog yaml file
# Publisher type: awsS3 | googleGcs
# Storage name: Name of the bucket to publish to
# Required environment variables:
# if publishing to awsS3, you must set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
# if publishing to googleGcs, you must set GOOGLE_APPLICATION_CREDENTIALS
# For more details see https://backstage.io/docs/features/techdocs/using-cloud-storage
main() {

    if [ "$#" -ne 3 ]
    then
        echo "Usage: generateAndPublish.sh <path to the root catalog yaml> {awsS3|googleGcs} <name of the bucket to publish to>"
        echo "If publishing to awsS3, you must set the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY"
        echo "If publishing to googleGcs, you must set the environment variable GOOGLE_APPLICATION_CREDENTIALS"
        echo "For more details see https://backstage.io/docs/features/techdocs/using-cloud-storage"
        exit 1
    fi

    # reliably create a temporary directory that works on both Linux and Darwin
    techdocs_temp_dir=$(mktemp -d 2>/dev/null || mktemp -d -t 'techdocs')

    # Generate and publish for root catalog yaml
    # generateAndPublish $1 $2 $3

    # Generate and publish for each target yaml file in the root catalog yaml
    number_of_targets=$(yq e '.spec.targets | length' $1)
    for i in $(seq 0 $(expr $number_of_targets - 1))
    do
        catalog_dir_path=$(dirname $1)
        target_relative_path=$(yq e ".spec.targets[$i]" $1)
        target_absolute_path=$(echo "$catalog_dir_path"/"$target_relative_path")
        generateAndPublish $target_absolute_path $2 $3
    done
}

main $1 $2 $3

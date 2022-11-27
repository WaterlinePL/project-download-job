#!/bin/bash

project_minio_path=$1

mc alias set minio https://$ENDPOINT $ACCESS_KEY $SECRET_KEY --api S3v4
mc cp $project_minio_path /workspace/ --recursive

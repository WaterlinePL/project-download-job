#!/bin/bash

IFS=':'
project_name=$1

mc alias set minio https://$ENDPOINT $ACCESS_KEY $SECRET_KEY --api S3v4
mkdir /workspace/$project_name
for model in "${@:2}"
do
    read -ra model_type_and_name <<< $model
    model_type=${model_type_and_name[0]}
    model_name=${model_type_and_name[1]}
    mc cp minio/$model_type/$model_name.zip /workspace/$project_name/$model_type/$model_name.zip
    unzip /workspace/$project_name/$model_type/$model_name.zip -d /workspace/$project_name/$model_type/$model_name
    rm /workspace/$project_name/$model_type/$model_name.zip
    if [ $model_type = "hydrus" ]; then
        mc cp minio/hydrus-shapes/$1_$model_name.npy /workspace/$project_name/hydrus_shapes/$model_name.npy
    fi
done

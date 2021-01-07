#!/bin/bash


while getopts d:a: flag
do
    case "${flag}" in
        d) database=${OPTARG};;
        a) alias=${OPTARG};;
    esac
done

echo "database: $database";

mkdir -p /briq/mongodb/data/database

cd /briq/mongodb/data/$database

tar -cvf /briq/mongodb/data/database/database.tar *

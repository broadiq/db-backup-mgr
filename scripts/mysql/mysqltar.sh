#!/bin/bash


while getopts d:a: flag
do
    case "${flag}" in
        d) database=${OPTARG};;
        a) alias=${OPTARG};;
    esac
done

#echo "database: $database";


cd /briq/mysql/data/tmp

tar -cvf /briq/mysql/data/database/database.tar *

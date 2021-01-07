#!/bin/bash


while getopts u:s:p:h:d:a:c: flag
do
    case "${flag}" in
        u) user=${OPTARG};;
        s) password=${OPTARG};;
        p) port=${OPTARG};;
        h) host=${OPTARG};;
        d) database=${OPTARG};;
        a) alias=${OPTARG};;
        c) connectionStr=${OPTARG};;
    esac
done
echo "User: $user";
#echo "password: $password";
#echo "port: $port";
#echo "host: $host";
echo "database: $database";
echo "database Alias: $alias";

#mongodump --host=$host --port=$port --username=$user -p $password --authenticationDatabase=admin -d $database -o /briq/mongodb/data >&2

mongodump --uri="$connectionStr" --out /briq/mongodb/data

/briq/mongodb/scripts/mongotar.sh -d $database

rm -rf /briq/mongodb/data/$database



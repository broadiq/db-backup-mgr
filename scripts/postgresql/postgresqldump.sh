#!/bin/bash


while getopts u:s:p:h:d:a: flag
do
    case "${flag}" in
        u) user=${OPTARG};;
        s) password=${OPTARG};;
        p) port=${OPTARG};;
        h) host=${OPTARG};;
        d) database=${OPTARG};;
        a) alias=${OPTARG};;
    esac
done
echo "User: $user";
#echo "password: $password";
#echo "port: $port";
#echo "host: $host";
echo "database: $database";
echo "database Alias: $alias";

echo "Creating directories..."
mkdir -p /briq/postgresql/data/database
mkdir -p /briq/postgresql/data/tmp


echo "Dumping database..."

export MYDB=postgresql://$user:$password@$host:$port/$database
pg_dump --dbname=$MYDB > /briq/postgresql/data/tmp/pgdump.sql

echo "Tarring database files..."
/briq/postgresql/scripts/postgresqltar.sh

echo "clean up..."
rm -rf /briq/postgresql/data/tmp

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

/briq/postgresql/scripts/postgresqluntar.sh

export MYDB=postgresql://$user:$password@$host:$port/$database

psql --dbname=$MYDB < /briq/postgresql/data/tmp/pgdump.sql

rm -rf /briq/postgresql/data/tmp

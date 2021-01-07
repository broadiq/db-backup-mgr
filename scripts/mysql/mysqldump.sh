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
mkdir -p /briq/mysql/data/database
mkdir -p /briq/mysql/data/tmp


echo "Dumping database..."
mysqldump -u$user -p$password --host=$host --port=$port $database > /briq/mysql/data/tmp/mysqldump.sql 

echo "Tarring database files..."
/briq/mysql/scripts/mysqltar.sh

echo "clean up..."
rm -rf /briq/mysql/data/tmp






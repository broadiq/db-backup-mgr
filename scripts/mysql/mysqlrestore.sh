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


/briq/mysql/scripts/mysqluntar.sh


mysql --user=$user --port=$port --host=$host --password=$password $database < /briq/mysql/data/tmp/mysqldump.sql


rm -rf /briq/mysql/data/tmp



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




#MYDIR="/briq/mongodb/data"
#BACKUPDIR=""
#for file in $(find $MYDIR -maxdepth 1 -type d) #or you can use the awk one here
#do
#  if [ "$MYDIR" != "$file" ]; then
#   BACKUPDIR=$file
#   break;
#  fi

#done

#echo $BACKUPDIR

/briq/mongodb/scripts/mongountar.sh


#mongorestore --host=$host --port=$port --username=$user -p $password --authenticationDatabase=admin -d $database --dir=/briq/mongodb/data/database >&2

mongorestore --uri="$connectionStr" -d $database --dir=/briq/mongodb/data/database 

rm -rf /briq/mongodb/data/database/*

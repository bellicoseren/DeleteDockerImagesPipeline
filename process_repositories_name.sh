#!/bin/bash

while read line 
do
 echo $line ----------;
 project=$(echo $line | cut -d / -f 1;)
 repository=$(echo $line | cut -d / -f 2;)
 curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$line/repositories" -o repositoriesnames$line.json
 cat repositoriesnames$line.json | jq '.[].name' > repository$linelist.txt
 sed -i 's/"//g' repository$linelist.txt
 cat repositoriesnames$line.json
 cat repository$linelist.txt
done < $1;

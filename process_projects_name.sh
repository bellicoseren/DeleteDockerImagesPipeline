#!/bin/bash

while read line 
do
 echo "+++ Checking project $line +++";

 curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$line/repositories" -o repositoriesnames$line.json
 cat repositoriesnames$line.json | jq '.[].name' > repository$linelist.txt
 sed -i 's/"//g' repository$linelist.txt
 # cat repositoriesnames$line.json | jq
 echo "+++ Lista de repositorios +++"
 cat repository$linelist.txt
 echo "+++ Fin de lista +++"
 ./process_repositories_name.sh repository$linelist.txt
done < projectlist.txt;

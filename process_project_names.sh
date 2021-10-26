#!/bin/bash

while read line 
do
 echo $line ----------;
 echo "curl -u admin:Harbor12345 -sS -X GET 'http://172.18.0.1/api/v2.0/projects/$line/repositories' -o repositoriesnames.json"

 somevariable="$(curl -u admin:Harbor12345 -sS -X GET 'http://172.18.0.1/api/v2.0/projects/$line/repositories' -o repositoriesnames.json)";
 echo $somevariable;
 
done < projectlist.txt;

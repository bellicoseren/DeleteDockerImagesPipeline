#!/bin/bash

while read line 
do
 echo $line ----------;
 project=$(echo $line | cut -d / -f 1;)
 repository=$(echo $line | cut -d / -f 2;)
 curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$project/repositories/$repository/artifacts" -o artifactname$project_$repository.json
 # /projects/{project_name}/repositories/{repository_name}/artifacts
 cat artifactname$project_$repository.json | jq '.[].name' > artifact$project_$repositorylist.txt
 sed -i 's/"//g' artifactname$project_$repository.json
 cat artifactname$project_$repository.json | jq
 cat artifact$project_$repositorylist.txt
done < $1;

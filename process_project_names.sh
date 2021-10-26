#!/bin/bash

while read line 
do
 echo $line ----------;

 curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$line/repositories" -o repositoriesnames$line.json
                 
 cat repositoriesnames$line.json
done < projectlist.txt;

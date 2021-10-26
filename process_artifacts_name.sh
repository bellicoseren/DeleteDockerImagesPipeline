#!/bin/bash

 count=0;
 temp=$2
 half_temp=$((temp / 2))
 echo "La mitad del total de lineas en el archivo: $half_temp"

while read line 
do

 echo "+++ Checking artifacts $line +++";
 if [[ $count -lt $half_temp ]] 
 then
   url=$(echo $line | cut -d / -f 5,7;)
   project=$(echo $url | cut -d / -f 1;)
   repository=$(echo $url | cut -d / -f 2;)
 else
   tag=$(echo $line | cut -d / -f 3;)
   echo "curl -H 'authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=' -sS -X GET 'http://172.18.0.1/api/v2.0/projects/$project/repositories/$repository/artifacts/$tag?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false' -H 'accept: application/json' -o tag$project$repository$tag.json" 
   curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$project/repositories/$repository/artifacts/$tag?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -o tag$project$repository$tag.json
   # curl -X GET "http://localhost/api/v2.0/projects/cicd/repositories/jenkins/artifacts/1.0?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -H "X-Accept-Vulnerabilities: application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU="
   # curl -X GET "http://localhost/api/v2.0/projects/test/repositories/vault/artifacts?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -H "X-Accept-Vulnerabilities: application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU="
   # /projects/{project_name}/repositories/{repository_name}/artifacts/{reference}
   checklabels="$(cat tag$project$repository$tag.json | jq '.labels[].name' 2>/dev/null)"
   if [[ -z $checklabels ]]
   then
     echo "La imagen $project/$repository:$tag no cuenta con etiquetas"
   else 
     echo "La imagen $project/$repository:$tag cuenta con etiquetas"
   fi
   cat tag$project$repository$tag.json | jq '.labels[].name' 2>/dev/null > tag$project$repository$tag.txt
   sed -i 's/"//g' tag$project$repository$tag.txt
   cat tag$project$repository$tag.json | jq
   echo "+++ Lista de labels de la imagen $project/$repository:$tag +++"
   cat tag$project$repository$tag.txt
   echo "+++ Fin de la lista de labels +++"
 fi
  
 count+=1;
 
done < $1;

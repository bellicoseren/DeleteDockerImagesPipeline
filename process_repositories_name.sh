#!/bin/bash

while read line 
do
 echo "+++ Checking repositories $line +++";
 project=$(echo $line | cut -d / -f 1;)
 repository=$(echo $line | cut -d / -f 2;)
 curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$project/repositories/$repository/artifacts?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -o artifactname$project$repository.json
 # curl -X GET "http://localhost/api/v2.0/projects/test/repositories/vault/artifacts?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -H "X-Accept-Vulnerabilities: application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU="
 # /projects/{project_name}/repositories/{repository_name}/artifacts
 # cat artifactname$project$repository.json | jq '.[].tags[].name' > artifact$project$repositorylist.txt
 cat artifactname$project$repository.json | jq '.[].addition_links.build_history.href, .[].tags[].name' > artifact$project$repositorylist.txt
 sed -i 's/"//g' artifact$project$repositorylist.txt
 # cat artifactname$project$repository.json | jq
 echo "+++ Lista de artefactos +++"
 cat artifact$project$repositorylist.txt
 echo "+++ Fin de lista de artefactos +++"
 num_lines="$(cat artifact$project$repositorylist.txt | wc -l)"
 echo "File size: $num_lines"
 ./process_artifacts_name.sh artifact$project$repositorylist.txt $num_lines
done < $1;



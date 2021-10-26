#!/bin/bash

while read line 
do
 echo "+++ Checking artifacts $line +++";
 project=$(echo $line | cut -d / -f 1;)
 repository=$(echo $line | cut -d / -f 2;)
 tag=$(echo $line | cut -d / -f 3;)
 
 curl -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU=" -sS -X GET "http://172.18.0.1/api/v2.0/projects/$project/repositories/$repository/artifacts/$tag?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -o tag$project$repository$tag.json
 # curl -X GET "http://localhost/api/v2.0/projects/cicd/repositories/jenkins/artifacts/1.0?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -H "X-Accept-Vulnerabilities: application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU="
 # curl -X GET "http://localhost/api/v2.0/projects/test/repositories/vault/artifacts?page=1&page_size=10&with_tag=true&with_label=true&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H "accept: application/json" -H "X-Accept-Vulnerabilities: application/vnd.scanner.adapter.vuln.report.harbor+json; version=1.0" -H "authorization: Basic YWRtaW46SGFyYm9yMTIzNDU="
 # /projects/{project_name}/repositories/{repository_name}/artifacts/{reference}
 # cat artifactname$project$repository.json | jq '.[].tags[].name' > artifact$project$repositorylist.txt
 # sed -i 's/"//g' artifact$project$repositorylist.txt
 # cat artifactname$project$repository.json | jq
 # cat artifact$project$repositorylist.txt
done < $1;

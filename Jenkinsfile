pipeline {
  environment {
    registry = "harbor"
    registryCredential = "dockerhub"
  }
  agent any
  stages {
    
    stage('Clean Up Table') {
      steps {
        sh """mysql -h 172.17.0.3 -u root -prenehr -e 'truncate table jenkins.harbor'"""
      }
    } 
    stage('Project list') {
      steps {
        //sh """curl -X GET "http://172.18.0.1/api/v2.0/projects?page=1&page_size=10&with_detail=true" -H 'accept: application/json'"""
        //sh """curl -u admin:Harbor12345 -i -k -X GET 'http://172.18.0.1/api/v2.0/projects/'"""
        //sh """curl -u admin:Harbor12345 -i -k -X GET 'http://172.18.0.1/api/v2.0/projects/' > REPOS.json"""
        sh """curl -u admin:Harbor12345 -sS -X GET 'http://172.18.0.1/api/v2.0/projects/' -o projectname.json"""
        sh """cat projectname.json | jq '.[].name' > projectlist.txt"""
        sh """sed -i 's/"//g' projectlist.txt """
        sh """cat projectname.json | jq"""
        sh """cat projectlist.txt"""
      }
    }
    stage('Get Repositories from project') {
      steps {
        sh """chmod 777 process_projects_name.sh process_repositories_name.sh process_artifacts_name.sh"""
        sh """./process_projects_name.sh"""
        sh """ls -larth"""
      }
    } 
    stage('Get Project by ID Theme') {
      steps {
        sh """curl -u admin:Harbor12345 -i -k -X GET 'http://172.18.0.1/api/v2.0/projects/test/repositories/my_theme'"""
        sh """pwd """
        sh """awk '/vault/ {print /var/jenkins_home/workspace/DeleteImages/REPOS.json}' /var/jenkins_home/workspace/DeleteImages/REPOS.json | tr -d '",' 's:.*/::' | sort > /var/jenkins_home/workspace/DeleteImages/repo.txt"""
              //awk '/name/ {print                                                   $2}'                                  $folder/$repo.json | tr -d '",' | sort > $folder/$repo.txt;
        //sh """curl -X GET "http://172.18.0.1/api/v2.0/projects/test/repositories/docker-maven-sample/artifacts?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H 'accept: application/json'"""
      }
    }
    
    stage('Get Project by ID Vault') {
      steps {
        sh """curl -u admin:Harbor12345 -i -k -X GET 'http://172.18.0.1/api/v2.0/projects/test/repositories/vault'"""
        //sh """curl -X GET "http://172.18.0.1/api/v2.0/projects/test/repositories/docker-maven-sample/artifacts?page=1&page_size=10&with_tag=true&with_label=false&with_scan_overview=false&with_signature=false&with_immutable_status=false" -H 'accept: application/json'"""
      }
    }
    //stage('Delete') {
    //  steps {
    //    sh """curl -u admin:Harbor12345 -i -k -X DELETE 'http://172.18.0.1/api/v2.0/projects/test/repositories/my_theme'"""
    //  }
    //}
   //stage('Building image') {
      //steps{
        //script {
          //docker.build registry + ":$BUILD_NUMBER"
        //}
      //}
    //}
  }
}

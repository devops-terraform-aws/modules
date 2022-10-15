pipeline {
   agent any
   stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[credentialsId: 'enterCredID', 
                url: 'https://github.com/devops-terraform-aws/modules.git']]])
            }
        }     
    }
}
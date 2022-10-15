pipeline {
   agent any
   stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[credentialsId: '285e2fb0-9545-4592-b5f0-e1570ba79753', 
                url: 'https://github.com/devops-terraform-aws/modules.git']]])
            }
        }     
    }
}
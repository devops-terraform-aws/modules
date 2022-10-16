pipeline {
   agent any
   stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[credentialsId: 'd9b6fb64-d9ea-4295-96eb-a1c3caf3afef', 
                url: 'https://github.com/devops-terraform-aws/modules.git']]])
            }
        }     
    }
}
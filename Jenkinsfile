pipeline {
   agent any
   stages {
        stage("Checkout") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[credentialsId: 'd9b6fb64-d9ea-4295-96eb-a1c3caf3afef', 
                url: 'https://github.com/devops-terraform-aws/modules.git']]])
            }
        }

        stage('SonarQube Code Qulaity') {
                steps {
                withSonarQubeEnv('SonarQube') {
                    // sh 'mvn clean package sonar:sonar'
                    sh 'mvn -f MyWebApp/pom.xml sonar:sonar'
                }
            }
        }     
    }
}
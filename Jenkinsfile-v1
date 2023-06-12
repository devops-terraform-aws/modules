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

        stage("SonarQube Code Qulaity") {
                steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn -f MyWebApp/pom.xml sonar:sonar'
                }
            }
        }

        stage ('JaCoCo') {
                steps {
                jacoco()
            }
        }

        stage ('Nexus Upload') {
                steps {
                    nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: 'nexus_url:8081',
                    groupId: 'myGroupId',
                    version: '1.0-SNAPSHOT',
                    repository: 'maven-snapshots',
                    credentialsId: 'fc0f1694-3036-41fe-b3e3-4c5d96fcfd26',
                    artifacts: [
                    [artifactId: 'MyWebApp',
                    classifier: '',
                    file: 'MyWebApp/target/MyWebApp.war',
                    type: 'war']
                ])
            }
        }
        stage ('DEV Deploy') {
            steps {
                echo "deploying to DEV Env "
                deploy adapters: [tomcat9(credentialsId: '268c42f6-f2f5-488f-b2aa-f2374d229b2e', 
                path: '', 
                url: 'http://your_public_dns:8080')], 
                contextPath: null, 
                war: '**/*.war'
            }
        }

        stage ('Slack Notification') {
            steps {
                echo "deployed to DEV Env successfully"
                slackSend(channel:'your slack channel_name', message: "Job is successful, here is the info - Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        }

        stage ('DEV Approve') {
                steps {
                    echo "Taking approval from DEV Manager for QA Deployment"
                    timeout(time: 7, unit: 'DAYS') {
                    input message: 'Do you want to deploy?', submitter: 'admin'
                }
            }
        }

        stage ('QA Deploy') {
            steps {
                echo "deploying to QA Env "
                deploy adapters: [tomcat9(credentialsId: '268c42f6-f2f5-488f-b2aa-f2374d229b2e', 
                path: '', 
                url: 'http://your_dns_name:8080')], 
                contextPath: null, 
                war: '**/*.war'
            }
        }

        stage ('QA Approve') {
            steps {
                echo "Taking approval from QA manager"
                timeout(time: 7, unit: 'DAYS') {
                    input message: 'Do you want to proceed to PROD?', submitter: 'admin,manager_userid'
                }
            }
        }

        stage ('Slack Notification for QA Deploy') {
            steps {
                echo "deployed to QA Env successfully"
                slackSend(channel:'your slack channel_name', message: "Job is successful, here is the info - Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
        }  
    }
}     

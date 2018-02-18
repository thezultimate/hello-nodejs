pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:6-alpine'
                }
            }
            steps {
                sh 'npm install'
            }
        }
        stage('Dockerize') {
            agent {
                dockerfile {
                    filename 'Dockerfile'
                    dir '.'
                    label 'thezultimate/hello-nodejs'
                }
            }
            steps {
                
            }
        }
    }
}
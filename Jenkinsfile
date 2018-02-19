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
            agent any
            steps {
                sh 'docker build -t thezultimate/hello-nodejs .'
            }
        }
    }
}

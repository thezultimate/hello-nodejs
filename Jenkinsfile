pipeline {
    agent {
        docker {
            image 'node:6-alpine'
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Dockerize') {
            steps {
                sh 'docker build -t thezultimate/hello-nodejs .'
            }
        }
    }
}
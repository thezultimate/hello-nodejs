podTemplate(
    label: 'super-slave',
    containers: [
        containerTemplate(
            name: 'docker-image',
            image: 'docker',
            ttyEnabled: true,
            command: 'cat',
            envVars: [
                secretEnvVar(key: 'DOCKERHUB_USERNAME', secretName: 'dockerhub-thezultimate-credentials', secretKey: 'username'),
                secretEnvVar(key: 'DOCKERHUB_PASSWORD', secretName: 'dockerhub-thezultimate-credentials', secretKey: 'password')
            ]
        ),
        containerTemplate(
            name: 'node-image',
            image: 'node:6-alpine',
            ttyEnabled: true,
            command: 'cat'
        )
    ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
    ]
)

{
    node('super-slave') {
        stage('Build') {
            container('node-image') {
                sh "echo Contacting git repo"
                git 'https://github.com/thezultimate/hello-nodejs.git'
                sh "echo Starting npm install"
                sh "npm install"
            }
        }
        stage('Dockerize') {
            container('docker-image') {
                sh "echo Debug secrets"
                sh "export"
                sh "echo Starting docker build"
                sh "docker build -t thezultimate/hello-nodejs ."
            }
        }
    }
}

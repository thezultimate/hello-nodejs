podTemplate(
    label: 'super-slave',
    containers: [
        containerTemplate(name: 'docker-image', image: 'docker', ttyEnabled: true, command: 'cat'),
        containerTemplate(name: 'node-image', image: 'node:6-alpine', ttyEnabled: true, command: 'cat')
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
                sh "echo Starting docker build"
                sh "docker build -t thezultimate/hello-nodejs ."
            }
        }
    }
}

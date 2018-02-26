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
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
        secretVolume(mountPath: '/etc/mount', secretName: 'dockerhub-thezultimate-credentials')
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
                // sh "export"
                // sh "env"
                // sh "printenv"
                // sh "printenv DOCKERHUB_USERNAME"
                def username = sh "printenv DOCKERHUB_USERNAME"
                sh "echo ${username}"
                sh "ls -al /etc/mount/"
                sh "echo Printing environment variables"
                // sh "echo ${env.DOCKERHUB_USERNAME}"
                // sh "echo ${env.DOCKERHUB_PASSWORD}"

                // sh "echo Login to docker registry"
                // sh "docker login -u DOCKERHUB_USERNAME -p DOCKERHUB_PASSWORD"
                sh "echo Starting docker build"
                sh "docker build -t thezultimate/hello-nodejs ."
                // sh "echo Pushing docker image to registry"
                // sh "docker push thezultimate/hello-nodejs"
            }
        }
    }
}

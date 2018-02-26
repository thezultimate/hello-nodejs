import jenkins.model.*
import hudson.slaves.EnvironmentVariablesNodeProperty
import hudson.EnvVars

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
                def jenkins = Jenkins.instance
                EnvironmentVariablesNodeProperty prop = jenkins.getGlobalNodeProperties().get(EnvironmentVariablesNodeProperty.class)
                EnvVars global_env = prop.getEnvVars()

                sh "echo Debug secrets"
                // sh "export"
                // sh "env"
                // sh "printenv"
                sh "echo ${global_env}"
                sh "echo Printing environment variables"
                sh "echo ${env.DOCKERHUB_USERNAME}"
                sh "echo ${env.DOCKERHUB_PASSWORD}"
                // sh "echo Login to docker registry"
                // sh "docker login -u ${env.DOCKERHUB_USERNAME} -p ${env.DOCKERHUB_PASSWORD}"
                sh "echo Starting docker build"
                sh "docker build -t thezultimate/hello-nodejs ."
                // sh "echo Pushing docker image to registry"
                // sh "docker push thezultimate/hello-nodejs"
            }
        }
    }
}

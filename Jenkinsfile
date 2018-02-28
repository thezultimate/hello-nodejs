podTemplate(
    label: 'super-slave',
    containers: [
        containerTemplate(
            name: 'docker-image',
            image: 'docker',
            ttyEnabled: true,
            command: 'cat'
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
        secretVolume(mountPath: '/etc/variables', secretName: 'dockerhub-thezultimate-credentials')
    ]
)

{
    node('super-slave') {
        stage('Build') {
            container('node-image') {
                sh "echo Contacting git repo"
                git scm
                
                sh "echo Starting npm install"
                sh "npm install"
            }
        }
        stage('Dockerize') {
            container('docker-image') {
                def username = readFile '/etc/variables/username'

                sh "echo Login to docker registry"
                sh "cat /etc/variables/password | docker login -u ${username} --password-stdin"
                
                sh "echo Starting docker build"
                sh "docker build -t thezultimate/hello-nodejs ."
                
                sh "echo Pushing docker image to registry"
                sh "docker push thezultimate/hello-nodejs"
            }
        }
    }
}

pipeline {
    agent any

    stages {
        stage("Checkout") {
            steps {
                git branch: 'main',
                url: 'https://github.com/AlexRob2201/hometask.git'
            }
        }

        stage("Build and Test") {
            steps {
                script {
                    dockerImage = docker.build("alexrob2201/alexb.rob:latest")
                    sh """
                    #!/bin/bash
                    docker run -p 3000:80 alexrob2201/alexb.rob:latest test
                    """
                }
            }
        }

        stage("Publish") {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', '02') {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}

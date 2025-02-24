pipeline {
    agent any
 
    environment {
        REGISTRY = "docker.io"
        IMAGE_NAME = "lappiahnuamah/todojenkins"
        TAG = "latest"
    }
 
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/lappiahnuamah/TodoApi.git'
            }
        }
 
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $REGISTRY/$IMAGE_NAME:$TAG ."
                }
            }
        }
 
        stage('Login and Push to Docker Registry') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
                    script {
                        sh "docker push $REGISTRY/$IMAGE_NAME:$TAG"
                    }
                }
            }
        }
    }
}

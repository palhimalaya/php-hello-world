pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'palhimalaya/php-hello-world-app:latest'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/palhimalaya/php-hello-world']])
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u palhimalaya -p ${dockerhubpwd}'
                        sh 'docker push ${DOCKER_IMAGE}'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Deploy using Docker Compose
                    sh '''
                    docker-compose down
                    docker-compose up -d
                    '''
                }
            }
        }
    }
    post {
        always {
            // Cleanup
            sh 'docker system prune -f'
        }
    }
}

pipeline {
    agent any

    environment {
        APP_NAME     = 'taskapp'
        DOCKER_IMAGE = "sumitpaltech/taskapp"
        K8S_CREDS    = credentials('kubeconfig-credentials')
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        timestamps()
        disableConcurrentBuilds()
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                script {
                    env.IMAGE_TAG = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    if [ ! -f .env ]; then cp .env.example .env; fi
                    composer install --no-interaction || true
                    php artisan key:generate || true
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'php artisan test || true'
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                    docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} .
                    docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${DOCKER_IMAGE}:latest
                """
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh """
                        echo $PASS | docker login -u $USER --password-stdin
                        docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
                        docker push ${DOCKER_IMAGE}:latest
                        docker logout
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-credentials', variable: 'KUBECONFIG')]) {
                    sh """
                        kubectl set image deployment/taskapp-deployment \
                        taskapp=${DOCKER_IMAGE}:${IMAGE_TAG} \
                        -n staging

                        kubectl rollout status deployment/taskapp-deployment \
                        -n staging --timeout=300s
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ CI/CD SUCCESS"
        }

        failure {
            echo "❌ CI/CD FAILED"
        }

        always {
            cleanWs()
        }
    }
}
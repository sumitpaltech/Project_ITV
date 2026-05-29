pipeline {

    agent {
        docker {
            image 'php:8.2-cli'
            args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        APP_NAME        = 'taskapp'
        DOCKER_IMAGE    = "sumitpaltech/taskapp"
        DOCKER_CREDS    = credentials('dockerhub-credentials')
        K8S_NAMESPACE   = 'staging'
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        ansiColor('xterm')
    }

    stages {

        stage('Install System Dependencies') {
            steps {
                echo "⚙️ Installing system packages + PHP extensions"
                sh '''
                    apt-get update && apt-get install -y \
                        git unzip curl libzip-dev libpng-dev libjpeg-dev libfreetype6-dev

                    docker-php-ext-install gd zip
                '''
            }
        }

        stage('Checkout') {
            steps {
                echo "🔄 Checking out code..."
                checkout scm

                script {
                    env.IMAGE_TAG = sh(
                        script: "git rev-parse --short HEAD",
                        returnStdout: true
                    ).trim() + "-${env.BUILD_NUMBER}"
                }

                sh 'git log --oneline -5'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "📦 Composer install..."
                sh '''
                    if [ ! -f .env ]; then cp .env.example .env; fi

                    curl -sS https://getcomposer.org/installer | php
                    php composer.phar install --no-interaction --prefer-dist --optimize-autoloader
                '''
            }
        }

        stage('Lint') {
            steps {
                echo "🔍 Lint check..."
                sh '''
                    ./vendor/bin/pint --test || true
                    find app config routes database -name "*.php" -print0 | xargs -0 -n1 php -l || true
                '''
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Running tests..."
                sh '''
                    php artisan test --parallel --log-junit reports.xml || true
                '''
            }
        }

        stage('Security Scan') {
            steps {
                echo "🛡️ Security scan..."
                sh 'composer audit || true'
            }
        }

        stage('Docker Build') {
            steps {
                echo "🐳 Building Docker image..."
                sh """
                    docker build \
                        -t ${DOCKER_IMAGE}:${IMAGE_TAG} \
                        -t ${DOCKER_IMAGE}:latest \
                        .
                """
            }
        }

        stage('Image Scan') {
            steps {
                echo "🔐 Trivy scan..."
                sh """
                    docker run --rm \
                    -v /var/run/docker.sock:/var/run/docker.sock \
                    aquasec/trivy:latest image \
                    --severity HIGH,CRITICAL \
                    ${DOCKER_IMAGE}:${IMAGE_TAG} || true
                """
            }
        }

        stage('Push to DockerHub') {
            steps {
                echo "📤 Pushing image..."
                sh """
                    echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin

                    docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
                    docker push ${DOCKER_IMAGE}:latest

                    docker logout
                """
            }
        }

        stage('Deploy to Staging') {
            steps {
                echo "🚀 Deploy to staging..."
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

        stage('Approval Gate') {
            when { branch 'main' }
            steps {
                input message: "Deploy to PRODUCTION?", ok: "Deploy"
            }
        }

        stage('Deploy to Production') {
            when { branch 'main' }
            steps {
                echo "🚀 Deploy to production..."
                withCredentials([file(credentialsId: 'kubeconfig-credentials', variable: 'KUBECONFIG')]) {
                    sh """
                        kubectl apply -f k8s/ -n production

                        kubectl set image deployment/taskapp-deployment \
                        taskapp=${DOCKER_IMAGE}:${IMAGE_TAG} \
                        -n production

                        kubectl rollout status deployment/taskapp-deployment \
                        -n production --timeout=300s
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline SUCCESS"
        }

        failure {
            echo "❌ Pipeline FAILED"
        }

        always {
            cleanWs()
        }
    }
}
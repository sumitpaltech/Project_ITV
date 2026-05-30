pipeline {
    agent any

    environment {
        APP_NAME     = 'taskapp'
        DOCKER_IMAGE = "sumitpaltech/taskapp"
    }

    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        timestamps()
    }

    stages {

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
            }
        }

        stage('Setup Environment') {
            steps {
                echo "📦 Setting up Laravel environment..."

                sh '''
                    if [ -f .env.example ] && [ ! -f .env ]; then
                        cp .env.example .env
                    fi

                    composer install --no-interaction --prefer-dist || true
                    php artisan key:generate || true
                '''
            }
        }

        stage('Lint') {
            steps {
                echo "🔍 Running lint checks..."

                sh '''
                    if [ -f ./vendor/bin/pint ]; then
                        ./vendor/bin/pint --test || true
                    fi

                    find app config routes database -name "*.php" -print0 | xargs -0 -n1 php -l || true
                '''
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Running tests..."
                sh '''
                    docker run --rm \
                        -v $(pwd):/var/www/html \
                        -w /var/www/html \
                        php:8.2-cli \
                        php artisan test --parallel --log-junit results.xml || true
                '''
            }
        }

        stage('Docker Build') {
            steps {
                echo "🐳 Building Docker image..."

                sh """
                    docker build \
                        --build-arg APP_KEY=\$(openssl rand -base64 32) \
                        -t ${DOCKER_IMAGE}:${IMAGE_TAG} \
                        -t ${DOCKER_IMAGE}:latest \
                        .
                """
            }
        }

        stage('Docker Push') {
            steps {
                echo "📤 Pushing image to DockerHub..."

                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                        docker push ${DOCKER_IMAGE}:${IMAGE_TAG}
                        docker push ${DOCKER_IMAGE}:latest

                        docker logout
                    """
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                echo "🚀 Deploying to Kubernetes (staging)..."

                withCredentials([file(
                    credentialsId: 'kubeconfig',
                    variable: 'KUBECONFIG'
                )]) {

                    sh """
                        kubectl set image deployment/taskapp-deployment \
                            taskapp=${DOCKER_IMAGE}:${IMAGE_TAG} \
                            -n staging \
                            --record

                        kubectl rollout status deployment/taskapp-deployment \
                            -n staging --timeout=300s
                    """
                }
            }
        }

        stage('Approval (Production)') {
            when { branch 'main' }
            steps {
                input message: "Deploy to PRODUCTION?", ok: "Deploy"
            }
        }

        stage('Deploy to Production') {
            when { branch 'main' }
            steps {
                echo "🚀 Deploying to production..."

                withCredentials([file(
                    credentialsId: 'kubeconfig',
                    variable: 'KUBECONFIG'
                )]) {

                    sh """
                        kubectl apply -f k8s/ -n production

                        kubectl set image deployment/taskapp-deployment \
                            taskapp=${DOCKER_IMAGE}:${IMAGE_TAG} \
                            -n production \
                            --record

                        kubectl rollout status deployment/taskapp-deployment \
                            -n production --timeout=300s
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
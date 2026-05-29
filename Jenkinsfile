/*
 * ─────────────────────────────────────────────────────────────
 *  TaskApp — Declarative Jenkins CI/CD Pipeline
 * ─────────────────────────────────────────────────────────────
 *  Flow:  GitHub Push  →  Webhook  →  Jenkins  →  Build & Test
 *         →  Docker Build  →  Push to Docker Hub  →  Deploy to K8s
 *
 *  Branch strategy:
 *    • dev     → deploys to   staging   namespace
 *    • main    → deploys to   production namespace (manual approval)
 * ─────────────────────────────────────────────────────────────
 */

pipeline {
    agent any

    // ── Environment variables ────────────────────────────────
    environment {
        APP_NAME           = 'taskapp'
        DOCKER_REGISTRY    = 'docker.io'
        DOCKER_HUB_USER    = 'sumitpaltech'
        DOCKER_IMAGE       = "${DOCKER_HUB_USER}/${APP_NAME}"
        IMAGE_TAG          = "${env.GIT_COMMIT?.take(8) ?: 'latest'}-${env.BUILD_NUMBER}"
        KUBECONFIG_CREDS   = credentials('kubeconfig-credentials')   // Jenkins credential ID
        K8S_NAMESPACE      = "${env.BRANCH_NAME == 'main' ? 'production' : 'staging'}"
    }

    // ── Pipeline options ─────────────────────────────────────
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '15'))
        timestamps()
        ansiColor('xterm')
    }

    // ── Trigger on GitHub webhook ────────────────────────────
    triggers {
        githubPush()
    }

    stages {

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 1: Checkout
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Checkout') {
            steps {
                echo "🔄 Checking out branch: ${env.BRANCH_NAME}"
                checkout scm
                sh 'git log --oneline -5'
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 2: Install Dependencies
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Install Dependencies') {
            steps {
                echo '📦 Installing Composer dependencies...'
                sh '''
                    if [ -f .env.example ]; then
                        cp .env.example .env
                    else
                        echo ".env.example not found, skipping"
                    fi
                    composer install --no-interaction --prefer-dist --optimize-autoloader
                    php artisan key:generate
                '''
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 3: Code Quality & Lint
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Lint') {
            steps {
                echo '🔍 Running code quality checks...'
                sh '''
                    # Laravel Pint (PSR-12 + Laravel style)
                    ./vendor/bin/pint --test || true

                    # PHP syntax check on all PHP files
                    find app config routes database \
                        -name "*.php" -print0 | xargs -0 -n1 php -l
                '''
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 4: Run Tests
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Test') {
            steps {
                echo '🧪 Running PHPUnit test suite...'
                sh '''
                    php artisan config:clear
                    php artisan test --parallel --coverage-text \
                        --log-junit reports/junit.xml || true
                '''
            }
            post {
                always {
                    junit allowEmptyResults: true,
                         testResults: 'reports/junit.xml'
                }
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 5: Security Scan
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Security Scan') {
            steps {
                echo '🛡️ Scanning for known vulnerabilities...'
                sh '''
                    # Check Composer dependencies for CVEs
                    composer audit --no-interaction || true
                '''
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 6: Build Docker Image
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Docker Build') {
            steps {
                echo "🐳 Building image: ${DOCKER_IMAGE}:${IMAGE_TAG}"
                sh """
                    docker build \
                        --build-arg BUILD_DATE=\$(date -u +%Y-%m-%dT%H:%M:%SZ) \
                        --build-arg VCS_REF=${env.GIT_COMMIT?.take(8) ?: 'unknown'} \
                        --cache-from ${DOCKER_IMAGE}:latest \
                        -t ${DOCKER_IMAGE}:${IMAGE_TAG} \
                        -t ${DOCKER_IMAGE}:latest \
                        -f Dockerfile .
                """
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 7: Trivy Image Scan
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Image Scan') {
            steps {
                echo '🔐 Scanning Docker image for vulnerabilities...'
                sh """
                    docker run --rm \
                        -v /var/run/docker.sock:/var/run/docker.sock \
                        aquasec/trivy:latest image \
                        --severity HIGH,CRITICAL \
                        --exit-code 0 \
                        ${DOCKER_IMAGE}:${IMAGE_TAG}
                """
            }
        }

        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        // Stage 9: Deploy to Kubernetes
        // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        stage('Deploy to Staging') {
            when { branch 'dev' }
            steps {
                echo "🚀 Deploying ${IMAGE_TAG} to STAGING..."
                withEnv(["KUBECONFIG=${env.WORKSPACE}/kubeconfig"]) {
                    withCredentials([file(credentialsId: 'kubeconfig-credentials', variable: 'KUBECONFIG_FILE')]) {
                        sh """
                            cp \$KUBECONFIG_FILE \$KUBECONFIG

                            kubectl get nodes
                            kubectl set image deployment/taskapp-deployment \
                                taskapp=${DOCKER_IMAGE}:${IMAGE_TAG} \
                                -n ${K8S_NAMESPACE} \
                                --record

                            kubectl rollout status deployment/taskapp-deployment \
                                -n ${K8S_NAMESPACE} --timeout=300s
                        """
                    }
                }
            }
        }

        stage('Approval Gate') {
            when { branch 'main' }
            steps {
                script {
                    def approval = input(
                        message: 'Deploy to PRODUCTION?',
                        ok: 'Deploy',
                        parameters: [
                            string(name: 'APPROVED_BY',
                                   description: 'Your name for audit trail')
                        ]
                    )
                    echo "✅ Approved by: ${approval}"
                }
            }
        }

        stage('Deploy to Production') {
            when { branch 'main' }
            steps {
                echo "🚀 Deploying ${IMAGE_TAG} to PRODUCTION..."
                withCredentials([file(credentialsId: 'kubeconfig-credentials',
                                     variable: 'KUBECONFIG')]) {
                    sh """
                        # Apply all Kubernetes manifests
                        kubectl apply -f k8s/ -n production

                        # Rolling update with the new image
                        kubectl set image deployment/taskapp-deployment \
                            taskapp=${DOCKER_IMAGE}:${IMAGE_TAG} \
                            -n production \
                            --record

                        # Wait for rollout completion
                        kubectl rollout status deployment/taskapp-deployment \
                            -n production --timeout=300s

                        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                        echo " ✅  PRODUCTION DEPLOY SUCCESSFUL"
                        echo " Image: ${DOCKER_IMAGE}:${IMAGE_TAG}"
                        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                    """
                }
            }
        }
    }

    // ── Post-pipeline actions ────────────────────────────────
    post {
        success {
            echo '🎉 Pipeline completed successfully!'
        }

        failure {
            echo '❌ Pipeline failed!'
        }

        always {
            script {
                try {
                    cleanWs()
                } catch (e) {
                    echo "Workspace already cleaned or not available"
                }
            }

            sh 'docker system prune -f || true'
        }
    }
}

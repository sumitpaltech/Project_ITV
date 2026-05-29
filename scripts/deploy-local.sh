#!/usr/bin/env bash
###############################################################################
# deploy-local.sh — Full local deployment to Minikube
# Usage: ./scripts/deploy-local.sh
# Builds the image inside Minikube's docker daemon (no registry push needed)
###############################################################################
set -euo pipefail

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
IMAGE="sumitpaltech/taskapp:local"

cd "$APP_DIR"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " TaskApp — Local Minikube Deploy"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── 1. Point docker CLI at Minikube ─────────────────────────
echo ""
echo "Pointing Docker at Minikube daemon..."
eval "$(minikube docker-env)"

# ── 2. Build image ───────────────────────────────────────────
echo ""
echo "Building Docker image: ${IMAGE}"
docker build -t "${IMAGE}" -t "sumitpaltech/taskapp:latest" -f Dockerfile .

# ── 3. Create namespaces ─────────────────────────────────────
echo ""
echo "Creating namespaces..."
kubectl apply -f k8s/00-namespaces.yaml

# ── 4. Apply configs + secrets ───────────────────────────────
echo ""
echo "Applying ConfigMaps and Secrets..."
kubectl apply -f k8s/01-configmap.yaml
kubectl apply -f k8s/02-secrets.yaml

# ── 5. Persistent volumes ────────────────────────────────────
echo ""
echo "Creating PersistentVolumeClaims..."
kubectl apply -f k8s/07-pvc.yaml

# ── 6. MySQL ─────────────────────────────────────────────────
echo ""
echo "Deploying MySQL..."
kubectl apply -f k8s/08-mysql.yaml
echo "Waiting for MySQL to be ready (up to 3 min)..."
kubectl rollout status deployment/mysql-deployment -n production --timeout=180s

# ── 7. Import SQL dump ───────────────────────────────────────
echo ""
echo "Importing schoo7c1_tasks.sql into MySQL pod..."
MYSQL_POD=$(kubectl get pod -n production -l app=mysql -o jsonpath='{.items[0].metadata.name}')
kubectl exec -n production "${MYSQL_POD}" -- bash -c \
    "mysql -u root -p\$MYSQL_ROOT_PASSWORD schoo7c1_tasks < /dev/stdin" \
    < schoo7c1_tasks.sql
echo "Database imported."

# ── 8. App deployment ────────────────────────────────────────
echo ""
echo "Deploying TaskApp (image: ${IMAGE})..."
# Patch deployment to use local image (no pull)
kubectl apply -f k8s/03-deployment.yaml
kubectl patch deployment taskapp-deployment -n production \
    -p '{"spec":{"template":{"spec":{"containers":[{"name":"taskapp","image":"sumitpaltech/taskapp:local","imagePullPolicy":"Never"}],"initContainers":[{"name":"migrate","image":"sumitpaltech/taskapp:local","imagePullPolicy":"Never"}]}}}}'

kubectl apply -f k8s/04-service.yaml
kubectl apply -f k8s/09-rbac.yaml

echo ""
echo "Waiting for TaskApp rollout..."
kubectl rollout status deployment/taskapp-deployment -n production --timeout=300s

# ── 9. Ingress ───────────────────────────────────────────────
echo ""
echo "Applying Ingress..."
kubectl apply -f k8s/05-ingress.yaml

# ── 10. HPA (requires metrics-server) ───────────────────────
kubectl apply -f k8s/06-hpa.yaml || echo "HPA skipped (metrics-server may not be ready)"

# ── 11. Summary ──────────────────────────────────────────────
MINIKUBE_IP=$(minikube ip)
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " DEPLOYMENT COMPLETE"
echo ""
echo " Pods:"
kubectl get pods -n production
echo ""
echo " Access the app:"
echo "   http://${MINIKUBE_IP}  (via NodePort)"
echo ""
echo " Add to /etc/hosts for domain routing:"
echo "   ${MINIKUBE_IP}  tasks.3idea.in"
echo ""
echo " Port-forward (alternative):"
echo "   kubectl port-forward svc/taskapp-service 8080:80 -n production"
echo "   Then visit http://localhost:8080"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

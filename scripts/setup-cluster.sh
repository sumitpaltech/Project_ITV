#!/usr/bin/env bash
###############################################################################
# setup-cluster.sh — Bootstrap Minikube with all required addons
# Usage: ./scripts/setup-cluster.sh
###############################################################################
set -euo pipefail

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " TaskApp — Minikube Cluster Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# ── 1. Start Minikube ────────────────────────────────────────
echo ""
echo "🚀 Starting Minikube cluster..."
minikube start \
    --cpus=4 \
    --memory=8192 \
    --disk-size=40g \
    --driver=docker \
    --kubernetes-version=v1.28.0

# ── 2. Enable addons ────────────────────────────────────────
echo ""
echo "🔌 Enabling required addons..."
minikube addons enable ingress
minikube addons enable ingress-dns
minikube addons enable metrics-server
minikube addons enable storage-provisioner
minikube addons enable dashboard

# ── 3. Create namespaces ────────────────────────────────────
echo ""
echo "📁 Creating namespaces..."
kubectl apply -f k8s/00-namespaces.yaml

# ── 4. Install Prometheus + Grafana (Helm) ──────────────────
echo ""
echo "📊 Installing monitoring stack..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install monitoring prometheus-community/kube-prometheus-stack \
    -n monitoring --create-namespace \
    -f monitoring/monitoring-values.yaml \
    --wait

# ── 5. Deploy application stack ─────────────────────────────
echo ""
echo "📦 Deploying TaskApp to production namespace..."
kubectl apply -f k8s/ -n production

# ── 6. Wait for readiness ───────────────────────────────────
echo ""
echo "⏳ Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod \
    -l app=mysql -n production --timeout=120s
kubectl wait --for=condition=ready pod \
    -l app=taskapp -n production --timeout=120s

# ── 7. Output access info ───────────────────────────────────
MINIKUBE_IP=$(minikube ip)
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " ✅  Cluster ready!"
echo ""
echo " TaskApp:   http://${MINIKUBE_IP}"
echo " Dashboard: minikube dashboard"
echo " Grafana:   http://${MINIKUBE_IP}:31000"
echo "             (admin / CHANGE-ME-IN-PRODUCTION)"
echo ""
echo " Add to /etc/hosts:"
echo "   ${MINIKUBE_IP}  tasks.3idea.in"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

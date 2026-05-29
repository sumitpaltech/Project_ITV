#!/usr/bin/env bash
###############################################################################
# rollback.sh — Quick rollback to previous deployment revision
# Usage: ./scripts/rollback.sh [namespace] [revision]
###############################################################################
set -euo pipefail

NAMESPACE="${1:-production}"
REVISION="${2:-}"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " TaskApp Rollback Tool"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Show rollout history
echo ""
echo "📋 Deployment history (${NAMESPACE}):"
kubectl rollout history deployment/taskapp-deployment -n "${NAMESPACE}"

if [ -n "${REVISION}" ]; then
    echo ""
    echo "⏪ Rolling back to revision ${REVISION}..."
    kubectl rollout undo deployment/taskapp-deployment \
        -n "${NAMESPACE}" --to-revision="${REVISION}"
else
    echo ""
    echo "⏪ Rolling back to previous revision..."
    kubectl rollout undo deployment/taskapp-deployment -n "${NAMESPACE}"
fi

echo ""
echo "⏳ Waiting for rollback to complete..."
kubectl rollout status deployment/taskapp-deployment \
    -n "${NAMESPACE}" --timeout=300s

echo ""
echo "✅ Rollback complete. Current pods:"
kubectl get pods -n "${NAMESPACE}" -l app=taskapp -o wide

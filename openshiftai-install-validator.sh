#!/bin/bash

# Get the operator name from user input
OPERATOR_NAME=rhods-operator.2.5.0
NAMESPACE="redhat-ods-operator"
SUBSCRIPTION="rhods-operator"

if [ -z "$OPERATOR_NAME" ]; then
    echo "Usage: $0 <operator-name>"
    exit 1
fi

# Retrieve and display operator status
echo "Fetching status for operator: $OPERATOR_NAME"
OPERATOR_STATUS=$(oc get ClusterServiceVersion "$OPERATOR_NAME" -o jsonpath='{.status.phase}' 2>/dev/null)
if [ -z "$OPERATOR_STATUS" ]; then
    echo "Operator not found or insufficient permissions to view status"
    exit 1
fi
#echo "Operator Status: $OPERATOR_STATUS"

# Fetch and display subscription details
echo "Fetching subscription channel for the operator:"
SUBSCRIPTION_STATUS=$(oc get subscription "$SUBSCRIPTION" -n "$NAMESPACE" -o jsonpath='{.spec.channel}' 2>/dev/null)
if [ -z "$SUBSCRIPTION_STATUS" ]; then
    echo "Subscription not found or insufficient permissions to view status"
    exit 1
fi
#echo "Subscription Channel: $SUBSCRIPTION_STATUS"

# Fetch and display install plan details
echo "Fetching install plan approval for the operator:"
INSTALL_PLAN_NAME=$(oc get subscription "$SUBSCRIPTION" -n "$NAMESPACE" -o jsonpath='{.spec.installPlanApproval}' 2>/dev/null)
if [ -z "$INSTALL_PLAN_NAME" ]; then
    echo "Install plan not found or insufficient permissions to view status"
    exit 1
fi
#echo "Install Plan Approval: $INSTALL_PLAN_NAME"

# Fetch last update time for the operator
echo "Fetching last update time for the operator:"
LAST_UPDATE_TIME=$(oc get ClusterServiceVersion "$OPERATOR_NAME" -o jsonpath='{.metadata.creationTimestamp}' 2>/dev/null)
if [ -z "$LAST_UPDATE_TIME" ]; then
    echo "Operator not found or insufficient permissions to view status"
    exit 1
fi

echo "Operator '$OPERATOR_NAME' is installed."
echo "Subscription details: $SUBSCRIPTION_STATUS"
echo "Install plan details: $INSTALL_PLAN_NAME"
echo "Last modified: $LAST_UPDATE_TIME"

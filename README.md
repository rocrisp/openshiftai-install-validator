# openshiftai-install-validator
A simple script used to validate the OpenShift AI installation.

This script will pull the operator status, subscription channel, install plan, and last update time for the operator. 

## Assumptions
1. You already have an existing OpenShift cluster.
2. Your OpenShift cluster already has the OpenShift AI operator installed.
3. You are logged into the OpenShift cluster with an account that has cluster-level admin privileges.

## Usage
1. To use this script, clone the repository locally.
2. Change directory into the cloned repo: `cd openshift-install-validator`.
3. Make the file executable: `chmod +x openshiftai-install-validator.sh`
4. Execute the file: `./openshiftai-install-validator.sh`

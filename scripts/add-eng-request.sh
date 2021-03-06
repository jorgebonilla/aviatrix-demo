#!/bin/bash
#-----------------------------------------------------------------------------
# Adds the "engineering request"
#-----------------------------------------------------------------------------
TOP="$( cd "$(dirname "$0")/.." ; pwd -P )"

export TF_LOG= #TRACE
STEP=step-6-engineering
LOG=${TOP}/logs/${STEP}.apply.output.log
VARS=${TOP}/shared/aviatrix-admin-password.tfvars
cd ${TOP}/steps/${STEP}
terraform apply -auto-approve -no-color -parallelism=1 -var-file=${VARS} . 2>&1 | tee ${LOG}
grep "Apply complete" ${LOG} > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Failed to add engineering VPCs"
    exit 1
fi

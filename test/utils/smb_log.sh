# Copyright 2020 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

set -e

NS=kube-system
CONTAINER=smb

echo "print out all $NS namespace pods status ..."
kubectl get pods -n${NS} -o wide
echo "======================================================================================"

echo "print out csi-smb-controller pods ..."
echo "======================================================================================"
LABEL='app=csi-smb-controller'
kubectl get pods -n${NS} -l${LABEL} \
    | awk 'NR>1 {print $1}' \
    | xargs -I {} kubectl describe po {} -n${NS}

echo "print out csi-smb-controller logs ..."
echo "======================================================================================"
LABEL='app=csi-smb-controller'
kubectl get pods -n${NS} -l${LABEL} \
    | awk 'NR>1 {print $1}' \
    | xargs -I {} kubectl logs {} --prefix -c${CONTAINER} -n${NS}

echo "print out csi-smb-node logs ..."
echo "======================================================================================"
LABEL='app=csi-smb-node'
kubectl get pods -n${NS} -l${LABEL} \
    | awk 'NR>1 {print $1}' \
    | xargs -I {} kubectl logs {} --prefix -c${CONTAINER} -n${NS}

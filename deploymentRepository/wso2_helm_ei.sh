#!/bin/bash

#-------------------------------------------------------------------------------
# Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------------

set -e

#installation of database differs accoring to the type of database resource found.
#This function is to deploy the database correctly as found in the test plan.

function helm_deploy(){ 

  file=$INPUT_DIR/infrastructure.properties
  dockerAccessUserName=$(cat $file | grep "dockerAccessUserName" | cut -d'=' -f2)
  dockerAccessPassword=$(cat $file | grep "dockerAccessPassword" | cut -c 22- | tr -d '\')
  echo $dockerAccessUserName
  echo $dockerAccessPassword
  echo $namespace

  helmDeployment="wso2product$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)"

  helm install $helmDeployment $deploymentRepositoryLocation/deploymentRepository/helm_ei/product/ -n $namespace

  
}

helm_deploy

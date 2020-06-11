#!/bin/bash
stackname="KubernetesStack"
tempfile="kubernetes.yml"
paramfile="kubernetes-parameters.json"
if [ -z "$(aws cloudformation wait stack-exists --stack-name ${stackname})" ]
then
      echo "\$stack is empty"
      aws cloudformation create-stack --stack-name $stackname --template-body file://$tempfile --parameters file://$paramfile --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
else
      echo "\$stack is NOT empty"
      aws cloudformation update-stack --stack-name $stackname --template-body file://$tempfile --parameters file://$paramfile --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
fi



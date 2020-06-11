pipeline {
  agent any
  stages {
    stage('Deploy') {
      when {
        branch 'dev'
      }
      parallel {
        stage('Deploy Docker') {
          steps {
            sh '''sudo docker push dsalazar10/udagram:reverse-proxy
            sudo docker push dsalazar10/udagram:frontend
            sudo docker push dsalazar10/udagram:feed
            sudo docker push dsalazar10/udagram:user'''
          }
        }

        stage('Deploy IaC') {
          steps {
            sh '''stackname="KubernetesStack"
tempfile="kubernetes.yml"
if ! aws cloudformation describe-stacks --region us-west-2 --stack-name $stackname
then
  echo -e "\\nStack does not exist, creating ..."
  aws cloudformation create-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
  echo "Waiting for stack to be created ..."
  aws cloudformation wait stack-create-complete --stack-name $stackname
else
  echo -e "\\nStack exists, attempting update ..."
  set +e
  update_output=$( \\
    aws cloudformation update-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2 \\
    ${@:3} Â 2>&1)
  status=$?
  set -e
  echo "$update_output"

  if [ $status -ne 0 ]
  then
    # Don\'t fail for no-op update
    if [[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]]
    then
      echo -e "\\nFinished create/update - no updates to be performed"
      exit 0
    else
      exit $status
    fi
  fi
  aws cloudformation wait stack-create-complete --stack-name $stackname
fi'''
          }
        }

        stage('Deploy Charts') {
          steps {
            s3Upload(bucket: 'datastack-kubebucket-1ey43ef6acout', file: 'Kubernetes', sseAlgorithm: 'aws:kms')
          }
        }

      }
    }

  }
}
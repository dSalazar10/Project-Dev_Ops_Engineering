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
# Check if the stack exists
if [[ ! $(aws cloudformation describe-stacks --region us-west-2 --stack-name $stackname) ]]
then
    # No description means stack is empty
  Â  echo "Creating Stack"
  Â  aws cloudformation create-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
  Â  # Wait for stack creation to complete
  Â  aws cloudformation wait stack-create-complete --stack-name $stackname
else
  Â  # Description means stack exists
  Â  echo "Stack exists, attempting to update instead"
  Â  # Update stack
  Â  update_output=$( \\
  Â  Â  Â  aws cloudformation update-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2 \\
  Â  Â  Â  # Parse the StackId
  Â  Â  Â  ${@:3} Â 2>&1)
  Â  status=$?
  Â  trap \'exit\' ERR
  Â  echo "${update_output}"
  Â  # If the status is not empty
  Â  if [[ $status -ne 0 ]]
  Â  then
  Â  Â  Â  # Either the yaml file is invalid or Stack is up to date
  Â  Â  Â  if [[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]]
  Â  Â  Â  then
  Â  Â  Â  Â  Â  echo "Stack is already up to date"
  Â  Â  Â  Â  Â  exit 0
  Â  Â  Â  else
  Â  Â  Â  Â  Â  exit $status
  Â  Â  Â  fi
  Â  fi
  Â  # Wait for stack update to complete
  Â  aws cloudformation wait stack-create-complete --stack-name $stackname
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
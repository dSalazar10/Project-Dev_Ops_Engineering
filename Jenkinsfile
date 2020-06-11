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
paramfile="kubernetes-parameters.json"
if [ -z "$(aws cloudformation wait stack-exists --stack-name ${stackname})" ]
then
      echo "\\$stack is empty"
      aws cloudformation wait stack-create-complete --stack-name $stackname --template-body file://$tempfile --parameters file://$paramfile --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
else
      echo "\\$stack is NOT empty"
      aws cloudformation update-stack --stack-name $stackname --template-body file://$tempfile --parameters file://$paramfile --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
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
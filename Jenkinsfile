pipeline {
  agent any
  stages {
    stage('Deploy') {
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
            sh 'aws cloudformation describe-stacks --stack-name DataStack'
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
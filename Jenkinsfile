pipeline {
  agent any
  stages {
    stage('Lint') {
      parallel {
        stage('Lint Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh '''npm i
npm run app-lint
npm run docker-lint'''
            }

          }
        }

        stage('Lint Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh '''npm i
npm run nginx-lint
npm run docker-lint'''
            }

          }
        }

        stage('Lint RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh '''npm i
npm run app-lint
npm run docker-lint'''
            }

          }
        }

        stage('Lint RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh '''npm i
npm run app-lint
npm run docker-lint'''
            }

          }
        }

      }
    }

    stage('Build') {
      parallel {
        stage('Build Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

        stage('Build Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

        stage('Build RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

        stage('Build RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh 'sudo ./build_docker.sh'
            }

          }
        }

      }
    }

    stage('Launch') {
      steps {
        dir(path: 'src') {
          sh '''sudo docker-compose up -d
sudo docker-compose down'''
        }

      }
    }

    stage('Test') {
      parallel {
        stage('Test Front End') {
          steps {
            echo 'Test User'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test Reverse Proxy') {
          steps {
            echo 'Test Front End'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test RestAPI Feed') {
          steps {
            echo 'Test Reverse Proxy'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test RestAPI User') {
          steps {
            echo 'Test Docker'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

      }
    }

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
            dir(path: 'CloudFormation') {
              sh '''stackname="KubernetesStack"
tempfile="kubernetes.yml"
# Check if the stack exists
if [[ ! $(aws cloudformation describe-stacks --region us-west-2 --stack-name $stackname) ]]
then
    # No description means stack is empty
    echo "Creating Stack"
    aws cloudformation create-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2
    # Wait for stack creation to complete
    aws cloudformation wait stack-create-complete --stack-name $stackname
else
    # Description means stack exists
    echo "Stack exists, attempting to update instead"
    # Update stack
    update_output=$( \\
        aws cloudformation update-stack --stack-name $stackname --template-body file://$tempfile --parameters ParameterKey=EnvironmentName,ParameterValue=UdagramDEV --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --region us-west-2 \\
        # Parse the StackId
        ${@:3} �2>&1)
    status=$?
    trap \'exit\' ERR
    echo "${update_output}"
    # If the status is not empty
    if [[ $status -ne 0 ]]
    then
        # Either the yaml file is invalid or Stack is up to date
        if [[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]]
        then
            echo "Stack is already up to date"
            exit 0
        else
            exit $status
        fi
    fi
    # Wait for stack update to complete
    aws cloudformation wait stack-create-complete --stack-name $stackname
fi'''
            }

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
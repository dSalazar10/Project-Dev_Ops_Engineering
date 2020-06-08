pipeline {
  // specifies where the entire Pipeline, or a specific stage, will execute
  // in the Jenkins environment depending on where the agent section is placed
  // [any, none, label, node, docker, dockerfile, kubernetes]
  agent any
  stages {
    // Stage 1: Building Docker images
    stage('Build/Launch') {
      stage('Build Frontend') {
        steps {
          dir(path: 'src/front-end') {
            sh 'docker build -t dsalazar10/udagram:frontend .'
          }
        }
        stage('Build Feed') {
          steps {
            dir(path: 'src/restapi-feed/') {
              sh 'docker build -t dsalazar10/udagram:feed .'
            }
          }
        }
        stage('Build User') {
          steps {
            dir(path: 'src/restapi-user/') {
              sh 'docker build -t dsalazar10/udagram:user .'
            }
          }
        }
        stage('Build Reverse-proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'docker build -t dsalazar10/udagram:reverse-proxy .'
            }
          }
        }
      }
    }

    stage('Test') {
      parallel {
        stage('Test Feed') {
          agent { docker 'node:12' }
          steps {
            dir(path: 'src/restapi-feed/') {
              sh 'npm run test'
            }
          }
        }

        stage('Test User') {
          agent { docker 'node:12' }
          steps {
            dir(path: 'src/restapi-user/') {
              sh 'npm run test'
            }
          }
        }

        stage('Test Frontend') {
          agent { docker 'beevelop/ionic' }
          steps {
            dir(path: 'src/front-end/') {
              sh 'npm run test'
            }
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        // Push Docker Images
        sh 'docker login'
        sh 'docker push dsalazar10/udagram:frontend'
        sh 'docker push dsalazar10/udagram:feed'
        sh 'docker push dsalazar10/udagram:user'
        sh 'docker push dsalazar10/udagram:reverse-proxy'
        // Push Helm Charts to S3 Bucket
        withAWS(region:'us-west-2',credentials:'aws-static') {
          s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, bucket: 'datastack-jenkinsbucket-1auzhe5nk834v', file: 'Jenkinsfile.groovy')
        } 
      }
    }
  }
}

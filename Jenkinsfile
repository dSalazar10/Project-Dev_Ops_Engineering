pipeline {
  // specifies where the entire Pipeline, or a specific stage, will execute
  // in the Jenkins environment depending on where the agent section is placed
  // [any, none, label, node, docker, dockerfile, kubernetes]
  agent none
  stages {
    // Stage 1: Building Docker images
    stage('Build/Launch') {
      parallel {
        stage('Build Feed') {
          steps {
            dir(path: '${env.WORKSPACE}/src/restapi-feed/') {
              sh './build_docker.sh'
            }
          }
        }

        stage('Build User') {
          steps {
            dir(path: '${env.WORKSPACE}/src/restapi-user/') {
              sh './build_docker.sh'
            }
          }
        }

        stage('Build Frontend') {
          steps {
            dir(path: '${env.WORKSPACE}/src/front-end') {
              sh './build_docker.sh'
            }
          }
        }

        stage('Build Reverse-proxy') {
          steps {
            dir(path: '${env.WORKSPACE}/src/reverse-proxy') {
              sh './build_docker.sh'
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
            dir(path: '${env.WORKSPACE}/src/restapi-feed/') {
              sh 'npm run test'
            }
          }
        }

        stage('Test User') {
          agent { docker 'node:12' }
          steps {
            dir(path: '${env.WORKSPACE}/src/restapi-user/') {
              sh 'npm run test'
            }
          }
        }

        stage('Test Frontend') {
          agent { docker 'beevelop/ionic' }
          steps {
            dir(path: '${env.WORKSPACE}/src/front-end/') {
              sh 'npm run test'
            }
          }
        }
      }
    }

    stage('Deploy') {
      steps {
        echo 'Software is verified and ready for integration!'
        s3Upload(bucket: 'jenkinsbucket', file: 'test.txt')
      }
    }
  }
}

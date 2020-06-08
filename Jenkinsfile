pipeline {
  // specifies where the entire Pipeline, or a specific stage, will execute
  // in the Jenkins environment depending on where the agent section is placed
  // [any, none, label, node, docker, dockerfile, kubernetes]
  agent none
  stages {
    // Stage 1: Build/Launch (Docker)
    stage('Build/Launch') {
      parallel {
        stage('Build Feed') {
          agent { docker 'node:12' }
          steps {
            dir(path: '${env.WORKSPACE}/src/restapi-feed/') {
              sh 'npm run build'
            }

          }
        }

        stage('Build User') {
          agent { docker 'node:12' }
          steps {
            dir(path: '${env.WORKSPACE}/src/restapi-user/') {
              sh 'npm run build'
            }

          }
        }

        stage('Build Frontend') {
          agent { docker 'beevelop/ionic' }
          steps {
            dir(path: '${env.WORKSPACE}/src/front-end') {
              sh 'npm run build'
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

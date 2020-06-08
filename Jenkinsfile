pipeline {
  agent { docker 'node:12' }
  stages {
    stage('Build/Launch') {
      parallel {
        stage('Build Feed') {
          steps {
            dir(path: '/src/restapi-feed/') {
              sh 'npm run build'
            }

          }
        }

        stage('Build User') {
          steps {
            dir(path: '/src/restapi-user/') {
              sh 'npm run build'
            }

          }
        }

        stage('Build Frontend') {
          steps {
            dir(path: '/src/front-end') {
              sh 'npm run build'
            }

          }
        }

      }
    }

    stage('Test') {
      parallel {
        stage('Test Feed') {
          steps {
            dir(path: '/src/restapi-feed/') {
              sh 'npm run test'
            }

          }
        }

        stage('Test User') {
          steps {
            dir(path: '/src/restapi-user/') {
              sh 'npm run test'
            }

          }
        }

        stage('Test Frontend') {
          steps {
            dir(path: '/src/front-end/') {
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

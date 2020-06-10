pipeline {
  agent any
  stages {
    stage('Lint') {
      parallel {
        stage('Lint Front End') {
          steps {
            dir(path: 'src/front-end') {
              sh '''pwd
npm run app-lint'''
              sh 'run docker-lint'
            }

          }
        }

        stage('Lint Reverse Proxy') {
          steps {
            dir(path: 'src/reverse-proxy') {
              sh 'npm run nginx-lint'
            }

          }
        }

        stage('Lint RestAPI Feed') {
          steps {
            dir(path: 'src/restapi-feed') {
              sh 'npm run app-lint'
            }

          }
        }

        stage('Lint RestAPI User') {
          steps {
            dir(path: 'src/restapi-user') {
              sh 'npm run app-lint'
            }

          }
        }

      }
    }

    stage('Build') {
      parallel {
        stage('Build 1') {
          steps {
            echo 'Build User'
          }
        }

        stage('Build 2') {
          steps {
            echo 'Build Font End'
          }
        }

        stage('Build 3') {
          steps {
            echo 'Build Reverse Proxy'
          }
        }

        stage('Build 4') {
          steps {
            echo 'Build Docker'
          }
        }

        stage('Build 5') {
          steps {
            echo 'Build Feed'
          }
        }

      }
    }

    stage('Launch') {
      parallel {
        stage('Launch 1') {
          steps {
            echo 'Launch User'
          }
        }

        stage('Launch 2') {
          steps {
            echo 'Launch Front End'
          }
        }

        stage('Launch 3') {
          steps {
            echo 'Launch Reverse Proxy'
          }
        }

        stage('Launch 4') {
          steps {
            echo 'Launch Docker'
          }
        }

        stage('Launch 5') {
          steps {
            echo 'Launch Feed'
          }
        }

      }
    }

    stage('Test 1') {
      parallel {
        stage('Test 1') {
          steps {
            echo 'Test User'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test 2') {
          steps {
            echo 'Test Front End'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test 3') {
          steps {
            echo 'Test Reverse Proxy'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test 4') {
          steps {
            echo 'Test Docker'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

        stage('Test 5') {
          steps {
            echo 'Test Feed'
            echo 'Integration Test'
            echo 'Smoke Test'
            echo 'End-To-End Test'
            echo 'Test Results'
          }
        }

      }
    }

    stage('Deploy') {
      parallel {
        stage('Deploy 1') {
          steps {
            echo 'Deploy User'
          }
        }

        stage('Deploy 2') {
          steps {
            echo 'Deploy Front End'
          }
        }

        stage('Deploy 3') {
          steps {
            echo 'Deploy Reverse Proxy'
          }
        }

        stage('Deploy 4') {
          steps {
            echo 'Deploy Docker'
          }
        }

        stage('Deploy 5') {
          steps {
            echo 'Deploy '
          }
        }

      }
    }

    stage('error') {
      steps {
        timestamps() {
          sh 'date'
        }

      }
    }

  }
}
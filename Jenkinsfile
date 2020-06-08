pipeline {
  agent any
  stages {
    stage('Pre-Build') {
      steps {
        echo 'Starting Build Stage!'
      }
    }

    stage('Build Stage') {
      steps {
        dir(path: 'src/front-end') {
          sh 'docker build -t dsalazar10/udagram:frontend .'
        }

      }
    }

    stage('Pre-Test') {
      steps {
        echo 'Build completed! Next is Testing!'
      }
    }

    stage('Test Stage') {
      steps {
        dir(path: 'src/front-end/') {
          sh 'docker exec -it dsalazar10/udagram:frontend -c "npm run test"'
        }

      }
    }

    stage('Pre-Deployment') {
      steps {
        echo 'Test completed! Finally Deployment:'
      }
    }

    stage('Deploy') {
      steps {
        sh '''// Push Docker Images
sh \'docker login\'
sh \'docker push dsalazar10/udagram:frontend\'
'''
      }
    }

    stage('Post-Deploy') {
      steps {
        echo 'That\'s it!'
      }
    }

  }
}
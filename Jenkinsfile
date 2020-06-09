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
        dir(path: 'src') {
          sh 'docker-compose build'
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
        dir(path: 'src/restapi-feed/') {
          sh 'docker exec -it dsalazar10/udagram:feed -c "npm run test"'
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
        sh 'docker login'
        sh 'docker push dsalazar10/udagram:feed'
      }
    }

    stage('Post-Deploy') {
      steps {
        echo 'That\'s it!'
      }
    }

  }
}
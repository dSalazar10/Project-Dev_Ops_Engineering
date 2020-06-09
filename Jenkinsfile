pipeline {
  agent any
  stages {

    stage('Build Stage') {
      // when { 
      //   branch 'dev' 
      // }
      steps {
        dir(path: 'src') {
          sh 'docker-compose build'
        }
      }
    }

    stage('Test Stage') {
      // when { 
      //   branch 'stage' 
      // }
      steps {
        dir(path: 'src') {
          sh 'docker-compose up'
        }

      }
    }

    stage('Deploy Stage') {
      // when { 
      //   branch 'master'
      // }
      steps {
        sh 'docker login'
        sh 'docker-compose push'
      }
    }
  }
}
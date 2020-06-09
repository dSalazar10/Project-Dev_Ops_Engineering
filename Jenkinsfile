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
          sh 'echo "docker-compose up"'
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
        // Push Helm Charts to S3 Bucket
        withAWS(region:'us-west-2',credentials:'aws-static') {
          s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, bucket: 'datastack-jenkinsbucket-1auzhe5nk834v', file: 'Jenkinsfile.groovy')
        }
      }
    }
  }
}
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'pwd && ls'
                sh 'cd src'
                sh 'pwd && ls'
                sh 'echo "building packages"'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "testing packages"'
            }
        }
    }
}
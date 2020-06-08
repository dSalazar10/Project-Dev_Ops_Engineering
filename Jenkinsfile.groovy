pipeline {
    // specifies where the entire Pipeline, or a specific stage, will execute
    // in the Jenkins environment depending on where the agent section is placed
    // [any, none, label, node, docker, dockerfile, kubernetes]
    agent none // Forces each stage to have its own agent
    stages {
        // Stage 1: Build/Launch (Docker)
        stage('Build') {
            agent { docker 'node:12' } // execute using docker "FROM node:12"
            steps {
                cd 'src/restapi-feed/'
                sh 'npm run dev'
            }
        }
        stage('Test') {
            steps {
                sh 'echo "testing packages"'
            }
        }
    }
}
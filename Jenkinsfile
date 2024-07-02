pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Running test...'
                sh script: "robot -d results Tests/jupiterToysTCs.robot", returnStatus: true
            }
        }
    }
}

pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Running test...'
                robot -d results Tests/jupiterToysTCs.robot
            }
        }
    }
}

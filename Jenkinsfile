pipeline {
    agent any

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Setup') {
            steps {
                script {
                    // Check if virtual environment exists, if not, create it
                    if (!fileExists('venv')) {
                        sh 'python3 -m venv venv'
                    }
                    // Activate virtual environment and install flake8
                    sh 'bash -c "source venv/bin/activate && pip install flake8"'
                    echo 'Virtual environment created and activated'
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    // Activate virtual environment and run flake8 for linting
                    sh 'bash -c "source venv/bin/activate && flake8 --max-line-length=120 ."'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Activate virtual environment and run tests
                    sh 'bash -c "source venv/bin/activate && python -m unittest discover -s tests"'
                }
            }
        }

        stage('Coverage') {
            steps {
                script {
                    // Activate virtual environment, run tests with coverage
                    sh 'bash -c "source venv/bin/activate && coverage run -m unittest discover -s tests"'
                    sh 'bash -c "source venv/bin/activate && coverage report -m"'
                    sh 'bash -c "source venv/bin/activate && coverage html"'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deployment steps (this is just an example)
                    echo 'Deployment stage...'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            echo 'Pipeline completed.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
    }
}

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
                    // Check if virtual environment exists; if not, create and activate it
                    sh '''
                    if [ ! -d "venv" ]; then
                        python3 -m venv venv
                    fi
                    bash -c "source venv/bin/activate && echo Virtual environment created and activated"
                    '''
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    // Run linter here (example: flake8 for Python)
                    sh '''
                    bash -c "source venv/bin/activate && flake8 --max-line-length=120 ."
                    '''
                }
            }
        }
        
        stage('Test') {
            steps {
                script {
                    // Run tests here
                    sh '''
                    bash -c "source venv/bin/activate && python -m unittest discover"
                    '''
                }
            }
        }

        stage('Coverage') {
            steps {
                script {
                    // Run test coverage here
                    sh '''
                    bash -c "source venv/bin/activate && coverage run -m unittest discover && coverage report -m"
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy step example (replace with actual deployment command)
                    sh '''
                    bash -c "source venv/bin/activate && echo Deploying application..."
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

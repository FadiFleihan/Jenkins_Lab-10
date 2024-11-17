pipeline {
    agent any
    environment {
        PYTHON_VERSION = 'python3.12' // Specify Python version
        VENV_DIR = 'venv'            // Virtual environment directory
    }
    stages {
        stage('Setup') {
            steps {
                script {
                    if (!fileExists("${WORKSPACE}/${VENV_DIR}")) {
                        sh '''
                        bash -c "
                            ${PYTHON_VERSION} -m venv ${VENV_DIR}
                            "
                        '''
                    }
                    sh '''
                    bash -c "
                        source ${VENV_DIR}/bin/activate
                        pip install --upgrade pip
                        pip install -r requirements.txt
                    "
                    '''
                }
            }
        }
        stage('Lint') {
            steps {
                script {
                    sh '''
                    bash -c "
                        source ${VENV_DIR}/bin/activate
                        flake8 app.py
                    "
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh '''
                    bash -c "
                        source ${VENV_DIR}/bin/activate
                        pytest
                    "
                    '''
                }
            }
        }
        stage('Security Scan') {
            steps {
                script {
                        sh '''
                        bash -c "
                            source ${VENV_DIR}/bin/activate
                            bandit -r .
                            pip-audit
                        "
                        '''
                    }
            }
        }
        stage('Coverage') {
            steps {
                script {
                        sh '''
                        bash -c "
                            source ${VENV_DIR}/bin/activate
                            coverage run -m pytest tests/
                            coverage report 
                        "
                        '''
                    }
            }
            
        } 
    
        stage('Deploy') {
            steps {
                echo "Deploying application..."
                sh './deploy_local.sh'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
def COLOR_MAP = [
    'SUCCESS': 'good',
    'FAILURE': 'danger',
    ]



pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'Cloning the infras code'
                git branch: 'main', url: 'https://github.com/radams1989/airbnb-infrastructure.git'
                sh 'ls'
            }
        }
        stage('Verifying Terraform version') {
            steps {
                echo 'verifying the terraform version'
            }
        }
        
        stage('Terraform init') {
            steps {
                echo 'initializing the backend file'
                sh 'terraform init'
            }
        }
        
         stage('Terraform validate') {
            steps {
                echo 'Code syntax checking'
                sh 'terraform init'
            }
        }
        
         stage('Terraform plan') {
            steps {
                echo 'terraform plan for the dry run'
                sh 'terraform plan'
            }
        }
        
         stage('Checkov Scan') {
            steps {
                sh """
                sudo pip3 install checkov
                checkov -d . --skip-check CKV_AWS*
                """
            }
        }
        
        stage('Manual approver') {
            steps {
                input 'approval required for deployment'
            }
        }
         stage('Terraform apply') {
            steps {
                echo 'Creating the infrastructure'
                sh 'sudo terraform apply --auto-approve'
            }
        }
    }
    
    post { 
        always { 
            echo 'I will always say Hello again!'
            slackSend channel: '#radamstradingplatform', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        } 
    }
}
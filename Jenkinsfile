def COLOR_MAP = [
    'SUCCESS': 'good', 
    'FAILURE': 'danger',
]


pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                echo 'Cloning project codebase'
                git branch: 'main', url: 'https://github.com/radams1989/airbnb-infrastructure.git'
                sh 'ls'
            }
        }
    stage('verify terraform version') {
            steps {
                echo 'verifying the terrform version...'
                sh 'terraform --version'
            }
        }
     stage('Initializing terraform project') {
            steps {
                echo 'Initiatializing terraform project.....'
                sh 'terraform init'
            }
        }
        stage('Terraform Validate project') {
            steps {
                echo 'Validating terraform project.....'
                sh 'terraform validate'
            }
        }
        stage('Terraform plan') {
            steps {
                echo 'Terraform plan for the dry run .....'
                sh 'terraform plan'
            }
        }
        
        stage('checkov scan') {
            steps {
                sh """
                sudo pip3 install checkov
                checkov -d . --skip-check CKV_AWS_20, 79
                """
            }
        }
        stage('Manual approver') {
            steps {
                input 'Approval required for deployment '
            }
        }
        stage('Terraform apply') {
            steps {
                echo 'Terraform apply for the creation of the infras .....'
                sh ' terraform apply --auto-approve'
            }
        }
    }
    
    
    
    
     post { 
        always { 
            echo 'I will always say Hello again!'
            slackSend channel: '#glorious-w-f-devops-alerts', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }
}


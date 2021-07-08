// Requirements for jenkins to automatically build the application requirements
pipeline {

    agent any
    environment {
        DOCKER_USERNAME = credentials('DOCKER_USERNAME')
        DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
        ACCESS_KEY = credentials('ACCESS_KEY')
        SECRET_ACCESS_KEY = credentials('SECRET_ACCESS_KEY')
        created_cluster = 'true'
        // DATABASE_URL = credentials('DATABASE_URL')
        // SECRET_KEY = credentials('SECRET_KEY')
    }
    stages{
        // Do initial setup
        stage('Configuring Environment'){

            steps {
                sh 'chmod +x ./scripts/*'
                sh './scripts/dependencies.sh'
                sh './scripts/docker.sh'
                // sh './scripts/terraform.sh'
                sh 'aws configure set aws_access_key_id $ACCESS_KEY'
                sh 'aws configure set aws_secret_access_key $SECRET_ACCESS_KEY'
                sh 'cd kubernetes'
                script {
                    if (env.created_cluster == 'false') {
                        sh './scripts/clusterconfig.sh'
                    }
                }
                sh 'cd'
            }

        }
        // Deploy backend pods
        stage('Deploy Pods'){

            steps {
                sh 'cd kubernetes'
                sh 'kubectl create -f config-map.yaml -f backend.yaml -f frontend.yaml -f nginx.yaml'
                sh 'kubectl get services'
                sh 'cd ..'
            }

        }
        // Testing
        stage('Run Tests'){

            steps {

                sh './scripts/backtest.sh'
            }

        }
    }

}

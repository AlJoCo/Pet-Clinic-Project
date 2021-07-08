// Requirements for jenkins to automatically build the application requirements
pipeline {

    agent any
    environment {
        DOCKER_USERNAME = credentials('DOCKER_USERNAME')
        DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
        ACCESS_KEY = credentials('ACCESS_KEY')
        SECRET_ACCESS_KEY = credentials('SECRET_ACCESS_KEY')
        created_cluster = 'true'
        created_pods = 'true'
        created_mysql_pods = 'false'
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
                
                script {
                    if (env.created_pods == 'false') {
                        sh 'cd kubernetes'
                        sh 'kubectl create -f ./kubernetes/config-map.yaml -f ./kubernetes/backend.yaml -f ./kubernetes/frontend.yaml -f ./kubernetes/nginx.yaml'
                        sh 'cd ..'
                    }
                }

                script {
                    if (env.created_mysql_pods == 'false') {
                        sh 'cd mysql'
                        sh 'kubectl create -f ./mysql/mysql-configmap.yaml -f ./mysql/mysql-pv.yaml -f ./mysql/mysql-services.yaml -f ./mysql/mysql-statefulset.yaml -f ./mysql/mysql-storageclass.yaml'
                        sh 'cd ..'
                    }
                }
                
            }

        }
        // Testing
        stage('Run Tests'){

            steps {
                sh './scripts/backtest.sh'
            }

        }

        stage('Obtain IP'){

            steps {
                sh 'kubectl get services'
            }

        }
    }

}

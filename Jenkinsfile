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
                sh 'kubectl delete -f ./kubernetes/config-map.yaml -f ./kubernetes/backend.yaml -f ./kubernetes/frontend.yaml -f ./kubernetes/nginx.yaml'
                sh 'kubectl create -f ./kubernetes/config-map.yaml -f ./kubernetes/backend.yaml -f ./kubernetes/frontend.yaml -f ./kubernetes/nginx.yaml'
                sh 'cd ..'

                sh 'cd mysql'
                sh 'kubectl delete -f ./mysql/mysql-configmap.yaml -f ./mysql/mysql-pv.yaml -f ./mysql/mysql-services.yaml -f ./mysql/mysql-statefulset.yaml -f ./mysql/mysql-storageclass.yaml'
                sh 'kubectl create -f ./mysql/mysql-configmap.yaml -f ./mysql/mysql-pv.yaml -f ./mysql/mysql-services.yaml -f ./mysql/mysql-statefulset.yaml -f ./mysql/mysql-storageclass.yaml'
                sh 'cd ..'

                sh 'kubectl autoscale deployment backend --min=2 --max=5 --cpu-percent=80'
                sh 'kubectl autoscale deployment frontend --min=2 --max=5 --cpu-percent=80'
                
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

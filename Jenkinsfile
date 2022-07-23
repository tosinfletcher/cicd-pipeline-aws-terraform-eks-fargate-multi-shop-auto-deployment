pipeline {
  agent any
  environment {
    DOCKER_IMAGE_NAME = "tosinfletcher/multi-shop"
  }
  tools {
    terraform 'terraform'
  }
  options {
    skipDefaultCheckout(true)
  }
  stages{
    stage('git checkout') {
      steps {
        checkout scm
      }
    }  
    stage('Build Docker Image') {
      steps {
        script {
          app = docker.build(DOCKER_IMAGE_NAME)
          app.inside {
            sh 'echo Hello, World!'
          }
        }
      }
    }
    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }    
    stage('initialize terraform') {
      steps {
        withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'terraform init' 
        }
      }
    }
    stage('format terraform files') {
      steps {
        withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'terraform fmt'
        }
      }
    }
    stage('validate terraform files') {
      steps {
        withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'terraform validate'
        }
      }
    }
    stage('deploy terraform') {
      steps {
        withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'terraform apply --auto-approve'
        }
      }
    }
    stage('connect the jenkins worker node to the eks cluster') {
      steps {
        withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'aws eks update-kubeconfig --region us-east-1 --name eks_cluster'
        }
      
      }
    }
    stage('Verify that the jenkins worker node has connected to the eks cluster') {
      steps {
         withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'kubectl get svc'
        }
      }
    }
    stage('provision train- schedule application on the eks cluster') {
      steps {
         withAWS(credentials: 'terraform_user', region: 'us-east-1') {
           sh label: '', script: 'kubectl apply -f ./multi_shop.yaml'
        }
      }
    }
    stage('waiting for 1 minutes') {
      steps {
         withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'sleep 60'
        }
      }
    }
    stage('application lobadbalancer ingress output') {
      steps {
         withAWS(credentials: 'terraform_user', region: 'us-east-1') {
          sh label: '', script: 'kubectl get ingress'
        }
      }
    }  
  }
}

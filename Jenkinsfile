pipeline {
  agent any

  environment {
    AWS_REGION = "us-east-1"
    PATH = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"
  }

  stages {

    stage('Terraform Init/Plan') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {

          sh '''
            echo "AWS_ACCESS_KEY_ID -> $AWS_ACCESS_KEY_ID"

            aws sts get-caller-identity

          '''
          stage('Terraform Init') {
      steps {
        sh """
          terraform init
        """
      }
    }

    stage('Terraform Plan') {
      steps {
        sh """
          terraform plan \
            -var instance_ami=${params.INSTANCE_AMI} \
            -var instance_type=${params.INSTANCE_TYPE} \
            -var instance_name=${params.INSTANCE_NAME}
        """
      }
    }

    stage('Terraform Apply') {
      steps {
        sh """
          terraform apply -auto-approve \
            -var instance_ami=${params.INSTANCE_AMI} \
            -var instance_type=${params.INSTANCE_TYPE} \
            -var instance_name=${params.INSTANCE_NAME}
        """
      }
    }
        }
      }
    }
  }
}

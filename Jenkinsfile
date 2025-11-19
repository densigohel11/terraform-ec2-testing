pipeline {
  agent any

  environment {
    AWS_REGION = "us-east-1"
    PATH = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"
  }

  stages {

    stage('Terraform Init/Plan') {
    withCredentials([usernamePassword(
        credentialsId: 'aws-creds',
        passwordVariable: 'AWS_SECRET_ACCESS_KEY',
        usernameVariable: 'AWS_ACCESS_KEY_ID'
    )]) {

        // DEBUG → verify they load
        sh '''
            echo "AWS_ACCESS_KEY_ID -> $AWS_ACCESS_KEY_ID"
            echo "AWS_SECRET_ACCESS_KEY -> (hidden)"
            aws sts get-caller-identity
        '''

        // 🟢 FIX → run terraform *inside* the same block
        sh '''
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
            export AWS_DEFAULT_REGION=us-east-1

        '''
    }
}
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

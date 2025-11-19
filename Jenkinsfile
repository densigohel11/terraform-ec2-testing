pipeline {
  agent any

  parameters {
    string(name: 'INSTANCE_AMI', defaultValue: 'ami-0c02fb55956c7d316', description: 'Enter AMI ID')
    string(name: 'INSTANCE_TYPE', defaultValue: 't2.micro', description: 'Enter EC2 Instance Type')
    string(name: 'INSTANCE_NAME', defaultValue: 'MyEC2Instance', description: 'Enter instance tag name')
  }

  environment {
 //   AWS_ACCESS_KEY_ID     = credentials('aws-creds').AWS_ACCESS_KEY_ID
  // AWS_SECRET_ACCESS_KEY = credentials('aws-creds').AWS_SECRET_ACCESS_KEY
  //  PATH = "/usr/local/bin/terraform"
    PATH = "/usr/local/bin:/opt/homebrew/bin:${env.PATH}"

    AWS_REGION            = "us-east-1"
  }

  stages {
stage('Debug AWS Creds') {
  steps {
    sh '''
      echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
      aws sts get-caller-identity
    '''
  }
}
    stage('Deploy') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', 
                     credentialsId: 'aws-creds']
                ]) {
                    sh '''
                        echo "AWS Access Key: $AWS_ACCESS_KEY_ID"
                        echo "AWS Secret Key: $AWS_SECRET_ACCESS_KEY"
                    '''
                }
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

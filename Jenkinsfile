pipeline {
    agent any

    parameters {
        string(name: 'INSTANCE_TYPE', defaultValue: 't2.micro')
        string(name: 'AMI_ID', defaultValue: 'ami-0c94855ba95c71c99')
        string(name: 'KEY_NAME', defaultValue: 'my-key')
        string(name: 'INSTANCE_NAME', defaultValue: 'Jenkins-EC2')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init/Plan/Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-creds']
                ]) {

                    sh '''
                        echo ">> AWS Credentials Verified"
                        aws sts get-caller-identity

                        export AWS_DEFAULT_REGION=us-east-1

                        echo ">> Terraform Init"
                        terraform init

                        echo ">> Terraform Plan"
                        terraform plan \
                            -var "instance_type=${INSTANCE_TYPE}" \
                            -var "ami_id=${AMI_ID}" \
                            -var "key_name=${KEY_NAME}" \
                            -var "instance_name=${INSTANCE_NAME}"

                        echo ">> Terraform Apply"
                        terraform apply -auto-approve \
                            -var "instance_type=${INSTANCE_TYPE}" \
                            -var "ami_id=${AMI_ID}" \
                            -var "key_name=${KEY_NAME}" \
                            -var "instance_name=${INSTANCE_NAME}"
                    '''
                }
            }
        }
    }
}

pipeline {
    agent any

    parameters {
        string(name: 'INSTANCE_TYPE', defaultValue: 't2.micro', description: 'EC2 Instance Type')
        string(name: 'AMI_ID', defaultValue: 'ami-0c94855ba95c71c99', description: 'AMI ID')
        string(name: 'KEY_NAME', defaultValue: 'my-key', description: 'Key Pair Name')
        string(name: 'INSTANCE_NAME', defaultValue: 'Jenkins-EC2', description: 'EC2 Instance Name')
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
                    usernamePassword(
                        credentialsId: 'aws-creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )
                ]) {

                    sh '''
                        echo ">> AWS Credentials Verified"
                        aws sts get-caller-identity

                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_DEFAULT_REGION=us-east-1

                        echo ">> Running Terraform Init"
                        terraform init

                        echo ">> Running Terraform Plan"
                        terraform plan \
                            -var "instance_type=${INSTANCE_TYPE}" \
                            -var "ami_id=${AMI_ID}" \
                            -var "key_name=${KEY_NAME}" \
                            -var "instance_name=${INSTANCE_NAME}"

                        echo ">> Applying Terraform"
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

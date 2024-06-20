pipeline {
  agent any

  stages {

    stages {
    stage("Install Terraform") {
      steps {
        sh '''
          #!/bin/bash
          set -e
          # Check if terraform is installed, if not install it
          if ! [ -x "$(command -v terraform)" ]; then
            echo 'Terraform is not installed. Installing...' >&2
            wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
            unzip terraform_1.0.11_linux_amd64.zip
            sudo mv terraform /usr/local/bin/
            rm terraform_1.0.11_linux_amd64.zip
          else
            echo 'Terraform is already installed.'
          fi
        '''
      }
    }


    stage("terraform init") {
          steps {
            sh 'terraform init'
            
          }
      }
     stage("test") {
           steps {
            echo 'testing the appplicatoin...'
          }
      }

      stage("deploy") {
           steps {
            echo 'deploying the application...'
          }
      }
  }
}

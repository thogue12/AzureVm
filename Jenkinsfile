pipeline {
  agent any

  stages {

    stage("Install Terraform") {
      steps {
        sh '''
          #!/bin/bash
          set -e
          # Check if terraform is installed, if not install it
          if ! [ -x "$(command -v terraform)" ]; then
            echo 'Terraform is not installed. Installing...' >&2
            
            # Check if curl is installed, if not install it
            if ! [ -x "$(command -v curl)" ]; then
              echo 'curl is not installed. Installing...' >&2
              if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get update
                sudo apt-get install -y curl
              elif [ -x "$(command -v yum)" ]; then
                sudo yum install -y curl
              else
                echo 'Package manager not supported. Install curl manually.' >&2
                exit 1
              fi
            fi
            
            curl -o terraform.zip https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
            unzip terraform.zip
            sudo mv terraform /usr/local/bin/
            rm terraform.zip
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
        echo 'testing the application...'
      }
    }

    stage("deploy") {
      steps {
        echo 'deploying the application...'
      }
    }
  }
}

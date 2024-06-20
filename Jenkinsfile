pipeline {
  agent any

  stages {

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

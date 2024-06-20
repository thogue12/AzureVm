pipeline {
  agent any

  stages {

    stage("build") {
          steps {
            terraform init
            terraform plan
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

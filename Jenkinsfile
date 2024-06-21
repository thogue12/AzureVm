pipeline {
  agent any

  stages {
      }
    }

    stage("deploy") {
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

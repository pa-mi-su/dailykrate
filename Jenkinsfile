pipeline {
  agent any

  tools {
    jdk 'JDK17'
    maven 'Maven3'
  }

  environment {
    JAVA_HOME = tool 'JDK17'
    PATH = "$JAVA_HOME/bin:$PATH"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Test') {
      steps {
        sh 'mvn test'
      }
    }
  }
}

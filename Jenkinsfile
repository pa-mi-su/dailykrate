pipeline {
  agent any
  tools { maven 'M3' }
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Build & Test') {
      steps { sh 'mvn -B clean verify' }
    }
    stage('Docker Build & Push') {
      steps {
        script {
          docker.withRegistry('https://registry.example.com', 'docker-creds') {
            ['user-service','data-service'].each { svc ->
              def img = "registry.example.com/${svc}:${env.BUILD_NUMBER}"
              dir(svc) {
                sh "docker build -t ${img} ."
                docker.image(img).push()
              }
            }
          }
        }
      }
    }
    stage('Deploy to K8s') {
      steps {
        withKubeConfig([credentialsId: 'kube-config']) {
          sh 'kubectl apply -f user-service/k8s'
          sh 'kubectl apply -f data-service/k8s'
        }
      }
    }
  }
  post { always { junit '**/target/surefire-reports/*.xml' } }
}

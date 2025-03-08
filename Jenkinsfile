pipeline {
    agent {
        node {
            label 'kubeagent' //set your kubernetes node
        }
    }
   environment {
     GITHUB_NAME = "PrzeKem"
     GITHUB_PROJECT = "jenkin_test"
     YOUR_DOCKERHUB_USERNAME = "przekem"
     SERVICE_NAME = "test"
     REPOSITORY_TAG="${YOUR_DOCKERHUB_USERNAME}/${SERVICE_NAME}:${BUILD_ID}"
     NAMESPACE="test_new"
   }

   stages {
    stage('Preparation') {
        steps {
            cleanWs()
            // git url: "https://github.com/${GITHUB_NAME}/${GITHUB_PROJECT}"
        }
    }
  //  stage('Build') {
  //      steps {
  //          sh 'echo No build required for Gateway'
  //      }
  //  }

  //stage('Build and Push Image') {
  //   steps {
  //     sh 'docker image build -t ${REPOSITORY_TAG} .'
  //     sh 'docker tag ${REPOSITORY_TAG} localhost:32000/${REPOSITORY_TAG}'
  //     sh 'docker push localhost:32000/${REPOSITORY_TAG}'
  //   }
  //} 

  stage('Deploy to Cluster') {
    steps {
      //sh './k8s/create.sh'
        sh 'microk8s kubectl create namespace ${NAMESPACE}'
        sh 'microk8s kubectl config set-context --current --namespace=${NAMESPACE}'
        sh 'microk8s kubectl apply -f configmap.yaml'
        sh 'microk8s kubectl apply -f secret.yaml'
        sh 'microk8s kubectl apply -f ingress.yaml'
        sh 'microk8s kubectl apply -f deployment.yaml'
        sh 'microk8s kubectl apply -f service.yaml'
        
        sh 'export NEW_IP="$(microk8s kubectl get services/python-test -o jsonpath=\'{.status.loadBalancer.ingress[0].ip}\')"'
        sh 'echo "IP=$NEW_IP"'
    }
  }
 }
}

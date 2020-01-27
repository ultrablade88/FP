pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }

    stages {
	stage('TF Plan') {
       	   steps {
              container('terraform') {
              sh 'terraform init'
              sh 'terraform plan -out myplan'
         }
       }
     }
   	stage('TF Apply') {
      	  steps {
             container('terraform') {
             sh terraform apply -input=false myplan'
        }
      }
    }
  }
}

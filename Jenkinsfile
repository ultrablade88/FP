
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
              sh 'terraform init'
              sh "terraform plan  -var AWS_KEY_PAIR=${params.AWS_KEY_PAIR}  -out myplan"
       }
     }
   	stage('TF Apply') {
      	  steps {
             sh "terraform apply -input=false  -var AWS_KEY_PAIR=${params.AWS_KEY_PAIR} -auto-approve myplan"
      }
    }
  }
}


pipeline {
    agent any
    parameters {
        string(name: 'Key_Pair', defaultValue: 'KP', description: 'please choose a Key Pair Name')
   }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        TF_IN_AUTOMATION      = '1'
    }
    
    stages {
	stage('TF Plan') {
       	   steps {
              sh 'terraform init'
              sh 'terraform plan -out myplan'
       }
     }
   	stage('TF Apply') {
      	  steps {
             sh 'terraform apply -input=false myplan' -var Key_Pair=${params.Key_Pair}
      }
    }
  }
}

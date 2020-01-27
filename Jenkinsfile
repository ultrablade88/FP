def Key_Pair = input(
id: 'userInput', parameters: [
[$class: 'TextParameterDefinition', defaultValue: 'KP' , description: 'Please choose a Key Pair name', name: 'Key_Pair'])

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
              sh 'terraform plan -out myplan'
       }
     }
   	stage('TF Apply') {
      	  steps {
             sh 'terraform apply -input=false myplan'
	     echo (Key_Pair['Key_Pair'])
      }
    }
  }
}

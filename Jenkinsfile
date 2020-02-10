def AWS_KEY_PAIR
def AWS_SECURITY_GROUP
def AWS_REGION

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
              sh 'terraform init -input=true'
              sh 'terraform plan  -out=myplan -input=true  -var AWS_KEY_PAIR=${params.AWS_KEY_PAIR} -var AWS_SECURITY_GROUP=${params.AWS_SECURITY_GROUP} -var AWS_REGION=${params.AWS_REGION} -auto-approve'
       }
     }
   	stage('TF Apply') {
      	    steps {
               sh 'terraform apply -input=true myplan  -var AWS_KEY_PAIR=${params.AWS_KEY_PAIR} -var AWS_SECURITY_GROUP=${params.AWS_SECURITY_GROUP} -var AWS_REGION=${params.AWS_REGION} -auto-approve'
      }
    }
  }
}

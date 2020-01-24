pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "Terraform 0.12.19"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'FP', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('Terraform 0.12.19')
        TF_IN_AUTOMATION = "true"
        PATH = "$TF_HOME:$PATH"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
 stages {
        stage('Provision infrastructure') {
 
            steps {
            dir('FP/')
            {
            sh 'terraform init'
            sh 'terraform plan -out=plan'
            // sh 'terraform destroy -auto-approve'
            sh 'terraform apply plan'
            }
            
            
            }
            }
        }
 }


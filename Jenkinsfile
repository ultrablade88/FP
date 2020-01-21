pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform-0.12.19"
    }
    parameters {
        string(name: 'WORKSPACE', defaultValue: 'FP', description:'setting up workspace for terraform')
    }
    environment {
        TF_HOME = tool('terraform-0.12.19')
        TF_IN_AUTOMATION = "true"
        PATH = "/home/ubuntu/terraform"
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
     }
    stages {
            stage {
                stage('checkout’) {
                steps {
                git branch: 'master', url: 'https://github.com/ultrablade88/FP.git'
                
                }
            
            stage('TerraformInit'){
                steps {
                    dir('/FP/'){
                        sh "terraform init -input=false"
                        sh "echo \$PWD"
                        sh "whoami"
                    }
                }
        }
        stage('TerraformFormat'){
            steps {
                dir('/FP/'){
                    sh "terraform fmt -list=true -write=false -diff=true -check=true"
                }
            }
        }
        stage('TerraformValidate'){
            steps {
                dir('/FP/'){
                    sh "terraform validate"
                }
            }
        }
              stage('TerraformPlan'){
            steps {
                dir('/FP/'){
                    script {
                        try {
                            sh "terraform workspace new ${params.WORKSPACE}"
                        } catch (err) {
                            sh "terraform workspace select ${params.WORKSPACE}"
                        }
                        sh "terraform plan -var 'access_key=$ACCESS_KEY' -var 'secret_key=$SECRET_KEY' \
                        -out terraform.tfplan;echo \$? > status"
                        stash name: "terraform-plan", includes: "terraform.tfplan"
                    }
                }
            }
        }
        stage('TerraformApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'Can you please confirm the apply', ok: 'Ready to Apply the Config'
                        apply = true
                    } catch (err) {
                        apply = false
                         currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        dir('/FP/'){
                            unstash "terraform-plan"
                            sh 'terraform apply terraform.tfplan'
                        }
                    }
                }
            }
        }
    }
}





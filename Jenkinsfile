pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'machine-id-checker-name'
        DOCKERFILE_PATH = '.' // Adjust the path to your Dockerfile if necessary
        AWS_REGION = 'us-west-2'
        ECR_REPO_NAME = 'machine-id-checker-name'
        dockerTag = 'version'
    }

    stages {
        stage('Git-Clone') {
            steps {
                git branch: 'main', credentialsId: 'b8ac2eb5-066e-4645-a748-561770c36fc7', url: 'https://github.com/subhankar2028/devops-project.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Use Docker Pipeline plugin
                    def dockerImage = docker.build("${env.DOCKER_IMAGE_NAME}:${env.dockerTag}", "-f ${env.DOCKERFILE_PATH}/Dockerfile .")
                    if (dockerImage) {
                        echo "Docker image built successfully: ${env.DOCKER_IMAGE_NAME}"
                    } else {
                        error "Failed to build Docker image: ${env.DOCKER_IMAGE_NAME}"
                    }
                }
            }
        }
        

        stage('Push to ECR') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'ecr:us-west-2:72b70dc7-cce6-4caf-9e14-a88e2e3ada25', url: 'https://975050376304.dkr.ecr.us-west-2.amazonaws.com') {
                        sh "docker push 975050376304.dkr.ecr.us-west-2.amazonaws.com/machine-id-checker-name"
                    }
                }
            }
        }
        
        stage('Get kubeconfig') {
            steps {
                withCredentials([aws(credentialsId: 'subhankar2028getkubeconfig', accessKeyVariable: '***', secretKeyVariable: '***')]) {
                    script {
                        // Configure AWS CLI to use the provided credentials
                        sh "aws configure set aws_access_key_id ***"
                        sh "aws configure set aws_secret_access_key ***"
                        sh "aws configure set region us-west-2"
                        
                        // Update kubeconfig
                        sh "aws eks --region us-west-2 update-kubeconfig --name machine-id-viewer-cluster"
                    }
                }
            }
        }
        
        stage('Kubernetes Deploy') {
            steps {
                // Your Kubernetes deployment steps here
                script {
                    // Apply Kubernetes deployment
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}

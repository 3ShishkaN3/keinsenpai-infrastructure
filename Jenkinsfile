pipeline {
    agent any

    environment {
        PROJECT_NAME = 'keisenpai'
        def SERVICES ='admin-service,user-service,courses-service,lessons-service,tests-service,achievement-service,progress-service,notification-service,analytic-service,search-service,material-service,payment-service,api-gateway,auth-service'

    }

    stages {
        stage('Setup Services') {
            steps {
                script {
                    SERVICES.tokenize(',').each { serviceData ->
                        def service = serviceData
                        echo "Setting up ${service}"
                        dir("services/${service}") {
                            if (isUnix()) {
                                generateServiceUnix(service)
                            } else {
                                generateServiceWindows(service)
                            }
                        }
                    }
                }
            }
        }

        stage('Build Services') {
            steps {
                script {
                    SERVICES.tokenize(',').each { serviceData ->
                        def service = serviceData
                        dir("services/${service}") {
                            dockerBuild(service)
                        }
                    }
                }
            }
        }

        stage('Test Services') {
            steps {
                script {
                    SERVICES.tokenize(',').each { serviceData ->
                        def service = serviceData
                        dir("services/${service}") {
                            dockerTest(service)
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose build'
                    sh 'docker-compose up -d'
                }
            }
        }
    }

    post {
        success {
            echo 'Все сервисы собраны и развернуты успешно!'
        }
        failure {
            echo 'Возникли проблемы при сборке или развертывании'
        }
        always {
            sh 'docker image prune -f'
        }
    }
}

def dockerBuild(serviceName) {
    sh "docker build -t ${PROJECT_NAME}/${serviceName}:latest ."
}

def dockerTest(serviceName) {
    sh "docker run --rm ${PROJECT_NAME}/${serviceName}:latest test || true"
}

def generateServiceWindows(serviceName) {
    def templateDir = determineTemplate(serviceName)
    if (templateDir) {
        bat "xcopy ${templateDir} . /E /I"
    }
}

def generateServiceUnix(serviceName) {
    def templateDir = determineTemplate(serviceName)
    if (templateDir) {
        sh "cp -r ${templateDir}/* ."
    }
}

def determineTemplate(serviceName) {
    if (serviceName.contains('admin') || serviceName.contains('user') || serviceName.contains('auth') || serviceName.contains('api-gateway') || serviceName.contains('payment')) {
        return 'templates/spring-template'
    } else if (serviceName.contains('courses') || serviceName.contains('lessons') || serviceName.contains('tests')  || serviceName.contains('progress')) {
        return 'templates/gin-template'
    } else if (serviceName.contains('achievement') || serviceName.contains('material') || serviceName.contains('analytic')) {
        return 'templates/fastapi-template'
    } else if (serviceName.contains('notification') || serviceName.contains('search')) {
        return 'templates/actix-template'
    }
    return null
}

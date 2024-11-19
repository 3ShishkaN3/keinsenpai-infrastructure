pipeline {
    agent any

    environment {
        PROJECT_NAME = 'keisenpai'
        SERVICES = [
            // Пример заполнения для существующего репозитория:
            // ['service-name', true, 'git-repository-url'],
            ['admin-service', false, ''],
            ['user-service', false, ''],
            ['courses-service', false, ''],
            ['lessons-service', false, ''],
            ['tests-service', false, ''],
            ['achievement-service', false, ''],
            ['progress-service', false, ''],
            ['notification-service', false, ''],
            ['analytic-service', false, ''],
            ['search-service', false, ''],
            ['material-service', false, ''],
            ['payment-service', false, '']
        ]
    }

    stages {
        stage('Setup Services') {
            steps {
                script {
                    def isWindows = isWindowsOS()
                    
                    SERVICES.each { serviceData ->
                        def (service, isRepoExist, repoUrl) = serviceData
                        stage("Setup ${service.capitalize()}") {
                            steps {
                                dir("services/${service}") {
                                    script {
                                        if (isRepoExist) {
                                            sh "git clone ${repoUrl} ."
                                        } else {
                                            if (isWindows) {
                                                generateServiceWindows(service)
                                            } else {
                                                generateServiceUnix(service)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        stage('Build Services') {
            parallel {
                script {
                    SERVICES.each { serviceData ->
                        def (service, _, _) = serviceData
                        stage("Build ${service.capitalize()}") {
                            steps {
                                dir("services/${service}") {
                                    script {
                                        dockerBuild(service)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        stage('Test Services') {
            parallel {
                script {
                    SERVICES.each { serviceData ->
                        def (service, _, _) = serviceData
                        stage("Test ${service.capitalize()}") {
                            steps {
                                dir("services/${service}") {
                                    script {
                                        dockerTest(service)
                                    }
                                }
                            }
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

// Функция для определения ОС
def isWindowsOS() {
    return System.getProperty('os.name').toLowerCase().contains('win')
}

// Функция для создания шаблонов на Windows
def generateServiceWindows(serviceName) {
    def templateDir = determineTemplate(serviceName)
    if (templateDir) {
        bat "xcopy ${templateDir} . /E /I"
    }
}

// Функция для создания шаблонов на Unix
def generateServiceUnix(serviceName) {
    def templateDir = determineTemplate(serviceName)
    if (templateDir) {
        sh "cp -r ${templateDir}/* ."
    }
}

// Функция для определения шаблона сервиса
def determineTemplate(serviceName) {
    if (serviceName.contains('admin') || serviceName.contains('user') || serviceName.contains('progress')) {
        return 'templates/gin-template'
    } else if (serviceName.contains('courses') || serviceName.contains('lessons') || serviceName.contains('tests')) {
        return 'templates/spring-template'
    } else if (serviceName.contains('achievement') || serviceName.contains('material') || serviceName.contains('analytic')) {
        return 'templates/fastapi-template'
    } else if (serviceName.contains('notification') || serviceName.contains('search')) {
        return 'templates/actix-template'
    }
    return null
}

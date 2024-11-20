# Используем официальный образ Jenkins
FROM jenkins/jenkins:lts

# Устанавливаем необходимые плагины для работы с Docker
USER root
RUN jenkins-plugin-cli --plugins "docker-workflow" 

# Устанавливаем Docker в контейнере для запуска Docker-команд
RUN apt-get update && apt-get install -y \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Переключаемся на пользователя Jenkins для безопасности
USER jenkins

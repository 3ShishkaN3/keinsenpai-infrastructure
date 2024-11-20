#!/bin/fish

# Название контейнера Jenkins
set CONTAINER_NAME "jenkins-container"
set JENKINS_IMAGE "jenkins/jenkins:lts"

# Остановка и удаление старого контейнера Jenkins (если он существует)
if test (docker ps -q -f name=$CONTAINER_NAME)
    echo "Останавливаем контейнер Jenkins..."
    docker stop $CONTAINER_NAME
    echo "Удаляем контейнер Jenkins..."
    docker rm $CONTAINER_NAME
end

# Очистка Docker кеша для того, чтобы перезапускать без кеширования
echo "Удаляем старые образы Jenkins из кеша..."
docker rmi -f $JENKINS_IMAGE

# Запуск нового контейнера Jenkins
echo "Запускаем новый контейнер Jenkins..."
docker run -d \
    --name $CONTAINER_NAME \
    -p 8080:8080 \
    -p 50000:50000 \
    -v jenkins_home:/var/jenkins_home \
    --restart always \
    $JENKINS_IMAGE

# Вывод сообщения о статусе
if test (docker ps -q -f name=$CONTAINER_NAME)
    echo "Новый контейнер Jenkins успешно запущен!"
else
    echo "Не удалось запустить новый контейнер Jenkins."
end

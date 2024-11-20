# Название контейнера Jenkins
$CONTAINER_NAME = "jenkins-container"
$JENKINS_IMAGE = "jenkins/jenkins:lts"

# Остановка и удаление старого контейнера Jenkins (если он существует)
if (docker ps -q -f name=$CONTAINER_NAME) {
    Write-Host "Останавливаем контейнер Jenkins..."
    docker stop $CONTAINER_NAME
    Write-Host "Удаляем контейнер Jenkins..."
    docker rm $CONTAINER_NAME
}

# Очистка Docker кеша для того, чтобы перезапускать без кеширования
Write-Host "Удаляем старые образы Jenkins из кеша..."
docker rmi -f $JENKINS_IMAGE

# Запуск нового контейнера Jenkins
Write-Host "Запускаем новый контейнер Jenkins..."
docker run -d `
    --name $CONTAINER_NAME `
    -p 8080:8080 `
    -p 50000:50000 `
    -v jenkins_home:/var/jenkins_home `
    --restart always `
    $JENKINS_IMAGE

# Вывод сообщения о статусе
if (docker ps -q -f name=$CONTAINER_NAME) {
    Write-Host "Новый контейнер Jenkins успешно запущен!"
} else {
    Write-Host "Не удалось запустить новый контейнер Jenkins."
}

#!/bin/bash

SERVICES="admin-service user-service courses-service lessons-service tests-service achievement-service progress-service notification-service analytic-service search-service material-service payment-service api-gateway auth-service"
TEMPLATES_DIR="templates"
SERVICES_DIR="services"
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Функция определения шаблона
determine_template() {
    case "$1" in
        *admin*|*user*|*auth*|*api-gateway*|*payment*) echo "$TEMPLATES_DIR/spring-template";;
        *courses*|*lessons*|*tests*|*progress*) echo "$TEMPLATES_DIR/gin-template";;
        *achievement*|*material*|*analytic*) echo "$TEMPLATES_DIR/fastapi-template";;
        *notification*|*search*) echo "$TEMPLATES_DIR/actix-template";;
        *) echo "";;
    esac
}

# Проверка и создание папки services/
if [ ! -d "$SERVICES_DIR" ]; then
    echo "Папка $SERVICES_DIR не найдена. Создаём структуру сервисов..."
    mkdir -p "$SERVICES_DIR"

    for service in $SERVICES; do
        echo "Создаём структуру для $service..."
        template_dir=$(determine_template "$service")

        if [ -d "$template_dir" ]; then
            mkdir -p "$SERVICES_DIR/$service"
            cp -r "$template_dir/"* "$SERVICES_DIR/$service/"
            echo "Сервис $service создан на основе шаблона $template_dir"
        else
            echo "Шаблон для $service не найден, пропускаем..."
        fi
    done
else
    echo "Папка $SERVICES_DIR уже существует. Пропускаем создание."
fi

echo "Структура сервисов готова"

# Уничтожение старых контейнеров и сетей
echo "Останавливаем и удаляем старые контейнеры и сети с помощью docker-compose..."
docker-compose -f $DOCKER_COMPOSE_FILE down

# Запуск новых контейнеров
echo "Запускаем новые контейнеры с помощью docker-compose..."
docker-compose -f $DOCKER_COMPOSE_FILE up -d

echo "Контейнеры запущены"

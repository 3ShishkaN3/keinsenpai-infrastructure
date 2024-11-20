#!/usr/bin/env fish

set SERVICES admin-service user-service courses-service lessons-service tests-service achievement-service progress-service notification-service analytic-service search-service material-service payment-service api-gateway auth-service
set TEMPLATES_DIR "templates"
set SERVICES_DIR "services"
set DOCKER_COMPOSE_FILE "docker-compose.yml"

# Функция определения шаблона
function determine_template
    switch $argv[1]
        case '*admin*' '*user*' '*auth*' '*api-gateway*' '*payment*'
            echo "$TEMPLATES_DIR/spring-template"
        case '*courses*' '*lessons*' '*tests*' '*progress*'
            echo "$TEMPLATES_DIR/gin-template"
        case '*achievement*' '*material*' '*analytic*'
            echo "$TEMPLATES_DIR/fastapi-template"
        case '*notification*' '*search*'
            echo "$TEMPLATES_DIR/actix-template"
        case '*'
            echo ""
    end
end

# Проверка и создание папки services/
if not test -d $SERVICES_DIR
    echo "Папка $SERVICES_DIR не найдена. Создаём структуру сервисов..."
    mkdir -p $SERVICES_DIR

    for service in $SERVICES
        echo "Создаём структуру для $service..."
        set template_dir (determine_template $service)

        if test -d $template_dir
            mkdir -p "$SERVICES_DIR/$service"
            cp -r "$template_dir/"* "$SERVICES_DIR/$service/"
            echo "Сервис $service создан на основе шаблона $template_dir"
        else
            echo "Шаблон для $service не найден, пропускаем..."
        end
    end
else
    echo "Папка $SERVICES_DIR уже существует. Пропускаем создание."
end

echo "Структура сервисов готова"

# Уничтожение старых контейнеров и сетей
echo "Останавливаем и удаляем старые контейнеры и сети с помощью docker-compose..."
docker-compose -f $DOCKER_COMPOSE_FILE down


# Запуск новых контейнеров
echo "Запускаем новые контейнеры с помощью docker-compose..."
docker-compose -f $DOCKER_COMPOSE_FILE up -d
echo "Контейнеры запущены"
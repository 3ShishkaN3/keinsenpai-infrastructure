# 🚀 Keisenpai - Руководство по установке и настройке инфраструктуры

## 📋 Оглавление
- [Обзор инфраструктуры](#-обзор-инфраструктуры)
- [Компоненты системы](#-компоненты-системы)
- [Предварительные требования](#-предварительные-требования)
- [Установка на различных операционных системах](#-установка-на-различных-операционных-системах)
- [Подробное описание инфраструктурных файлов](#-подробное-описание-инфраструктурных-файлов)
- [Troubleshooting](#-устранение-неполадок)

## 🌐 Обзор инфраструктуры

Инфраструктура проекта включает в себя несколько ключевых компонентов:

### 🏗 Компоненты системы

#### Микросервисы
2. **Java-сервисы (Spring Boot)**:
   - Сервис платежей
   - Административный сервис
   - Сервис пользователей
   - Сервис авторизации
   - API Gateway


1. **Go-сервисы (Gin Framework)**:
   - Сервис курсов
   - Сервис уроков
   - Сервис тестирования
   - Сервис прогресса обучения

3. **Python-сервисы (FastAPI)**:
   - Сервис достижений
   - Сервис материалов
   - Аналитический сервис

4. **Rust-сервисы (Actix Web)**:
   - Сервис уведомлений
   - Сервис поиска

#### Инфраструктурные сервисы
- **Базы данных**: PostgreSQL (по одной для каждого микросервиса)
- **Кэширование**: Redis
- **Очередь сообщений**: RabbitMQ
- **Объектное хранилище**: MinIO
- **Хранилище видео**: Nginx

## 🛠 Предварительные требования

### Необходимое программное обеспечение
- Docker (версия 20.10.0 или выше)
- Docker Compose (версия 1.29.0 или выше)
- Git

## 💻 Установка на различных операционных системах

### Windows 10/11

1. **Подготовка**
   ```powershell
   # Установка Docker Desktop
   winget install Docker.DockerDesktop

   # Включение WSL 2
   wsl --install
   wsl --update
   wsl --set-default-version 2
   ```

2. **Клонирование репозитория**
   ```powershell
   git clone https://gitverse.ru/shish/keisenpai-infrastructure
   cd infrastructure
   ```

3. **Запуск Jenkins контейнера**
   ```powershell
   chmod +x run.sh
   ./run.sh
   ```

### Ubuntu (20.04/22.04)

1. **Установка зависимостей**
   ```bash
   # Обновление системы
   sudo apt update && sudo apt upgrade -y

   # Установка Docker
   sudo apt install apt-transport-https ca-certificates curl software-properties-common
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   
   sudo apt update
   sudo apt install docker-ce docker-compose
   sudo usermod -aG docker $USER
   ```

2. **Клонирование репозитория**
   ```bash
   git clone https://gitverse.ru/shish/keisenpai-infrastructure
   cd infrastructure
   ```

3. **Запуск Jenkins контейнера**
   ```bash
   chmod +x run.sh
   ./run.sh
   ```

### Arch Linux

1. **Установка зависимостей**:
   ```bash
   # Обновление системы
   sudo pacman -Syu

   # Установка Docker
   sudo pacman -S docker

   # Установка Docker Compose
   sudo pacman -S docker-compose

   # Добавление текущего пользователя в группу docker (для использования Docker без sudo)
   sudo usermod -aG docker $USER

   # Перезапуск системы или выполнение следующей команды для применения изменений
   newgrp docker
   ```

2. **Клонирование репозитория**:
   ```bash
   git clone https://gitverse.ru/shish/keisenpai-infrastructure
   cd infrastructure
   ```

3. **Запуск Jenkins контейнера**:
   ```bash
   ./run.sh
   ```

4. **(Опционально) Установка и настройка Jenkins** Для установки Jenkins на Arch Linux можно использовать AUR:
   ```bash
   yay -S jenkins
   ```

После установки Jenkins, запустите сервис:
   ```bash
   sudo systemctl start jenkins
   sudo systemctl enable jenkins
   ```
Вы можете получить доступ к Jenkins по адресу http://localhost:8080.

### macOS

1. **Установка**
   ```bash
   # Установка Homebrew
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

   # Установка Docker Desktop
   brew install --cask docker

   # Установка Git
   brew install git
   ```

2. **Клонирование репозитория**
   ```bash
   git clone https://gitverse.ru/shish/keisenpai-infrastructure
   cd infrastructure
   ```

3. **Запуск Jenkins контейнера**
   ```bash
   chmod +x run.sh
   ./run.sh
   ```

## 🔍 Подробное описание инфраструктурных файлов

### 📄 Jenkinsfile: Автоматизация CI/CD

#### Основные функции
- **Checkout**: Загрузка исходного кода из репозитория, либо создание заглушек
- **Параллельная сборка сервисов**: Построение Docker-образов для всех микросервисов
- **Параллельное тестирование**: Выполнение тестов для каждого сервиса
- **Развертывание**: Сборка и запуск Docker Compose
- **Очистка**: Удаление неиспользуемых Docker-образов

#### Ключевые этапы
1. Загрузка кода
2. Сборка сервисов
3. Тестирование сервисов
4. Развертывание
5. Постобработка

### 📄 docker-compose.yml: Описание инфраструктуры

#### Структура
- Определение всех микросервисов
- Настройка сетевого взаимодействия
- Конфигурация портов
- Управление зависимостями сервисов
- Настройка томов для постоянного хранения данных

#### Ключевые параметры
- Версия Docker Compose: `3.8`
- Общая сеть: `keisenpai-network`
- Volumes для баз данных
- Переменные окружения
- Маппинг портов

## 🚨 Устранение неполадок

### Общие проблемы
- Проверка доступности портов
- Анализ логов Docker
- Проверка версий Docker и Docker Compose

### Команды диагностики
```bash
# Проверка статуса сервисов
docker-compose ps

# Просмотр логов
docker-compose logs [service-name]

# Проверка сети
docker network ls
docker network inspect keisenpai-network
```

## 🔧 Настройка после установки

1. Создание первоначальных миграций БД
2. Настройка переменных окружения
3. Первичная инициализация сервисов


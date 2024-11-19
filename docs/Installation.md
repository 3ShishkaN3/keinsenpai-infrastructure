# 🚀 Развертывание и установка Keisenpai Infrastructure

Этот документ описывает шаги для установки и развертывания проекта **Keisenpai** на различных операционных системах.

## 🖥 Системные требования

- **Docker**: Необходим для контейнеризации микросервисов.
- **Docker Compose**: Утилита для управления многоконтейнерными Docker приложениями.
- **Jenkins** (по желанию): Для автоматизации процессов сборки и развертывания.

## 📦 Установка на различные операционные системы

### 1. Windows 10

1. **Установите Docker Desktop**:
   - Скачайте установщик с [официального сайта Docker](https://www.docker.com/products/docker-desktop).
   - Следуйте инструкциям по установке.

2. **Установите Git**:
   - Скачайте и установите Git с [официального сайта](https://git-scm.com/downloads).

3. **Установите Docker Compose**:
   Docker Compose обычно уже включен в Docker Desktop, но для версий ниже 1.27.0, вам потребуется установить его отдельно:
   - Скачайте [docker-compose](https://docs.docker.com/compose/install/) и следуйте инструкциям.

4. **Запустите проект**:
   - Клонируйте репозиторий:
     ```bash
     git clone https://gitverse.ru/shish/keisenpai-infrastructure
     ```
   - Перейдите в директорию проекта:
     ```bash
     cd keisenpai-infrastructure
     ```
   - Запустите проект с помощью Docker Compose:
     ```bash
     docker-compose up
     ```

### 2. macOS

1. **Установите Docker Desktop**:
   - Скачайте Docker Desktop для macOS с [официального сайта Docker](https://www.docker.com/products/docker-desktop) и следуйте инструкциям.

2. **Установите Git**:
   - Откройте терминал и введите:
     ```bash
     brew install git
     ```

3. **Установите Docker Compose**:
   Docker Compose обычно уже включен в Docker Desktop.

4. **Запустите проект**:
   - Клонируйте репозиторий:
     ```bash
     git clone https://github.com/your-username/keisenpai-infrastructure.git
     ```
   - Перейдите в директорию проекта:
     ```bash
     cd keisenpai-infrastructure
     ```
   - Запустите проект с помощью Docker Compose:
     ```bash
     docker-compose up
     ```

### 3. Ubuntu/Debian

1. **Установите Docker**:
   ```bash
   sudo apt update
   sudo apt install docker.io

2. **Установите Docker Compose**:
    ```bash
    sudo apt install docker-compose
    ```
3. **Установите Git**:
    ```bash
    sudo apt install git
    ```

4. **Запустите проект**:

- Клонируйте репозиторий:
    ```
    bash
    git clone https://gitverse.ru/shish/keisenpai-infrastructure
    ```
- Перейдите в директорию проекта:
    ```bash
    cd keisenpai-infrastructure
    ```

- Запустите проект с помощью Docker Compose:
    ```bash
    docker-compose up
    ```

### 4. Arch Linux

1. Установите Docker:
    ```bash
    sudo pacman -S docker
    ```

2. Установите Docker Compose:
    ```bash
    sudo pacman -S docker-compose
    ```
3. Установите Git:
    ```bash
    sudo pacman -S git
    ```
4. Запустите проект:

- Клонируйте репозиторий:
    ```bash
    git clone https://gitverse.ru/shish/keisenpai-infrastructure
    ```

- Перейдите в директорию проекта:
    ```bash
    cd keisenpai-infrastructure
    ```
- Запустите проект с помощью Docker Compose:
    ```bash
    docker-compose up
    ```

## ⚙️ Развертывание через Jenkins (Надо дописать)
Настройте Jenkins для работы с Docker.
Настройте Jenkins Pipeline с помощью Jenkinsfile, который будет автоматически собирать и запускать сервисы.

## 🌱 Дополнительные шаги (Над дописать)
После того как проект будет развернут, вы сможете взаимодействовать с его компонентами через API Gateway и настраивать конфигурацию с использованием соответствующих инструментов и контейнеров. (в разработке)
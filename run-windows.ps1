$Services = "admin-service", "user-service", "courses-service", "lessons-service", "tests-service", "achievement-service", "progress-service", "notification-service", "analytic-service", "search-service", "material-service", "payment-service", "api-gateway", "auth-service"
$TemplatesDir = "templates"
$ServicesDir = "services"

# Проверка и создание папки services/
if (-Not (Test-Path -Path $ServicesDir)) {
    Write-Output "Папка $ServicesDir не найдена. Создаём структуру сервисов..."
    New-Item -ItemType Directory -Path $ServicesDir | Out-Null

    foreach ($Service in $Services) {
        Write-Output "Создаём структуру для $Service..."
        $TemplateDir = Determine-Template -ServiceName $Service

        if (Test-Path -Path $TemplateDir) {
            $ServicePath = Join-Path -Path $ServicesDir -ChildPath $Service
            New-Item -ItemType Directory -Path $ServicePath | Out-Null
            Copy-Item -Path (Join-Path $TemplateDir '*') -Destination $ServicePath -Recurse
            Write-Output "Сервис $Service создан на основе шаблона $TemplateDir"
        } else {
            Write-Output "Шаблон для $Service не найден, пропускаем..."
        }
    }
} else {
    Write-Output "Папка $ServicesDir уже существует. Пропускаем создание."
}

function Determine-Template {
    param (
        [string]$ServiceName
    )
    if ($ServiceName -match "admin|user|auth|api-gateway|payment") {
        return Join-Path -Path $TemplatesDir -ChildPath "spring-template"
    } elseif ($ServiceName -match "courses|lessons|tests|progress") {
        return Join-Path -Path $TemplatesDir -ChildPath "gin-template"
    } elseif ($ServiceName -match "achievement|material|analytic") {
        return Join-Path -Path $TemplatesDir -ChildPath "fastapi-template"
    } elseif ($ServiceName -match "notification|search") {
        return Join-Path -Path $TemplatesDir -ChildPath "actix-template"
    }
    return $null
}

Write-Output "Структура сервисов готова."

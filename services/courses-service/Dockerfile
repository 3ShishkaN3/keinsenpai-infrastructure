# Dockerfile for Go Gin service
FROM golang:1.20-alpine AS build

WORKDIR /app

# Скопировать go.mod и go.sum
COPY go.mod go.sum ./
RUN go mod download

# Скопировать весь код и собрать бинарник
COPY . .
RUN go build -o main .

# Финальный образ
FROM alpine:latest
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8000

# Запуск сервиса
CMD ["./main"]

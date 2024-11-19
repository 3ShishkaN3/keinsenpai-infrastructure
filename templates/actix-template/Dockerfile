# Dockerfile for Actix Web service
FROM rust:1.70 AS build

WORKDIR /app
COPY Cargo.toml .
RUN cargo fetch

# Скопировать весь код и собрать бинарник
COPY . .
RUN cargo build --release

# Финальный образ
FROM debian:buster-slim
WORKDIR /app
COPY --from=build /app/target/release/notification-service .
EXPOSE 8000

# Запуск сервиса
CMD ["./example-service"]

# Dockerfile for Actix Web service
FROM rust:1.72-bullseye AS build
WORKDIR /app
COPY Cargo.toml .
RUN cargo fetch
# Скопировать весь код и собрать бинарник
COPY . .
RUN cargo build --release

# Финальный образ с более новой версией libc
FROM debian:bullseye-slim
WORKDIR /app
RUN apt-get update && apt-get install -y libssl-dev ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/target/release/example-service .
EXPOSE 8000
# Запуск сервиса
CMD ["./example-service"]
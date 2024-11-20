use actix_web::{web, App, HttpServer};

mod example;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(example::health_check)
    })
    .bind("0.0.0.0:8000")?
    .run()
    .await
}
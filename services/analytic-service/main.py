from fastapi import FastAPI
from app.routers import example

app = FastAPI()

# Регистрация маршрутов
app.include_router(example.router)

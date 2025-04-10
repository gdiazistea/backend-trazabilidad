# app/core/config.py
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DB_NAME: str 
    DB_SCHEMA: str 
    DB_USER: str 
    DB_PASSWORD: str 
    DB_HOST: str 
    DB_PORT: int 

    class Config:
        env_file = ".env"

settings = Settings()

if __name__ == "__main__":
    print(settings.DB_NAME)

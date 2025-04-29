FROM python:3.10-slim

WORKDIR /app

# Copiar el archivo de tu aplicación al contenedor
COPY scraper_service.py .

# Instalar dependencias necesarias
RUN pip install fastapi selenium uvicorn \
    && apt-get update \
    && apt-get install -y firefox-esr wget unzip \
    && wget https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz \
    && tar -xvzf geckodriver-v0.33.0-linux64.tar.gz \
    && mv geckodriver /usr/local/bin/ \
    && rm geckodriver-v0.33.0-linux64.tar.gz

# Exponer el puerto
EXPOSE 8000

# Comando para ejecutar la app
CMD ["uvicorn", "scraper_service:app", "--host", "0.0.0.0", "--port", "8000"]

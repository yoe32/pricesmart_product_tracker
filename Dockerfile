# Usa una imagen de Python ligera
FROM python:3.10-slim

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo de tu aplicación al contenedor
COPY scraper_service.py .

# Instalar dependencias necesarias
RUN pip install fastapi selenium uvicorn
RUN apt-get update && apt-get install -y firefox-esr geckodriver

# Exponer el puerto 8000
EXPOSE 8000

# Comando para arrancar el servidor
CMD ["uvicorn", "scraper_service:app", "--host", "0.0.0.0", "--port", "8000"]

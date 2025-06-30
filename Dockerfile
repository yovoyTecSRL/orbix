FROM python:3.11-slim

# Actualiza los paquetes del sistema para reducir vulnerabilidades
RUN apt-get update && apt-get upgrade -y && apt-get clean

WORKDIR /app

# Copiar requirements y instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar archivos de la aplicación
COPY . .
COPY ./orbix_config.json /app/orbix_config.json

# Exponer puerto
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

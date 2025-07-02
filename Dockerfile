FROM python:3.11-slim

# Actualiza los paquetes del sistema para reducir vulnerabilidades y limpia afterwards
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copiar requirements y instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el resto de la aplicación
COPY . .

# Copiar archivo de configuración si existe
COPY ./orbix_config.json /app/orbix_config.json

# Exponer el puerto de FastAPI/Uvicorn
EXPOSE 8000

# Comando para ejecutar la aplicación (ajusta el import path si tu main está en /app/main.py o en /app/app/main.py)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
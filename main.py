from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import json
from pathlib import Path
import os

app = FastAPI(title="Orbix AI API", version="1.0.0")

@app.get("/")
def read_root():
    return {"message": "¡Orbix AI listo desde Hetzner con Copilot y FastAPI!"}

@app.get("/health")
def health_check():
    """Endpoint para verificar el estado de salud de la aplicación"""
    return {
        "status": "healthy",
        "service": "Orbix AI",
        "version": "1.0.0",
        "config_loaded": bool(config)
    }

# Cargar configuración base
CONFIG_PATH = Path(__file__).parent / "orbix_config.json"
config = {}

try:
    with open(CONFIG_PATH) as f:
        config = json.load(f)
except FileNotFoundError:
    # Configuración por defecto si no existe el archivo
    config = {
        "valor_hora_estrategico": 200,
        "modelo_saas_banco": {
            "setup_fee": 3500,
            "mensualidad": 499
        }
    }

class CotizacionRequest(BaseModel):
    tipo_solucion: str
    horas_estimadas: int
    cliente_es_banco: bool = False

@app.post("/cotizar")
def cotizar(data: CotizacionRequest):
    tarifa = config["valor_hora_estrategico"]
    valor_estimado = tarifa * data.horas_estimadas

    if data.cliente_es_banco:
        modelo = "SaaS mensual sugerido"
        recomendacion = f"USD ${config['modelo_saas_banco']['setup_fee']} inicial + ${config['modelo_saas_banco']['mensualidad']}/mes"
    else:
        modelo = "Precio por proyecto"
        recomendacion = f"USD ${valor_estimado}"

    return {
        "valor_estimado": valor_estimado,
        "modelo": modelo,
        "recomendacion": recomendacion,
        "detalle": {
            "tarifa_usada": tarifa,
            "horas_estimadas": data.horas_estimadas,
            "tipo_solucion": data.tipo_solucion
        }
    }

@app.get("/status")
def get_status():
    """Endpoint para obtener información detallada del estado del servicio"""
    return {
        "status": "running",
        "service": "Orbix AI FastAPI",
        "version": "1.0.0",
        "environment": os.getenv("ENVIRONMENT", "development"),
        "config": {
            "config_file_exists": CONFIG_PATH.exists(),
            "config_keys": list(config.keys()) if config else [],
            "valor_hora_estrategico": config.get("valor_hora_estrategico", "not_set")
        }
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

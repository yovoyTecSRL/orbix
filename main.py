from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import json
from pathlib import Path

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "¡Orbix AI listo desde Hetzner con Copilot y FastAPI!"}

# Cargar configuración base
CONFIG_PATH = Path(__file__).parent / "../orbix_config.json"
with open(CONFIG_PATH) as f:
    config = json.load(f)

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

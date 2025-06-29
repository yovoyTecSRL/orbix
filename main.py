from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "¡Orbix AI listo desde Hetzner con Copilot y FastAPI!"}

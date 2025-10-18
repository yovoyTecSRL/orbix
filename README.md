
# Orbix AI – Calculadora de Valor Inteligente

Esta calculadora está diseñada para ayudarte a estimar el valor real de soluciones empresariales inteligentes desarrolladas con IA, Odoo, y automatización de procesos legales/financieros.

## Instrucciones
1. Lee el prompt `prompt_orbix_ai.txt` e intégralo en tu GPT personalizado.
2. Usa los valores de `orbix_config.json` para crear lógica de cálculo dinámica.
3. Integra esto en tu frontend tipo chatbot o app en FastAPI.

✅ Listo para GitHub Copilot y para lanzar en producción.

---

## Cómo ejecutar localmente:

```bash
uvicorn app.main:app --reload
```

## Cómo construir con Docker:

```bash
docker build -t orbix-calculadora .
docker run -d -p 8000:80 orbix-calculadora
```

Accedé a: http://localhost:8000/docs

🔑 CONFIGURACIÓN DE GITHUB SECRETS - ORBIX AI
=====================================================

📋 INSTRUCCIONES PASO A PASO:

1. 🌐 Ve a tu repositorio en GitHub:
   https://github.com/yovoyTecSRL/orbix

2. 🔧 Navega a Settings → Secrets and variables → Actions

3. 🔑 Crea estos 2 secrets presionando "New repository secret":

   SECRET 1:
   --------
   Name: HETZNER_IP
   Value: 46.62.144.123

   SECRET 2:
   --------
   Name: HETZNER_SSH_KEY
   Value: hUxnpXXEWHknCFa9L4tp

4. ✅ Guarda cada secret presionando "Add secret"

5. 🚀 ACTIVAR EL PRIMER DEPLOY:
   - Haz cualquier cambio pequeño (ej: edita este archivo)
   - Haz commit y push a la rama main
   - ¡El workflow se ejecutará automáticamente!

📊 VERIFICAR EL DEPLOY:
======================
- Ve a la pestaña "Actions" en tu repo de GitHub
- Verás el workflow "🚀 Deploy Orbix AI to Hetzner" ejecutándose
- Una vez completado, tu app estará disponible en: http://46.62.144.123

🔍 ENDPOINTS DISPONIBLES:
========================
- http://46.62.144.123/ (Home)
- http://46.62.144.123/health (Health check)
- http://46.62.144.123/docs (API Documentation)
- http://46.62.144.123/cotizar (POST - Cotizaciones)

🎯 EJEMPLO DE TEST:
==================
curl -X POST http://46.62.144.123/cotizar \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_solucion": "API REST",
    "horas_estimadas": 100,
    "cliente_es_banco": false
  }'

¡LISTO PARA PRODUCCIÓN! 🎉

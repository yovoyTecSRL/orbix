#!/bin/bash

# 🧪 Script de testing automatizado para Orbix AI en Hetzner
# Verifica que todos los endpoints estén funcionando correctamente

IP="${HETZNER_IP:-46.62.144.123}"

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 TESTING ORBIX AI DEPLOYMENT${NC}"
echo -e "${BLUE}================================${NC}"
echo -e "🌐 Testing server: ${YELLOW}$IP${NC}"
echo ""

# Test 1: Health Check
echo -e "🩺 ${BLUE}Test 1: Health Check (/health)${NC}"
HEALTH_RESPONSE=$(curl -s -w "\n%{http_code}" http://$IP/health 2>/dev/null)
HEALTH_CODE=$(echo "$HEALTH_RESPONSE" | tail -n1)
HEALTH_BODY=$(echo "$HEALTH_RESPONSE" | head -n -1)

if [[ "$HEALTH_CODE" == "200" ]] && [[ $HEALTH_BODY == *"healthy"* ]]; then
  echo -e "${GREEN}✅ /health responde correctamente${NC}"
  echo -e "   Response: $HEALTH_BODY"
else
  echo -e "${RED}❌ /health falló - HTTP $HEALTH_CODE${NC}"
  echo -e "   Response: $HEALTH_BODY"
  echo -e "${YELLOW}💡 Posible causa: Servicio no iniciado o puerto cerrado${NC}"
fi
echo ""

# Test 2: API Documentation
echo -e "📚 ${BLUE}Test 2: API Documentation (/docs)${NC}"
DOCS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://$IP/docs 2>/dev/null)

if [[ "$DOCS_CODE" == "200" ]]; then
  echo -e "${GREEN}✅ /docs está funcionando correctamente${NC}"
  echo -e "   📖 Swagger UI disponible en: http://$IP/docs"
else
  echo -e "${RED}❌ /docs falló - HTTP $DOCS_CODE${NC}"
  echo -e "${YELLOW}💡 Posible causa: FastAPI no está sirviendo correctamente${NC}"
fi
echo ""

# Test 3: Root Endpoint
echo -e "🏠 ${BLUE}Test 3: Root Endpoint (/)${NC}"
ROOT_RESPONSE=$(curl -s -w "\n%{http_code}" http://$IP/ 2>/dev/null)
ROOT_CODE=$(echo "$ROOT_RESPONSE" | tail -n1)
ROOT_BODY=$(echo "$ROOT_RESPONSE" | head -n -1)

if [[ "$ROOT_CODE" == "200" ]] && [[ $ROOT_BODY == *"Orbix"* ]]; then
  echo -e "${GREEN}✅ / responde correctamente${NC}"
  echo -e "   Response: $ROOT_BODY"
else
  echo -e "${RED}❌ / falló - HTTP $ROOT_CODE${NC}"
  echo -e "   Response: $ROOT_BODY"
fi
echo ""

# Test 4: Cotizar Endpoint (POST)
echo -e "💰 ${BLUE}Test 4: Cotizar Endpoint (/cotizar)${NC}"
COTIZAR_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST http://$IP/cotizar \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_solucion": "API REST Test",
    "horas_estimadas": 100,
    "cliente_es_banco": false
  }' 2>/dev/null)
COTIZAR_CODE=$(echo "$COTIZAR_RESPONSE" | tail -n1)
COTIZAR_BODY=$(echo "$COTIZAR_RESPONSE" | head -n -1)

if [[ "$COTIZAR_CODE" == "200" ]] && [[ $COTIZAR_BODY == *"valor_estimado"* ]]; then
  echo -e "${GREEN}✅ /cotizar responde correctamente${NC}"
  echo -e "   Response: $COTIZAR_BODY"
else
  echo -e "${RED}❌ /cotizar falló - HTTP $COTIZAR_CODE${NC}"
  echo -e "   Response: $COTIZAR_BODY"
  echo -e "${YELLOW}💡 Posible causa: Configuración JSON incorrecta o modelo no cargado${NC}"
fi
echo ""

# Test 5: Cotizar para banco
echo -e "🏦 ${BLUE}Test 5: Cotizar para Banco${NC}"
BANCO_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST http://$IP/cotizar \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_solucion": "Sistema Bancario",
    "horas_estimadas": 500,
    "cliente_es_banco": true
  }' 2>/dev/null)
BANCO_CODE=$(echo "$BANCO_RESPONSE" | tail -n1)
BANCO_BODY=$(echo "$BANCO_RESPONSE" | head -n -1)

if [[ "$BANCO_CODE" == "200" ]] && [[ $BANCO_BODY == *"SaaS"* ]]; then
  echo -e "${GREEN}✅ Cotización bancaria funciona correctamente${NC}"
  echo -e "   Response: $BANCO_BODY"
else
  echo -e "${RED}❌ Cotización bancaria falló - HTTP $BANCO_CODE${NC}"
  echo -e "   Response: $BANCO_BODY"
fi
echo ""

# Resumen final
echo -e "${BLUE}📊 RESUMEN DE TESTS${NC}"
echo -e "${BLUE}==================${NC}"

ALL_TESTS_PASSED=true

if [[ "$HEALTH_CODE" != "200" ]]; then ALL_TESTS_PASSED=false; fi
if [[ "$DOCS_CODE" != "200" ]]; then ALL_TESTS_PASSED=false; fi
if [[ "$ROOT_CODE" != "200" ]]; then ALL_TESTS_PASSED=false; fi
if [[ "$COTIZAR_CODE" != "200" ]]; then ALL_TESTS_PASSED=false; fi
if [[ "$BANCO_CODE" != "200" ]]; then ALL_TESTS_PASSED=false; fi

if [[ "$ALL_TESTS_PASSED" == "true" ]]; then
  echo -e "${GREEN}🎉 ¡TODOS LOS TESTS PASARON!${NC}"
  echo -e "${GREEN}✅ Orbix AI está desplegado y funcionando correctamente en Hetzner${NC}"
  echo -e ""
  echo -e "${BLUE}🌐 URLs disponibles:${NC}"
  echo -e "   • Home: ${YELLOW}http://$IP/${NC}"
  echo -e "   • Health: ${YELLOW}http://$IP/health${NC}"
  echo -e "   • Docs: ${YELLOW}http://$IP/docs${NC}"
  echo -e "   • API: ${YELLOW}http://$IP/cotizar${NC}"
else
  echo -e "${RED}⚠️  ALGUNOS TESTS FALLARON${NC}"
  echo -e "${YELLOW}💡 Revisa el deployment o la configuración del servidor${NC}"
  echo -e ""
  echo -e "${BLUE}🔧 Troubleshooting:${NC}"
  echo -e "   • Verifica que docker-compose esté ejecutándose"
  echo -e "   • Revisa los logs: ${YELLOW}docker-compose logs${NC}"
  echo -e "   • Verifica el puerto 80: ${YELLOW}netstat -tulpn | grep :80${NC}"
  echo -e "   • Reinicia el servicio: ${YELLOW}docker-compose restart${NC}"
fi

echo ""
echo -e "${BLUE}🔍 Para debugging adicional:${NC}"
echo -e "   • SSH al servidor: ${YELLOW}ssh root@$IP${NC}"
echo -e "   • Ver logs: ${YELLOW}cd /opt/orbix && docker-compose logs -f${NC}"
echo -e "   • Estado contenedores: ${YELLOW}docker-compose ps${NC}"

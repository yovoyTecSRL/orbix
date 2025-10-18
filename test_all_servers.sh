#!/bin/bash

# 🧪 Script completo de testing para todos los servidores Orbix AI
# Prueba Codespaces, Hetzner y reporta estado completo

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 TESTING COMPLETO ORBIX AI${NC}"
echo -e "${BLUE}=============================${NC}"
echo ""

# Test 1: Codespaces - Local
echo -e "${BLUE}💻 CODESPACES (Desarrollo)${NC}"
echo -e "URL: http://localhost/"
echo ""

echo -e "🔍 Test 1: Endpoint principal"
RESPONSE=$(curl -s http://localhost/ 2>/dev/null)
if [[ $RESPONSE == *"Orbix"* ]]; then
  echo -e "${GREEN}✅ / funciona correctamente${NC}"
  echo -e "   Response: $RESPONSE"
else
  echo -e "${RED}❌ / no responde${NC}"
fi
echo ""

echo -e "🩺 Test 2: Health check"
HEALTH=$(curl -s http://localhost/health 2>/dev/null)
if [[ $HEALTH == *"healthy"* ]]; then
  echo -e "${GREEN}✅ /health funciona correctamente${NC}"
  echo -e "   Response: $HEALTH"
else
  echo -e "${RED}❌ /health no responde${NC}"
fi
echo ""

echo -e "💰 Test 3: API Cotización"
COTIZAR=$(curl -s -X POST http://localhost/cotizar \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_solucion": "API Test Consola",
    "horas_estimadas": 50,
    "cliente_es_banco": false
  }' 2>/dev/null)
if [[ $COTIZAR == *"valor_estimado"* ]]; then
  echo -e "${GREEN}✅ /cotizar funciona correctamente${NC}"
  echo -e "   Response: $COTIZAR"
else
  echo -e "${RED}❌ /cotizar falló${NC}"
fi
echo ""

# Test 2: Hetzner
echo -e "${BLUE}🌐 HETZNER (Producción)${NC}"
echo -e "IP: 46.62.144.123"
echo ""

echo -e "🔍 Test 4: Hetzner - Endpoint principal"
HETZNER=$(curl -s --connect-timeout 5 http://46.62.144.123/ 2>/dev/null)
if [[ $HETZNER == *"Orbix"* ]]; then
  echo -e "${GREEN}✅ Hetzner funciona correctamente${NC}"
  echo -e "   Response: $HETZNER"
else
  echo -e "${RED}❌ Hetzner no responde${NC}"
  echo -e "${YELLOW}💡 Necesita deployment automático via GitHub Actions${NC}"
fi
echo ""

# Test 3: URLs públicas de Codespaces
echo -e "${BLUE}🌍 URLs PÚBLICAS${NC}"
echo ""

CODESPACE_URL="https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-80.app.github.dev"
echo -e "🔍 Test 5: URL pública Codespaces"
echo -e "URL: $CODESPACE_URL/"

PUBLIC_RESPONSE=$(curl -s --connect-timeout 10 "$CODESPACE_URL/" 2>/dev/null)
if [[ $PUBLIC_RESPONSE == *"Orbix"* ]]; then
  echo -e "${GREEN}✅ URL pública funciona correctamente${NC}"
else
  echo -e "${YELLOW}⚠️ URL pública no accesible (normal en Codespaces privados)${NC}"
fi
echo ""

# Test 4: Estado de contenedores Docker
echo -e "${BLUE}🐳 ESTADO DOCKER${NC}"
echo ""

echo -e "📊 Contenedores activos:"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(orbix|postgres|odoo)"
echo ""

# Resumen final
echo -e "${BLUE}📋 RESUMEN${NC}"
echo -e "${BLUE}==========${NC}"

LOCAL_OK=false
HETZNER_OK=false

if [[ $RESPONSE == *"Orbix"* ]] && [[ $HEALTH == *"healthy"* ]] && [[ $COTIZAR == *"valor_estimado"* ]]; then
  LOCAL_OK=true
fi

if [[ $HETZNER == *"Orbix"* ]]; then
  HETZNER_OK=true
fi

if [[ "$LOCAL_OK" == "true" ]]; then
  echo -e "${GREEN}✅ CODESPACES: Funcionando perfectamente${NC}"
  echo -e "   🌐 Local: http://localhost/"
  echo -e "   📚 Docs: http://localhost/docs"
  echo -e "   🩺 Health: http://localhost/health"
else
  echo -e "${RED}❌ CODESPACES: Problemas detectados${NC}"
fi

if [[ "$HETZNER_OK" == "true" ]]; then
  echo -e "${GREEN}✅ HETZNER: Funcionando perfectamente${NC}"
  echo -e "   🌐 IP: http://46.62.144.123/"
  echo -e "   🌍 Dominio: sistemasorbix.com (configurar DNS)"
else
  echo -e "${YELLOW}⚠️ HETZNER: Pendiente deployment${NC}"
  echo -e "   💡 Configura secrets en GitHub y haz push"
fi

echo ""
echo -e "${BLUE}🔑 GitHub Secrets necesarios:${NC}"
echo -e "   HETZNER_IP: 46.62.144.123"
echo -e "   HETZNER_SSH_KEY: hUxnpXXEWHknCFa9L4tp"
echo ""
echo -e "${BLUE}🚀 Para activar deployment:${NC}"
echo -e "   1. Configura secrets en GitHub"
echo -e "   2. Haz push a main"
echo -e "   3. Ve a: https://github.com/yovoyTecSRL/orbix/actions"

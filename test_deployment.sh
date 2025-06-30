#!/bin/bash

# 🧪 Script de testing para Orbix AI en Hetzner
# Ejecuta después del primer deploy

echo "🚀 Testing Orbix AI en servidor Hetzner..."
echo "🌐 IP: 46.62.144.123"
echo ""

# Test 1: Endpoint principal
echo "🔍 Test 1: Endpoint principal /"
curl -s http://46.62.144.123/ | jq . || echo "❌ Error en endpoint principal"
echo ""

# Test 2: Health check
echo "🩺 Test 2: Health check /health" 
curl -s http://46.62.144.123/health | jq . || echo "❌ Error en health check"
echo ""

# Test 3: Documentación API
echo "📚 Test 3: Verificando documentación /docs"
curl -s -o /dev/null -w "%{http_code}" http://46.62.144.123/docs
echo " - Código HTTP para /docs"
echo ""

# Test 4: Cotización de prueba
echo "💰 Test 4: Cotización de prueba /cotizar"
curl -s -X POST http://46.62.144.123/cotizar \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_solucion": "API REST",
    "horas_estimadas": 100,
    "cliente_es_banco": false
  }' | jq . || echo "❌ Error en endpoint de cotización"
echo ""

# Test 5: Cotización para banco
echo "🏦 Test 5: Cotización para banco"
curl -s -X POST http://46.62.144.123/cotizar \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_solucion": "Sistema Bancario",
    "horas_estimadas": 500,
    "cliente_es_banco": true
  }' | jq . || echo "❌ Error en cotización bancaria"
echo ""

echo "✅ Tests completados!"
echo "🎉 Si ves respuestas JSON, ¡Orbix AI está funcionando perfectamente!"

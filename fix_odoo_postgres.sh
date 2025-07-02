#!/bin/bash

# 🔧 Script para arreglar la configuración de Odoo y PostgreSQL
# Soluciona problemas de master password y conexión a base de datos

echo "🔧 Arreglando configuración de Odoo + PostgreSQL..."
echo ""

# Detener todos los contenedores
echo "🛑 Deteniendo contenedores existentes..."
docker-compose -f docker-compose-full.yml down

# Limpiar volúmenes para empezar desde cero
echo "🧹 Limpiando volúmenes de base de datos..."
docker-compose -f docker-compose-full.yml down -v

# Limpiar imágenes de Odoo para reconstruir
echo "🗑️ Limpiando imagen de Odoo para reconstruir..."
docker rmi orbix-odoo 2>/dev/null || true

# Construir imagen personalizada de Odoo
echo "🏗️ Construyendo imagen personalizada de Odoo..."
docker-compose -f docker-compose-full.yml build odoo

# Iniciar PostgreSQL primero
echo "🗄️ Iniciando PostgreSQL..."
docker-compose -f docker-compose-full.yml up -d postgres

# Esperar a que PostgreSQL esté listo
echo "⏳ Esperando que PostgreSQL esté listo..."
sleep 15

# Verificar conexión a PostgreSQL
echo "🔍 Verificando conexión a PostgreSQL..."
docker exec orbix-postgres pg_isready -U odoo -d postgres

# Iniciar Odoo
echo "🚀 Iniciando Odoo..."
docker-compose -f docker-compose-full.yml up -d odoo

# Esperar a que Odoo esté listo
echo "⏳ Esperando que Odoo esté listo..."
sleep 30

# Mostrar logs de Odoo para verificar
echo "📋 Verificando logs de Odoo..."
docker-compose -f docker-compose-full.yml logs --tail=20 odoo

echo ""
echo "✅ Configuración completada!"
echo ""
echo "🌐 Accesos:"
echo "   • Odoo: http://localhost:8070"
echo "   • Master Password: orbix_master_2025"
echo "   • DB Name: odoo"
echo "   • DB User: odoo"
echo "   • DB Password: odoo_password_2025"
echo ""
echo "📋 Para crear base de datos:"
echo "   1. Ir a: http://localhost:8070/web/database/create"
echo "   2. Master Password: orbix_master_2025"
echo "   3. Database Name: odoo"
echo "   4. Email: admin@orbix.com"
echo "   5. Password: admin123"
echo "   6. Demo Data: No marcar (Sin datos demo)"
echo ""
echo "🎯 ¡Listo para crear la base de datos!"

#!/bin/bash

# 🚀 Script para configurar Odoo con el addon de Orbix
# Configuración completa para testing de Babel

echo "🎵 Configurando Odoo + Addon Orbix Payment Validation..."
echo "🔧 Configuración:"
echo "   • Odoo: http://localhost:8070"
echo "   • Base de datos: odoo"
echo "   • Usuario admin: admin"
echo "   • Password admin: orbix_admin_2025"
echo ""

# Verificar si Docker está ejecutándose
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está ejecutándose. Iniciando Docker..."
fi

# Crear directorios necesarios si no existen
mkdir -p ./odoo_addons/orbix_payment_validation/{models,views,security,data,demo}

# Detener contenedores existentes
echo "🛑 Deteniendo contenedores existentes..."
docker-compose -f docker-compose-full.yml down 2>/dev/null || true

# Construir imagen personalizada de Odoo con dependencias adicionales
echo "🏗️ Preparando imagen de Odoo personalizada..."
cat > Dockerfile.odoo << 'EOF'
FROM odoo:16.0

USER root

# Instalar dependencias adicionales para el addon
RUN pip3 install luhn

# Crear directorios necesarios
RUN mkdir -p /var/log/odoo && chown odoo:odoo /var/log/odoo

USER odoo
EOF

# Actualizar docker-compose para usar la imagen personalizada
echo "📝 Actualizando configuración de Docker Compose..."

# Limpiar base de datos si es necesario
read -p "¿Limpiar base de datos existente y reinstalar addon? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Limpiando volúmenes..."
    docker-compose -f docker-compose-full.yml down -v
fi

# Iniciar servicios
echo "🚀 Iniciando servicios..."
docker-compose -f docker-compose-full.yml up -d

echo ""
echo "⏳ Esperando que los servicios estén listos..."
sleep 30

echo ""
echo "✅ Configuración completada!"
echo ""
echo "🌐 Acceso a servicios:"
echo "   • Orbix AI: http://localhost/"
echo "   • Odoo: http://localhost:8070"
echo "   • PostgreSQL: localhost:5432"
echo ""
echo "🔑 Credenciales de Odoo:"
echo "   • Base de datos: odoo"
echo "   • Usuario: admin"
echo "   • Password: orbix_admin_2025"
echo ""
echo "📦 Addon Orbix Payment Validation configurado para testing con Babel"
echo "   • Ir a Apps -> Buscar 'Orbix Payment' -> Instalar"
echo "   • Menú: Orbix Payment Testing -> Validación de Tarjetas"
echo ""
echo "🎯 ¡Listo para testing con Babel!"

#!/bin/bash

# 🚀 Script para levantar Orbix AI + Odoo para testing de Babel
# Configuración completa en Docker

echo "🎵 Iniciando entorno completo Orbix + Odoo..."
echo "🔧 Configuración:"
echo "   • Orbix AI: http://localhost/"
echo "   • Odoo: http://localhost:8069"
echo "   • PostgreSQL: localhost:5432"
echo ""

# Verificar si Docker está ejecutándose
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está ejecutándose. Iniciando Docker..."
    # En Codespaces Docker ya debería estar ejecutándose
fi

# Detener contenedores existentes si los hay
echo "🛑 Deteniendo contenedores existentes..."
docker-compose -f docker-compose.yml down 2>/dev/null || true
docker-compose -f docker-compose-full.yml down 2>/dev/null || true

# Limpiar volúmenes si es necesario (opcional)
read -p "¿Limpiar base de datos existente? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🧹 Limpiando volúmenes..."
    docker-compose -f docker-compose-full.yml down -v
fi

# Construir imágenes
echo "🏗️ Construyendo imagen Orbix AI..."
docker build -t orbix-ai:latest .

# Levantar servicios
echo "🚀 Levantando servicios..."
docker-compose -f docker-compose-full.yml up -d

# Esperar a que PostgreSQL esté listo
echo "⏳ Esperando a que PostgreSQL esté listo..."
sleep 10

# Verificar estado de los contenedores
echo "📊 Estado de los contenedores:"
docker-compose -f docker-compose-full.yml ps

echo ""
echo "🎉 ¡Entorno levantado exitosamente!"
echo ""
echo "🌐 URLs disponibles:"
echo "   📦 Orbix AI: http://localhost/"
echo "   🏢 Odoo: http://localhost:8069"
echo "   📊 PostgreSQL: localhost:5432"
echo ""
echo "🔑 Credenciales Odoo:"
echo "   👤 Usuario: admin"
echo "   🔒 Contraseña: orbix_admin_2025"
echo "   🗃️ Base de datos: odoo"
echo ""
echo "🧪 Para testing de Babel:"
echo "   1. Ve a http://localhost:8069"
echo "   2. Crea la base de datos 'odoo'"
echo "   3. Instala el módulo 'Orbix Payment Validation'"
echo "   4. Ve a Accounting > Orbix Payment Validation"
echo "   5. Crea registros de tarjetas para testing"
echo ""
echo "📝 Logs en tiempo real:"
echo "   docker-compose -f docker-compose-full.yml logs -f"
echo ""
echo "🛑 Para detener todo:"
echo "   docker-compose -f docker-compose-full.yml down"

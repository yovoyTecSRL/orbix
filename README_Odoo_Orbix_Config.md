# 🚀 Orbix - Configuración Completa de Odoo

## 📋 Configuración de Odoo para Testing de Babel

Este documento describe la configuración completa de Odoo integrado con Orbix para testing de validaciones de tarjetas de crédito.

### 🎯 Servicios Disponibles

| Servicio | URL | Puerto | Descripción |
|----------|-----|--------|-------------|
| **Orbix AI** | http://localhost/ | 80 | API principal FastAPI + Dashboard |
| **Odoo ERP** | http://localhost:8070 | 8070 | Sistema Odoo con addon personalizado |
| **PostgreSQL** | localhost:5432 | 5432 | Base de datos |

### 🔧 Configuración de Odoo

#### Credenciales
- **Base de datos**: `odoo`
- **Usuario admin**: `admin`
- **Password admin**: `orbix_admin_2025`
- **Password de operaciones DB**: `orbix_admin_2025`

#### Configuración Personalizada
- **Timezone**: America/Bogota
- **Idioma**: Español (es_ES)
- **Addons personalizados**: `/mnt/extra-addons`
- **Logs**: `/var/log/odoo/odoo.log`

### 📦 Addon: Orbix Payment Validation

El addon personalizado `orbix_payment_validation` está diseñado específicamente para que Babel pueda hacer testing de validaciones de tarjetas de crédito.

#### Características del Addon:
- ✅ Validación de números de tarjeta (algoritmo Luhn)
- ✅ Detección automática de tipo de tarjeta (Visa, MasterCard, Amex, Discover)
- ✅ Validación de formato según tipo de tarjeta
- ✅ Validación de fecha de expiración
- ✅ Enmascaramiento de números de tarjeta para seguridad
- ✅ Sistema de testing integrado
- ✅ Datos de prueba precargados

#### Tipos de Tarjeta Soportados:
- **Visa**: Números que empiezan con 4 (16 dígitos)
- **MasterCard**: Números que empiezan con 51-55 (16 dígitos)
- **American Express**: Números que empiezan con 34 o 37 (15 dígitos)
- **Discover**: Números que empiezan con 6 (16 dígitos)

### 🚀 Inicio Rápido

#### 1. Configuración Automática
```bash
# Ejecutar script de configuración completa
./setup_odoo_orbix.sh
```

#### 2. Configuración Manual
```bash
# Iniciar servicios completos
docker-compose -f docker-compose-full.yml up -d

# Verificar estado de servicios
docker-compose -f docker-compose-full.yml ps
```

#### 3. Acceso a Odoo
1. Ir a: http://localhost:8070
2. Crear base de datos si es necesario:
   - **Nombre**: `odoo`
   - **Email**: `admin@orbix.com`
   - **Password**: `orbix_admin_2025`
3. Instalar el addon:
   - Ir a **Apps**
   - Buscar `Orbix Payment`
   - Hacer clic en **Instalar**

### 🧪 Testing con Babel

#### Datos de Prueba Incluidos:

| Tarjeta | Número | Tipo | Estado | CVV | Expiración |
|---------|---------|------|--------|-----|------------|
| Visa Válida | 4532015112830366 | Visa | Válida | 123 | 12/2027 |
| MasterCard Válida | 5555555555554444 | MasterCard | Válida | 456 | 06/2026 |
| Amex Válida | 378282246310005 | Amex | Válida | 1234 | 03/2025 |
| Visa Expirada | 4000000000000002 | Visa | Expirada | 789 | 01/2020 |
| Luhn Inválida | 4532015112830367 | Visa | Inválida | 123 | 12/2027 |

#### Proceso de Testing:
1. Acceder al menú: **Orbix Payment Testing → Validación de Tarjetas**
2. Crear nuevo registro o usar datos de prueba
3. Hacer clic en **Ejecutar Test de Validación**
4. Verificar resultados en tiempo real

#### API para Integración:
```python
# Ejemplo de validación programática
validation = env['orbix.payment.validation'].create({
    'card_number': '4532015112830366',
    'expiry_month': '12',
    'expiry_year': '2027',
    'cvv': '123',
    'babel_tester': 'Automated Test'
})
validation.action_test_payment()
```

### 🔍 Monitoreo y Logs

#### Verificar Servicios:
```bash
# Estado de contenedores
docker-compose -f docker-compose-full.yml ps

# Logs de Odoo
docker-compose -f docker-compose-full.yml logs odoo

# Logs de PostgreSQL
docker-compose -f docker-compose-full.yml logs postgres
```

#### Acceso a Base de Datos:
```bash
# Conectar a PostgreSQL directamente
docker exec -it orbix-postgres psql -U odoo -d odoo
```

### 🛠️ Desarrollo del Addon

#### Estructura del Addon:
```
odoo_addons/orbix_payment_validation/
├── __manifest__.py                 # Configuración del addon
├── models/
│   └── __init__.py                # Modelo principal con validaciones
├── views/
│   └── payment_validation_views.xml # Interfaces de usuario
├── security/
│   └── ir.model.access.csv        # Permisos de acceso
├── data/
│   └── payment_test_data.xml      # Datos de prueba
├── demo/
│   └── demo_data.xml              # Datos de demostración
└── requirements.txt               # Dependencias Python
```

#### Instalación de Dependencias:
```bash
# Dentro del contenedor de Odoo
pip3 install luhn
```

### 🎯 Casos de Uso para Babel

1. **Testing de Validación Básica**:
   - Verificar algoritmo Luhn
   - Validar formatos de tarjeta
   - Comprobar fechas de expiración

2. **Testing de Tipos de Tarjeta**:
   - Detección automática de Visa, MasterCard, Amex
   - Validación de longitudes específicas

3. **Testing de Casos Edge**:
   - Tarjetas expiradas
   - Números inválidos
   - Formatos incorrectos

4. **Integration Testing**:
   - API calls desde Babel
   - Verificación de respuestas
   - Testing de performance

### 📚 Referencias

- [Odoo 16 Documentation](https://www.odoo.com/documentation/16.0/)
- [Algoritmo Luhn](https://en.wikipedia.org/wiki/Luhn_algorithm)
- [Payment Card Industry Standards](https://www.pcisecuritystandards.org/)

### 🆘 Troubleshooting

#### Problema: Addon no aparece en Apps
```bash
# Reiniciar Odoo en modo desarrollo
docker-compose -f docker-compose-full.yml restart odoo
```

#### Problema: Error de dependencias
```bash
# Rebuild de imagen personalizada
docker-compose -f docker-compose-full.yml build odoo --no-cache
```

#### Problema: Base de datos no se crea
```bash
# Limpiar volúmenes y reiniciar
docker-compose -f docker-compose-full.yml down -v
docker-compose -f docker-compose-full.yml up -d
```

---

🎵 **Orbix + Odoo configurado y listo para testing con Babel!**

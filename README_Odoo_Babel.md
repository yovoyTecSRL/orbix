# 🏢 Odoo para Testing de Validaciones - Babel

## 🎯 Propósito
Esta instalación de Odoo está específicamente configurada para que **Babel pueda hacer testing de validaciones de tarjetas de crédito** en el sistema Orbix.

## 🚀 Inicio rápido

### 1. Levantar el entorno completo:
```bash
./start_orbix_odoo.sh
```

### 2. Acceder a Odoo:
- **URL:** http://localhost:8069
- **Usuario:** admin
- **Contraseña:** orbix_admin_2025

### 3. Configuración inicial:
1. Crear base de datos "odoo"
2. Instalar módulo "Orbix Payment Validation"
3. Ir a: Accounting → Orbix Payment Validation

## 🧪 Testing para Babel

### Módulo personalizado: `orbix_payment_validation`

**Características:**
- ✅ Validación de números de tarjeta (algoritmo Luhn)
- ✅ Detección automática de tipo de tarjeta
- ✅ Validación de fecha de expiración
- ✅ Enmascaramiento de números sensibles
- ✅ Simulación de transacciones

### Tipos de tarjeta soportados:
- 💳 **Visa** (empiezan con 4)
- 💳 **MasterCard** (empiezan con 51-55)
- 💳 **American Express** (empiezan con 34, 37)
- 💳 **Discover** (empiezan con 6)

### Casos de testing para Babel:

#### ✅ Tarjetas válidas para testing:
```
Visa: 4532015112830366
MasterCard: 5555555555554444
Amex: 378282246310005
Discover: 6011111111111117
```

#### ❌ Tarjetas inválidas para testing:
```
Número inválido: 1234567890123456
Luhn incorrecto: 4532015112830367
Expirada: Cualquier tarjeta con fecha pasada
```

## 🔧 Configuración técnica

### Docker Compose:
- **Odoo:** Puerto 8069
- **PostgreSQL:** Puerto 5432
- **Orbix AI:** Puerto 80

### Volúmenes:
- `postgres_data`: Datos de PostgreSQL
- `odoo_web_data`: Datos web de Odoo
- `./odoo_addons`: Módulos personalizados

## 📊 API para integración

El módulo expone métodos para:
- `action_test_payment()`: Testing de validación
- Validaciones automáticas en tiempo real
- Logging de resultados para Babel

## 🔍 Debugging

### Ver logs:
```bash
docker-compose -f docker-compose-full.yml logs -f odoo
```

### Acceso directo a PostgreSQL:
```bash
docker exec -it orbix-postgres psql -U odoo -d odoo
```

### Reiniciar solo Odoo:
```bash
docker-compose -f docker-compose-full.yml restart odoo
```

## 🎯 Workflow de testing para Babel

1. **Crear tarjeta de prueba** en el módulo
2. **Ejecutar validaciones** automáticas
3. **Verificar resultados** (aprobada/rechazada)
4. **Revisar logs** de testing
5. **Exportar resultados** si es necesario

## 🛡️ Seguridad

- ⚠️ **Solo para testing** - No usar en producción
- 🔒 Datos de tarjeta enmascarados automáticamente
- 📝 Logs detallados para auditoría
- 🚫 Sin conexión a procesadores reales de pago

---
*Configurado por Copilot para testing de Babel - Orbix Systems*

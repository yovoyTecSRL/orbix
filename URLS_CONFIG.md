# 🌐 Configuración de URLs y Dominios - Orbix AI

## 📍 SERVIDORES ACTIVOS

### 💻 CODESPACES (Desarrollo) ✅ FUNCIONANDO
**URL Local:** http://localhost/
**URL Pública:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-80.app.github.dev/
**Puerto:** 80 → 8000 (FastAPI interno)
**Estado:** ✅ ACTIVO Y FUNCIONANDO
**Uso:** Desarrollo y testing

### 🌐 HETZNER (Producción) 🔄 DESPLEGANDO  
**IP:** 46.62.144.123
**Dominio:** sistemasorbix.com
**Puerto:** 80 (HTTP) / 443 (HTTPS cuando configure SSL)
**Estado:** 🔄 GITHUB ACTIONS EJECUTÁNDOSE
**Uso:** Producción

## 🏢 ODOO (Solo Codespaces) ⚠️ REINICIANDO
**URL:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-8069.app.github.dev/
**Puerto:** 8069 (Odoo estándar)
**Usuario:** admin
**Contraseña:** orbix_admin_2025
**Estado:** 🔄 Configuración en proceso
**Uso:** Testing validaciones Babel

## 🗃️ POSTGRESQL (Solo Codespaces) ✅ FUNCIONANDO
**Host:** localhost
**Puerto:** 5432 (PostgreSQL estándar)
**Base de datos:** odoo
**Usuario:** odoo
**Contraseña:** odoo_password_2025
**Estado:** ✅ ACTIVO

## 🔧 Configuración DNS requerida

Para usar sistemasorbix.com necesitas configurar:

```dns
A    sistemasorbix.com         46.62.144.123
A    www.sistemasorbix.com     46.62.144.123
A    api.sistemasorbix.com     46.62.144.123
```

## 📋 URLs finales de acceso

✅ **DESARROLLO:**
- **Orbix AI:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-80.app.github.dev/
- **Odoo:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-8069.app.github.dev/
- **API Docs:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-80.app.github.dev/docs

🚀 **PRODUCCIÓN (una vez configurado DNS):**
- **Orbix AI:** https://sistemasorbix.com/
- **API:** https://api.sistemasorbix.com/
- **Docs:** https://sistemasorbix.com/docs

## 🧪 Testing rápido

### Codespaces:
```bash
curl https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-80.app.github.dev/health
```

### Hetzner (por IP):
```bash
curl http://46.62.144.123/health
```

### Hetzner (por dominio, cuando esté configurado):
```bash
curl https://sistemasorbix.com/health
```

# 🌐 Configuración de URLs y Dominios - Orbix AI

## 📍 SERVIDORES ACTIVOS

### 💻 CODESPACES (Desarrollo)
**URL:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-80.app.github.dev/
**Puerto:** 80 (mapeado a 8000 interno)
**Estado:** ✅ ACTIVO
**Uso:** Desarrollo y testing

### 🌐 HETZNER (Producción)  
**IP:** 46.62.144.123
**Dominio:** sistemasorbix.com
**Puerto:** 80
**Estado:** 🔄 DESPLEGANDO
**Uso:** Producción

## 🏢 ODOO (Solo Codespaces)
**URL:** https://super-duper-space-xylophone-4jgg45xrwxx9c7qpp-8069.app.github.dev/
**Puerto:** 8069
**Usuario:** admin
**Contraseña:** orbix_admin_2025
**Uso:** Testing validaciones Babel

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

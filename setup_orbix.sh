#!/bin/bash
# 🔧 Script de instalación para Orbix AI Matrix

echo "📦 Actualizando sistema y preparando entorno..."
apt update && apt upgrade -y
apt install -y docker.io docker-compose nginx certbot unzip curl

echo "🐳 Lanzando contenedores con Docker Compose..."
cd /opt/orbix-repo/config
docker-compose up -d --build

echo "🌐 Configurando NGINX..."
cat <<EOF > /etc/nginx/sites-available/orbix
server {
    listen 80;
    server_name orbix.yourdomain.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

ln -s /etc/nginx/sites-available/orbix /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

echo "🔐 Activando SSL con Certbot (Let's Encrypt)..."
certbot --nginx -d orbix.yourdomain.com --non-interactive --agree-tos -m admin@yourdomain.com --redirect

echo "✅ Instalación completa: accede a https://orbix.yourdomain.com"

#!/bin/bash
# 🚀 Script de despliegue ORBIX para demo-clientes.sistemasorbix.com

echo "🔧 Actualizando sistema y preparando entorno..."
apt update && apt install -y docker.io docker-compose nginx certbot unzip

echo "🌐 Configurando NGINX..."
cat <<EOF > /etc/nginx/sites-available/demo-clientes.sistemasorbix.com
server {
    listen 80;
    server_name demo-clientes.sistemasorbix.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF

ln -s /etc/nginx/sites-available/demo-clientes.sistemasorbix.com /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

echo "🔐 Configurando SSL con Let's Encrypt..."
certbot --nginx -d demo-clientes.sistemasorbix.com --non-interactive --redirect --agree-tos -m admin@sistemasorbix.com

echo "🐳 Desplegando containers con Docker Compose..."
docker-compose up -d

echo "✅ Despliegue completo: https://demo-clientes.sistemasorbix.com"

#!/bin/bash

echo "🔐 Iniciando configuración de clave SSH para Hetzner + GitHub"

# Crear carpeta .ssh si no existe
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Eliminar claves previas si existen
rm -f ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

# Generar nueva clave
ssh-keygen -t ed25519 -C "orbix@hetzner" -f ~/.ssh/id_ed25519 -N ""

# Mostrar clave pública
echo ""
echo "✅ Clave SSH generada exitosamente. COPIÁ lo siguiente y agrégalo a tu GitHub:"
echo "👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇"
cat ~/.ssh/id_ed25519.pub
echo "👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆"
echo ""
echo "👉 Pegalo en GitHub → Settings → SSH Keys → New SSH Key"

# Probar conexión
echo ""
read -p "Presioná ENTER cuando hayas pegado la clave en GitHub para probar conexión..."

ssh -T git@github.com

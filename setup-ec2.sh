#!/bin/bash
# Script para preparar una instancia EC2 Ubuntu 24.04 para despliegues con GitHub Actions
# Instala Docker, Docker Compose Plugin v2, Git, y configura permisos

set -e

# --- 1. Eliminar versiones antiguas de Docker (opcional y seguro) ---
echo "🧹 Eliminando versiones antiguas de Docker si existen..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

# --- 2. Actualizar el sistema e instalar dependencias ---
echo "📦 Instalando dependencias..."
sudo apt update -y
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  git \
  unzip

# --- 3. Agregar la clave GPG oficial de Docker ---
echo "🔐 Agregando clave GPG de Docker..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# --- 4. Agregar el repositorio oficial de Docker ---
echo "➕ Agregando repositorio de Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# --- 5. Instalar Docker CE y Docker Compose v2 plugin ---
echo "🐳 Instalando Docker y Docker Compose v2 plugin..."
sudo apt update -y
sudo apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# --- 6. Habilitar y arrancar Docker ---
echo "⚙️ Habilitando Docker..."
sudo systemctl enable --now docker

# --- 7. Agregar usuario ubuntu al grupo docker ---
echo "👤 Agregando usuario ubuntu al grupo docker..."
sudo usermod -aG docker ubuntu

# --- 8. Crear directorio para despliegue ---
echo "📁 Creando /var/www/html para despliegue..."
sudo mkdir -p /var/www/html
sudo chown -R ubuntu:ubuntu /var/www/html

# --- 9. Verificar instalaciones ---
echo "🔍 Verificando versiones instaladas..."
docker --version
docker compose version
git --version

# --- 10. Mensaje final ---
echo ""
cat << "EOF"
✅ Instalación completada correctamente
--------------------------------------------------
📌 Recuerda:
1. Configura tus secrets en GitHub Actions:
   - EC2_SSH_KEY: Clave privada PEM
   - EC2_HOST: Dirección pública de la instancia (DNS o IP)

2. Tu aplicación se desplegará en:
   /var/www/html

3. Para probar la conexión manualmente desde tu máquina:
   ssh -i tu_key.pem ubuntu@<EC2_PUBLIC_IP>

4. Para verificar Docker Compose:
   docker compose version

🧠 Tip: Cierra y vuelve a abrir sesión o ejecuta 'newgrp docker' para aplicar el grupo.
EOF

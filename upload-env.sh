#!/bin/bash

# === CONFIGURACIÓN ===
EC2_USER=ubuntu
EC2_IP=52.91.1.230     # <-- Reemplázalo por tu IP pública real de EC2 (o usa una variable)
PEM_PATH="~/Descargas/booksapp_laravel.pem"
LOCAL_ENV_PATH=".env.production"
REMOTE_DIR="/home/ubuntu/"

# === SUBIR ARCHIVO ===
echo "Subiendo $LOCAL_ENV_PATH a $EC2_USER@$EC2_IP:$REMOTE_DIR/.env.production"

scp -i "$PEM_PATH" "$LOCAL_ENV_PATH" "$EC2_USER@$EC2_IP:$REMOTE_DIR/.env.production"


if [ $? -eq 0 ]; then
  echo "✅ Archivo .env.production subido con éxito a la instancia EC2."
else
  echo "❌ Error al subir el archivo. Verifica la IP, clave PEM y ruta."
fi

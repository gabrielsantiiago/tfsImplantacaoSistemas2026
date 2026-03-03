#!/bin/bash

# Script de Instalação - TechPro Informática
# Autor: TechPro Team
# Descrição: Instala e configura o Nginx com o site da TechPro

set -e

echo "=========================================="
echo "  Instalação TechPro Informática"
echo "=========================================="
echo ""

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Este script precisa ser executado como root (use sudo)"
    exit 1
fi

# Atualizar repositórios
echo "📦 Atualizando repositórios..."
apt update

# Instalar Nginx
echo "📦 Instalando Nginx..."
apt install nginx -y

# Criar diretório do site
echo "📁 Criando diretório do site..."
mkdir -p /var/www/techpro

# Copiar arquivos do website
echo "📄 Copiando arquivos do website..."
cp -r ../website/* /var/www/techpro/

# Configurar permissões
echo "🔒 Configurando permissões..."
chown -R www-data:www-data /var/www/techpro
find /var/www/techpro -type d -exec chmod 755 {} \;
find /var/www/techpro -type f -exec chmod 644 {} \;

# Criar diretório de logs
echo "📝 Criando diretório de logs..."
mkdir -p /var/log/nginx/techpro
chown -R www-data:adm /var/log/nginx/techpro
chmod 755 /var/log/nginx/techpro

# Copiar configuração do Nginx
echo "⚙️  Configurando Nginx..."
cp ../nginx/site.conf /etc/nginx/sites-available/techpro

# Criar link simbólico
ln -sf /etc/nginx/sites-available/techpro /etc/nginx/sites-enabled/

# Remover configuração padrão (opcional)
if [ -f /etc/nginx/sites-enabled/default ]; then
    echo "🗑️  Removendo configuração padrão..."
    rm /etc/nginx/sites-enabled/default
fi

# Testar configuração
echo "🧪 Testando configuração do Nginx..."
nginx -t

# Habilitar Nginx no boot
echo "🚀 Habilitando Nginx no boot..."
systemctl enable nginx

# Reiniciar Nginx
echo "🔄 Reiniciando Nginx..."
systemctl restart nginx

# Verificar status
echo ""
echo "✅ Instalação concluída com sucesso!"
echo ""
echo "=========================================="
echo "  Informações do Servidor"
echo "=========================================="
echo "Status do Nginx: $(systemctl is-active nginx)"
echo "Habilitado no boot: $(systemctl is-enabled nginx)"
echo "Diretório do site: /var/www/techpro"
echo "Logs de acesso: /var/log/nginx/techpro/access.log"
echo "Logs de erro: /var/log/nginx/techpro/error.log"
echo ""
echo "Acesse o site em: http://localhost"
echo "=========================================="

# Documentação de Configuração - TechPro Informática

## Requisitos do Sistema

- Sistema Operacional: Ubuntu 20.04 LTS ou superior / Debian 10+
- Nginx: versão 1.18+
- Usuário com privilégios sudo para instalação inicial

## Instalação e Configuração

### 1. Instalação do Nginx

```bash
# Atualizar repositórios
sudo apt update

# Instalar Nginx
sudo apt install nginx -y

# Verificar status
sudo systemctl status nginx
```

### 2. Estrutura de Diretórios

```
/var/www/techpro/          # Diretório raiz do site
/etc/nginx/sites-available/ # Configurações disponíveis
/etc/nginx/sites-enabled/   # Configurações ativas
/var/log/nginx/techpro/     # Logs personalizados
```

### 3. Configuração de Permissões

```bash
# Criar diretório do site
sudo mkdir -p /var/www/techpro

# Copiar arquivos do website
sudo cp -r website/* /var/www/techpro/

# Definir proprietário correto
sudo chown -R www-data:www-data /var/www/techpro

# Configurar permissões adequadas
sudo find /var/www/techpro -type d -exec chmod 755 {} \;
sudo find /var/www/techpro -type f -exec chmod 644 {} \;

# Criar diretório de logs
sudo mkdir -p /var/log/nginx/techpro
sudo chown -R www-data:adm /var/log/nginx/techpro
sudo chmod 755 /var/log/nginx/techpro
```

**Explicação das Permissões:**
- `755` para diretórios: Proprietário (rwx), Grupo (rx), Outros (rx)
- `644` para arquivos: Proprietário (rw), Grupo (r), Outros (r)
- Proprietário `www-data`: Usuário padrão do Nginx
- Grupo `www-data`: Grupo padrão do Nginx

### 4. Configuração do Virtual Host

```bash
# Copiar configuração
sudo cp nginx/site.conf /etc/nginx/sites-available/techpro

# Criar link simbólico
sudo ln -s /etc/nginx/sites-available/techpro /etc/nginx/sites-enabled/

# Remover configuração padrão (opcional)
sudo rm /etc/nginx/sites-enabled/default

# Testar configuração
sudo nginx -t

# Recarregar Nginx
sudo systemctl reload nginx
```

### 5. Habilitar Inicialização Automática

```bash
# Habilitar serviço no boot
sudo systemctl enable nginx

# Verificar se está habilitado
sudo systemctl is-enabled nginx
```

## Configurações de Segurança Implementadas

### 1. Permissões de Arquivo
- Arquivos HTML/CSS: `644` (leitura para todos, escrita apenas para proprietário)
- Diretórios: `755` (navegação permitida, escrita apenas para proprietário)
- Proprietário: `www-data` (usuário do Nginx, sem privilégios de root)

### 2. Configuração do Nginx

**Headers de Segurança:**
```nginx
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
```

- `X-Frame-Options`: Previne clickjacking
- `X-Content-Type-Options`: Previne MIME type sniffing
- `X-XSS-Protection`: Ativa proteção contra XSS

**Outras Configurações:**
- Desabilitação de listagem de diretórios (autoindex off)
- Página 404 customizada
- Logs separados por site
- Limite de tamanho de upload (client_max_body_size)

### 3. Isolamento de Logs
- Logs de acesso e erro separados por site
- Permissões restritas no diretório de logs
- Facilita auditoria e troubleshooting

### 4. Princípio do Menor Privilégio
- Nginx roda como usuário `www-data` (não-privilegiado)
- Arquivos não são executáveis
- Sem permissões de escrita desnecessárias

## Testes e Verificação

### Verificar Configuração
```bash
sudo nginx -t
```

### Verificar Permissões
```bash
ls -la /var/www/techpro
ls -la /var/log/nginx/techpro
```

### Verificar Status do Serviço
```bash
sudo systemctl status nginx
```

### Testar Acesso
```bash
curl -I http://localhost
curl http://localhost/pagina-inexistente  # Testa página 404
```

### Verificar Logs
```bash
sudo tail -f /var/log/nginx/techpro/access.log
sudo tail -f /var/log/nginx/techpro/error.log
```

## Manutenção

### Recarregar Configuração (sem downtime)
```bash
sudo systemctl reload nginx
```

### Reiniciar Nginx
```bash
sudo systemctl restart nginx
```

### Verificar Logs de Erro
```bash
sudo tail -n 50 /var/log/nginx/techpro/error.log
```

### Rotação de Logs
O Nginx utiliza logrotate automaticamente. Configuração em:
```
/etc/logrotate.d/nginx
```

## Troubleshooting

### Nginx não inicia
```bash
# Verificar erros de configuração
sudo nginx -t

# Verificar logs do sistema
sudo journalctl -u nginx -n 50
```

### Erro 403 Forbidden
- Verificar permissões dos arquivos
- Verificar propriedade (www-data)
- Verificar configuração do root no site.conf

### Erro 502 Bad Gateway
- Verificar se o Nginx está rodando
- Verificar logs de erro

## Backup

### Arquivos Importantes para Backup
```bash
/var/www/techpro/              # Conteúdo do site
/etc/nginx/sites-available/    # Configurações
/var/log/nginx/techpro/        # Logs (opcional)
```

### Comando de Backup
```bash
sudo tar -czf backup-techpro-$(date +%Y%m%d).tar.gz \
  /var/www/techpro \
  /etc/nginx/sites-available/techpro
```

## Referências

- [Documentação Oficial do Nginx](https://nginx.org/en/docs/)
- [Nginx Security Headers](https://www.nginx.com/blog/http-security-headers/)
- [Linux File Permissions](https://www.linux.com/training-tutorials/understanding-linux-file-permissions/)

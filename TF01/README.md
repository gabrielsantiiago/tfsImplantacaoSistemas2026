
## Aluno
- **Nome:** [Gabriel Santiago de Andrade]
- **RA:** [6324647]
- **Curso:** Análise e Desenvolvimento de Sistemas

# TechPro Informática - Website Institucional

Projeto de website institucional para a TechPro Informática, uma loja de computadores e soluções em tecnologia.

## 📋 Sobre o Projeto

Este projeto demonstra a configuração manual de um servidor web Nginx com página institucional personalizada, aplicando boas práticas de segurança e gerenciamento de permissões no Linux.

## 🏢 Empresa Fictícia

**Nome:** TechPro Informática  
**Ramo:** Comércio de equipamentos de informática e tecnologia  
**Fundação:** 2015

### Serviços Oferecidos
- Venda de computadores (desktops, notebooks, workstations)
- Periféricos e acessórios
- Componentes de hardware
- Serviços técnicos (montagem, manutenção, upgrade)
- Soluções corporativas

Mais detalhes em: [docs/empresa.md](docs/empresa.md)

## 🚀 Tecnologias Utilizadas

- **Servidor Web:** Nginx 1.18+
- **Frontend:** HTML5, CSS3 (sem frameworks)
- **Sistema Operacional:** Ubuntu 20.04 LTS / Debian 10+

## 📁 Estrutura do Projeto

```
TF01/
├── README.md                    # Este arquivo
├── website/                     # Arquivos do site
│   ├── index.html              # Página inicial
│   ├── sobre.html              # Sobre a empresa
│   ├── servicos.html           # Serviços oferecidos
│   ├── contato.html            # Formulário de contato
│   ├── 404.html                # Página de erro customizada
│   ├── css/
│   │   └── style.css           # Estilos personalizados
│   └── images/
│       └── logo.png            # Logo da empresa
├── nginx/
│   └── site.conf               # Configuração do virtual host
├── scripts/
│   └── install.sh              # Script de instalação automatizado
└── docs/
    ├── empresa.md              # Documentação da empresa
    └── configuracao.md         # Documentação técnica
```

## 🔧 Instalação

### Pré-requisitos

- Ubuntu 20.04 LTS ou superior / Debian 10+
- Acesso root ou sudo
- Conexão com a internet

### Instalação Automatizada

```bash
# Navegar até o diretório de scripts
cd TF01/scripts

# Dar permissão de execução
chmod +x install.sh

# Executar o script
sudo ./install.sh
```

### Instalação Manual

Consulte a documentação completa em [docs/configuracao.md](docs/configuracao.md)

#### Passos Resumidos:

1. **Instalar Nginx**
```bash
sudo apt update
sudo apt install nginx -y
```

2. **Criar estrutura de diretórios**
```bash
sudo mkdir -p /var/www/techpro
sudo mkdir -p /var/log/nginx/techpro
```

3. **Copiar arquivos**
```bash
sudo cp -r website/* /var/www/techpro/
sudo cp nginx/site.conf /etc/nginx/sites-available/techpro
```

4. **Configurar permissões**
```bash
sudo chown -R www-data:www-data /var/www/techpro
sudo find /var/www/techpro -type d -exec chmod 755 {} \;
sudo find /var/www/techpro -type f -exec chmod 644 {} \;
```

5. **Ativar site**
```bash
sudo ln -s /etc/nginx/sites-available/techpro /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl enable nginx
sudo systemctl restart nginx
```

## 🔒 Configurações de Segurança

### Permissões de Arquivos
- **Diretórios:** 755 (rwxr-xr-x)
- **Arquivos:** 644 (rw-r--r--)
- **Proprietário:** www-data:www-data

### Headers de Segurança
- `X-Frame-Options: SAMEORIGIN` - Proteção contra clickjacking
- `X-Content-Type-Options: nosniff` - Previne MIME type sniffing
- `X-XSS-Protection: 1; mode=block` - Proteção contra XSS

### Outras Medidas
- Desabilitação de listagem de diretórios
- Página 404 customizada
- Logs separados por site
- Negação de acesso a arquivos ocultos e backups
- Limite de tamanho de upload (10MB)

## 📊 Verificação

### Testar Configuração
```bash
sudo nginx -t
```

### Verificar Status
```bash
sudo systemctl status nginx
```

### Verificar Permissões
```bash
ls -la /var/www/techpro
```

### Acessar o Site
```
http://localhost
http://seu-ip-servidor
```

### Visualizar Logs
```bash
# Logs de acesso
sudo tail -f /var/log/nginx/techpro/access.log

# Logs de erro
sudo tail -f /var/log/nginx/techpro/error.log
```

## 🌐 Páginas do Site

- **Home** (`index.html`) - Página inicial com apresentação da empresa
- **Sobre** (`sobre.html`) - História, missão, visão e valores
- **Serviços** (`servicos.html`) - Produtos e serviços oferecidos
- **Contato** (`contato.html`) - Formulário de contato e informações
- **404** (`404.html`) - Página de erro personalizada

## 📱 Responsividade

O site é totalmente responsivo e se adapta a diferentes tamanhos de tela:
- Desktop (> 768px)
- Tablet (768px - 480px)
- Mobile (< 480px)

## 🛠️ Manutenção

### Recarregar Configuração
```bash
sudo systemctl reload nginx
```

### Reiniciar Nginx
```bash
sudo systemctl restart nginx
```

### Backup
```bash
sudo tar -czf backup-techpro-$(date +%Y%m%d).tar.gz \
  /var/www/techpro \
  /etc/nginx/sites-available/techpro
```

## 📝 Logs

Os logs são armazenados em:
- **Acesso:** `/var/log/nginx/techpro/access.log`
- **Erro:** `/var/log/nginx/techpro/error.log`

## 🐛 Troubleshooting

### Nginx não inicia
```bash
sudo nginx -t
sudo journalctl -u nginx -n 50
```

### Erro 403 Forbidden
- Verificar permissões dos arquivos
- Verificar propriedade (www-data)

### Erro 502 Bad Gateway
- Verificar se o Nginx está rodando
- Verificar logs de erro

## 📚 Documentação Adicional

- [Documentação da Empresa](docs/empresa.md)
- [Documentação de Configuração](docs/configuracao.md)
- [Documentação Oficial do Nginx](https://nginx.org/en/docs/)

## 👥 Autor

Projeto desenvolvido para demonstração de conceitos de deploy manual e configuração de servidor web.

## 📄 Licença

Este é um projeto educacional para fins de demonstração.

---

**TechPro Informática** - Sua loja de confiança em tecnologia desde 2015

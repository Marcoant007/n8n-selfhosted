# Stack n8n + Chatwoot + Evolution API Local

Esta stack integra o n8n (automação), Chatwoot (atendimento) e Evolution API (WhatsApp) para criar um sistema completo de atendimento automatizado.

## 🏗️ Arquitetura

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    n8n      │    │  Chatwoot   │    │ Evolution   │
│ (Automação) │◄──►│(Atendimento)│◄──►│API(WhatsApp)│
│   :5678     │    │    :3000    │    │    :8080    │
└─────────────┘    └─────────────┘    └─────────────┘
       │                   │                   │
       └───────────────────┼───────────────────┘
                           │
                  ┌─────────────┐
                  │ PostgreSQL  │
                  │   Redis     │
                  │ (Database)  │
                  └─────────────┘
```

## 🚀 Como usar

### 1. Configurar variáveis de ambiente
```powershell
# Copie o arquivo de exemplo
copy .env.example .env

# Edite o arquivo .env e configure:
# - SECRET_KEY_BASE: Gere uma chave segura (já foi gerada automaticamente)
# - EVOLUTION_API_TOKEN: Token para acessar a Evolution API (opcional)
# - Outras configurações conforme necessário
```

### 2. Iniciar a stack
```powershell
# Execute o script de inicialização (recomendado)
.\start.ps1

# OU manualmente
docker-compose up -d
```

### 3. Acessar os serviços

**🔐 Configuração do Chatwoot**
1. Acesse: http://localhost:3000
2. Crie sua conta de administrador
3. Configure sua primeira caixa de entrada (Inbox)
4. Anote o webhook URL que será usado no n8n

**📱 Configurar Evolution API**
1. Acesse: http://localhost:8080
2. Crie uma nova instância do WhatsApp
3. Escaneie o QR Code com seu WhatsApp
4. Configure os webhooks para enviar dados ao n8n

**🔄 Configurar n8n**
1. Acesse: http://localhost:5678
2. Crie workflows para conectar Chatwoot e Evolution API
3. Use os endpoints internos dos containers

## 🔒 Segurança

### Variáveis de ambiente
- **Nunca commite o arquivo `.env`** - ele contém informações sensíveis
- Use o arquivo `.env.example` como modelo
- Gere um `SECRET_KEY_BASE` forte de 128 caracteres (já incluído)
- Configure tokens seguros para a Evolution API

### Produção
⚠️ **Esta configuração é apenas para desenvolvimento local!**

Para produção, considere:
- Usar HTTPS com certificados SSL
- Configurar proxy reverso (nginx/traefik)
- Usar banco de dados externo com backup
- Implementar logs estruturados
- Configurar monitoring e alertas

## 🔗 URLs de Acesso

- **Chatwoot**: http://localhost:3000
- **n8n**: http://localhost:5678  
- **Evolution API**: http://localhost:8080
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

## 📡 Endpoints para integração

### Evolution API → n8n
```
Webhook URL: http://n8n:5678/webhook/evolution
```

### n8n → Chatwoot
```
Chatwoot API: http://chatwoot:3000/api/v1/
```

### n8n → Evolution API
```
Evolution API: http://evolution-api:8080/
```

## 🛠️ Comandos úteis

```powershell
# Ver logs de todos os serviços
docker-compose logs -f

# Ver logs de um serviço específico
docker-compose logs -f n8n
docker-compose logs -f chatwoot
docker-compose logs -f evolution-api

# Reiniciar um serviço
docker-compose restart n8n

# Parar tudo
docker-compose down

# Parar e remover volumes (CUIDADO: perde dados)
docker-compose down -v
```

## 🔧 Configurações importantes

### Variáveis de ambiente (.env)
- `SECRET_KEY_BASE`: Chave secreta do Chatwoot (mude para algo seguro)
- `EVOLUTION_API_TOKEN`: Token para acessar a Evolution API
- `N8N_WEBHOOK_URL`: URL base para webhooks do n8n

### Portas utilizadas
- 3000: Chatwoot Web Interface
- 5678: n8n Web Interface  
- 8080: Evolution API
- 5432: PostgreSQL
- 6379: Redis

## 🐛 Troubleshooting

### Containers não sobem
```powershell
# Verificar logs
docker-compose logs

# Verificar se as portas estão livres
netstat -an | findstr ":3000"
netstat -an | findstr ":5678" 
netstat -an | findstr ":8080"
```

### Chatwoot não conecta no banco
- Verifique se o PostgreSQL subiu corretamente
- Confirme as credenciais no .env

### Evolution API não conecta WhatsApp
- Verifique se o QR Code foi escaneado
- Confirme se a instância está ativa na interface

## 📚 Próximos passos

1. **Configure os webhooks** entre os serviços
2. **Crie workflows no n8n** para automatizar respostas
3. **Configure templates** de mensagens no Chatwoot
4. **Implemente lógica de roteamento** baseada em palavras-chave
5. **Configure backup** dos dados importantes

## 🔒 Segurança

Para uso em produção:
- Mude todas as senhas padrão
- Configure SSL/TLS
- Use um proxy reverso (nginx/traefik)
- Configure firewall adequadamente
- Use secrets management para credenciais

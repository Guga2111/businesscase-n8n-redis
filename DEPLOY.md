# Guia de Deploy - N8N + Redis no Railway

## 📋 Pré-requisitos
- Docker instalado
- Docker Compose (v2+)
- Conta no Railway
- Redis URL (Railway ou outro provider)

---

## 🚀 Deploy Local (Testes)

### 1. Clonar o repositório
```bash
git clone seu-repo
cd businesscase-n8n-redis
```

### 2. Configurar variáveis de ambiente
```bash
cp .env.example .env
# Editar .env com seus valores
```

### 3. Iniciar com Docker Compose
```bash
docker-compose up -d
```

A aplicação estará disponível em `http://localhost:5678`

---

## 🌐 Deploy no Railway

### Opção 1: Usar Docker (RECOMENDADO)

#### 1. Push do código para GitHub
```bash
git add .
git commit -m "feat: add Docker configuration for Railway deployment"
git push origin main
```

#### 2. No painel do Railway
1. **New Project** → **Deploy from GitHub**
2. Selecionar este repositório
3. Railway detectará o `Dockerfile` automaticamente
4. Definir variáveis de ambiente:

```env
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_PROTOCOL=https  # IMPORTANTE: usar HTTPS em produção
NODE_ENV=production
REDIS_URL=<redis-url-do-railway>
OPENAI_API_KEY=<sua-api-key>
```

#### 3. Configurar Redis no Railway
1. **New Service** → **Add Database** → **Redis**
2. Copiar URL do Redis
3. Adicionar como `REDIS_URL` nas variáveis de ambiente

---

### Opção 2: Usar Docker Compose

#### 1. Criar `railway.json`
```json
{
  "build": {
    "builder": "docker",
    "context": "."
  }
}
```

#### 2. Adicionar à variáveis de ambiente do Railway
Mesmo processo que Opção 1, mas Railway usará `docker-compose.yml`

---

## 🔧 Configuração de Variáveis de Ambiente no Railway

| Variável | Valor | Obrigatório |
|----------|-------|-------------|
| `N8N_HOST` | `0.0.0.0` | ✓ |
| `N8N_PORT` | `5678` | ✓ |
| `N8N_PROTOCOL` | `https` | ✓ |
| `NODE_ENV` | `production` | ✓ |
| `REDIS_URL` | URL do Redis | ✓ |
| `OPENAI_API_KEY` | Sua API Key | Se usar chatbot |
| `N8N_LOG_LEVEL` | `info` ou `debug` | |
| `WEBHOOK_URL` | URL pública do Railway | ✓ |

---

## ⚠️ Checklist Pré-Deploy

- [ ] Variáveis de ambiente configuradas no Railway
- [ ] Redis criado e testado
- [ ] Workflows carregados corretamente
- [ ] Credenciais de API (OpenAI) adicionadas
- [ ] URLs de webhook atualizadas (localhost → URL pública)
- [ ] Testes locais passando

---

## 🐛 Troubleshooting

### Erro: "Cannot connect to Redis"
- Verificar se `REDIS_URL` está correto
- Testar conexão: `redis-cli -u <REDIS_URL>`

### Erro: "Workflows not loading"
- Verificar se `/workflows` tem os JSONs
- Ver logs: `docker logs <container-id>`

### Erro: "Port already in use"
- Mudar porta no `.env`
- Ou: `docker-compose down && docker-compose up`

---

## 📊 Monitoramento

Ver logs em tempo real:
```bash
docker-compose logs -f n8n
```

Verificar saúde da aplicação:
```bash
curl http://localhost:5678/healthz
```

---

## 📝 Workflows Ativos

- ✅ **loginFlow** - Autenticação de usuários
- ✅ **CheckPerguntas** - Coleta de respostas
- ✅ **ProxPergunta** - Próxima pergunta
- ✅ **documentosFlow** - Geração de documentos
- ✅ **logsFlow** - Registros de interação

---

## 🔒 Segurança

1. **HTTPS em produção**: Usar `N8N_PROTOCOL=https`
2. **Autenticação básica**: Ativar `N8N_BASIC_AUTH_ACTIVE=true`
3. **Redis com autenticação**: Incluir senha na URL
4. **Firewalls**: Restringir acesso à porta 6379 (Redis)

---

## 📞 Suporte

Para mais informações:
- Docs N8N: https://docs.n8n.io
- Railway Docs: https://docs.railway.app

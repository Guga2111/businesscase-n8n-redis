FROM n8nio/n8n:latest

# Copiar workflows
COPY n8n/workflows /workflows

# Variáveis de ambiente padrão
ENV NODE_ENV=production
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=http
ENV N8N_WORKFLOWS_FOLDER=/workflows
ENV N8N_CORS_ENABLED=true
ENV N8N_CORS_ORIGIN=*
ENV N8N_METRICS=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Expor porta
EXPOSE 5678

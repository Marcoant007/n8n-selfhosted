# Script para iniciar a stack n8n + Chatwoot + Evolution API

Write-Host "Iniciando stack n8n + Chatwoot + Evolution API..." -ForegroundColor Green

# Parar containers existentes
Write-Host "Parando containers existentes..." -ForegroundColor Yellow
docker-compose down

# Iniciar PostgreSQL e Redis primeiro
Write-Host "Iniciando banco de dados..." -ForegroundColor Yellow
docker-compose up -d postgres redis

Write-Host "Aguardando banco inicializar..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Executar migrations do Chatwoot (caso necessário)
Write-Host "Verificando/executando migrations do Chatwoot..." -ForegroundColor Yellow
docker-compose run --rm chatwoot bundle exec rails db:prepare

# Iniciar todos os servicos
Write-Host "Iniciando todos os servicos..." -ForegroundColor Yellow
docker-compose up -d

Write-Host "Aguardando servicos iniciarem..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# Verificar status dos containers
Write-Host "Status dos containers:" -ForegroundColor Cyan
docker-compose ps

Write-Host ""
Write-Host "Stack iniciada! Acesse:" -ForegroundColor Green
Write-Host "Chatwoot: http://localhost:3000" -ForegroundColor White
Write-Host "n8n: http://localhost:5678" -ForegroundColor White  
Write-Host "Evolution API: http://localhost:8080" -ForegroundColor White
Write-Host "PostgreSQL: localhost:5432" -ForegroundColor White
Write-Host "Redis: localhost:6379" -ForegroundColor White

Write-Host ""
Write-Host "Proximos passos:" -ForegroundColor Yellow
Write-Host "1. Configure sua primeira conta no Chatwoot" -ForegroundColor White
Write-Host "2. Configure uma instancia do WhatsApp na Evolution API" -ForegroundColor White
Write-Host "3. Configure os workflows no n8n para conectar tudo" -ForegroundColor White

Write-Host ""
Write-Host "Para verificar logs: docker-compose logs -f [servico]" -ForegroundColor Cyan
Write-Host "Para parar tudo: docker-compose down" -ForegroundColor Cyan

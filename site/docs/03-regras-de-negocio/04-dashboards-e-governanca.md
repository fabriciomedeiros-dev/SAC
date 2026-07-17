---
title: "Épico 4 — Dashboards e Governança"
sidebar_position: 4
---

# Épico 4 — Dashboards e Governança

**Objetivo**: munir a Diretoria e o Operador de Triagem com ferramentas visuais e dados consolidados para avaliar o desempenho da rede.

**Perfis envolvidos**: Operador de Triagem (visão completa) e Diretoria (visão de leitura — ver [Personas e Permissões](../02-personas-e-permissoes/index.md)).

## Regras de negócio

### Mapa de calor geográfico
- Mapa (Google Maps) com todas as lojas da rede, pinos de marcação dinâmicos.
- Cor do pino automática (Verde/Amarelo/Vermelho) baseada na saúde do SLA e no sentimento médio (IA) dos chamados ativos daquela loja.
- Lojas próximas se agrupam em clusters com pouco zoom, desagrupando ao aproximar.
- Ao clicar em um pino: balão com nome do associado, quantidade de chamados em aberto e SLA médio atual.

### Índice de Aceitação
- Score diário calculado para a marca e para cada associado.
- Pondera quatro variáveis: sentimento (IA), cumprimento de SLA, quantidade de reclamações vs. volume de vendas, e — a partir da decisão de 16/07/2026 — a **nota da Pesquisa de Satisfação pós-atendimento** (Épico 6). Peso exato de cada variável na fórmula fica para detalhamento técnico, não é decisão de produto.
- Dashboard exibe "Top 3 Associados" e "Bottom 3 Associados".

### Linha do tempo e auditoria
- Acesso a qualquer chamado com histórico completo de eventos: criação, sugestão da IA, edição pelo operador, envio de resposta, aceite pela loja/associado, pausas de horário comercial, fechamento.
- Registros de auditoria são imutáveis — impossíveis de apagar via interface.
- **Restrito ao Operador de Triagem** (Diretoria não acessa auditoria detalhada por chamado, apenas indicadores agregados).

### Visão da Diretoria
- Acesso somente aos indicadores agregados de performance (índice de aceitação, ranking, mapa de calor).
- Sem acesso a dados de contato de clientes, nem à linha do tempo individual de chamados.

:::info Decisão — 16/07/2026
Diretoria terá conta individual por pessoa (2 logins: André e Danielle) — ver [Personas e Permissões](../02-personas-e-permissoes/index.md).
:::

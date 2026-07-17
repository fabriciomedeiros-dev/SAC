---
title: "Épico 1 — Captura e Inteligência (Ingestão)"
sidebar_position: 1
---

# Épico 1 — Captura e Inteligência (Ingestão)

**Objetivo**: garantir que nenhuma manifestação do cliente seja perdida, centralizando dados de múltiplas fontes, filtrando ruído e aplicando a primeira camada de IA.

**Perfil envolvido**: Operador de Triagem (consulta/gestão da Sandbox). O motor de ingestão é automatizado, sem interface de usuário além do resultado na fila.

## Regras de negócio

### Ingestão e sincronização de fontes
- Captura via API/Scraping de fontes externas (Reclame Aqui, Google, Redes Sociais, e-mail, Aplicativo do Clube) e do Data Lake da SAERJ, no mínimo 2x ao dia (ex.: 08h00 e 13h00).
- Cada ocorrência registrada guarda data, hora, canal de origem e link original.
- Falha temporária em uma fonte não pode travar a captura das demais.
- **Telefone não entra nesta esteira automática** — é sempre registro manual do operador. Ver [Abertura Manual de Chamado](./02-triagem-e-workflow.md#abertura-manual-de-chamado-telefone).

### Filtro de ruído (Sandbox)
- Mensagens curtas, sem contexto, ou identificadas como spam vão para uma área de Sandbox.
- Itens na Sandbox não disparam contagem de SLA.
- Expurgo automático e definitivo após 7 dias exatos da captura.
- Operador de Triagem pode resgatar manualmente um item da Sandbox para a fila principal.

### Triagem assistida por IA
- A IA classifica severidade, mede sentimento e gera rascunho de resposta com base no Manual de Tom de Voz.
- Tags exibidas: Severidade, Sentimento, Tema.
- O rascunho é sempre editável.
- **Regra inegociável**: a IA nunca envia resposta automaticamente. Requer clique humano em "Aprovar e Enviar" pelo Operador de Triagem.

### Agrupamento de ocorrências (deduplicação)
- O sistema cruza CPF, e-mail, telefone ou @usuário e sugere quando uma nova ocorrência parece ser do mesmo cliente de um chamado já aberto.
- Alerta visual de "Possível Duplicidade" — a decisão de mesclar é sempre manual.
- Ao mesclar, o chamado resultante assume a severidade mais alta entre os dois e mantém o histórico de ambas as origens.

:::info Decisão — 16/07/2026
Canal de resposta usado no "Aprovar e Enviar":
- **E-mail, Site e App do Clube**: envio automático via API no momento do clique.
- **Reclame Aqui e Redes Sociais**: sem API de resposta confirmada — o rascunho da IA funciona como sugestão de texto para o Operador **copiar e postar manualmente** na origem, usando o link direto para a postagem (já previsto como item Should Have do MVP).
:::

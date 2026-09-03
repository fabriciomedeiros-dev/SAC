---
title: Escopo do MVP
sidebar_position: 2
---

# Escopo do MVP

## Matriz MoSCoW (herdada do TAP)

| Categoria | Funcionalidades |
|---|---|
| **Must Have** | Núcleo de chamados; Operador de SAC; SLA por severidade; contexto de leitura do Data Lake; canais e-mail, site, App do Clube, telefone, Reclame Aqui e Agência Digital; tratativa/evidência do associado; dashboards definidos do associado. |
| **Should Have** | Sugestão de resposta editável por IA; alerta de duplicidade; resposta manual na origem para Reclame Aqui; cópia por e-mail quando disponível. |
| **Could Have** | Pesquisa de satisfação, exportação de relatórios e pesquisa de opinião no PDV, sujeitos à validação posterior. |
| **Won't Have (nesta fase)** | Google, WhatsApp, BuzzMonitor, respostas automáticas por IA, acesso direto ao CRM/Data Lake, gestão de usuários do associado, contas por loja/jurídico, chat interno e workflow interno do associado. |

## Fora de escopo (confirmado em debate)

- **Processo interno de resolução dentro do associado**: o sistema não modela tarefas, usuários ou chat internos. A conta operacional pode, contudo, registrar uma interação em nome de jurídico ou gerente.
- **Escrita de volta no CRM transacional**: integração é unidirecional (leitura do Data Lake).
- **Login por loja individual**: não haverá conta própria por loja neste MVP — ver decisão de personas.

:::note Rastreabilidade
Como não há login por loja, o log identifica a **conta do associado**. Quando atuar em nome de jurídico ou gerente, a conta registra o participante na interação.
:::

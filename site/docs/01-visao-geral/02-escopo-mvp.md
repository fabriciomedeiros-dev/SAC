---
title: Escopo do MVP
sidebar_position: 2
---

# Escopo do MVP

## Matriz MoSCoW (herdada do TAP)

| Categoria | Funcionalidades |
|---|---|
| **Must Have** | Módulo de Abertura/Gestão de Chamados (workflow completo); Matriz de SLA dinâmica (por severidade/tipo); Módulo de Triagem com IA (classificação e prioridade); Dashboard de acompanhamento em tempo real (SAERJ, Associados e Diretoria); Integração com CRM (identificação por CPF) |
| **Should Have** | Sugestão de resposta amigável via IA para o operador copiar; Link direto para postagem original (redes/Reclame Aqui); Mecanismo de reabertura de chamados pelo operador principal; Pesquisa de satisfação pós-atendimento (nota 1–5, disparo 24h após resolução — ver [Épico 6](../03-regras-de-negocio/06-pesquisa-de-satisfacao.md)) |
| **Could Have** | Histórico de interações sociais vinculado ao perfil CRM; Exportação de relatórios customizados em PDF/Excel; Pesquisa de opinião no PDV — condicionada a validação técnica com fornecedor de PDV/TEF (ver [Épico 7](../03-regras-de-negocio/07-pesquisa-opiniao-pdv.md)) |
| **Won't Have (nesta fase)** | Resposta direta via API na origem (fora do escopo); App mobile dedicado (uso via Web Responsivo); Notificação ativa de SLA por e-mail/in-app (cobrança é só visual, via semáforo — decisão de 16/07/2026, ver [Triagem e Workflow](../03-regras-de-negocio/02-triagem-e-workflow.md)) |

## Fora de escopo (confirmado em debate)

- **Processo interno de resolução dentro do associado**: o sistema não modela quem, dentro do escritório do associado, efetivamente atendeu o chamado — apenas que a conta do associado registrou a resolução. Ver [Personas e Permissões](../02-personas-e-permissoes/index.md).
- **Escrita de volta no CRM transacional**: integração é unidirecional (leitura do Data Lake).
- **Login por loja individual**: não haverá conta própria por loja neste MVP — ver decisão de personas.

:::note Rastreabilidade
Como não há login por loja nem registro de nome do atendente, o log de auditoria identifica a **conta do associado**, não a pessoa ou loja específica que tratou o chamado. Trade-off aceito explicitamente para o MVP.
:::


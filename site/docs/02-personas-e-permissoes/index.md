---
title: Matriz de Personas
sidebar_position: 1
---

# Personas e Permissões

O controle de usuários (autenticação, sessão, grupos) usa a infraestrutura nativa do Django — não é detalhado nesta documentação. Aqui definimos apenas **quem são os perfis de negócio** e **o que cada um pode ver e fazer**.

## Perfis confirmados

### 1. Associado

- **Quantidade de contas**: 11 (uma por associado, não por loja) — ver lista nominal em [Administração](../03-regras-de-negocio/05-administracao.md#cadastro-de-associados).
- **Representa**: o escritório central do associado, responsável por todas as lojas vinculadas a ele.
- **Acesso**: Portal do Associado.

### 2. Atendente Telefônico

- **Representa**: pessoa da SAERJ dedicada exclusivamente ao atendimento por telefone.
- **Acesso**: apenas a tela de [Abertura Manual de Chamado](../03-regras-de-negocio/02-triagem-e-workflow.md#abertura-manual-de-chamado-telefone) — busca no CRM, cadastro do cliente quando não encontrado, registro do resumo da ligação.
- **Não acessa**: fila de triagem geral, dashboards, cadastro, aprovação de respostas de outros canais.
- **Motivo da separação**: quem atende telefone precisa estar disponível para a ligação em tempo real; misturar essa função com o monitoramento da fila e cobrança de SLA competiria pela atenção da mesma pessoa. Papel isolado por decisão de 13/07/2026.

### 3. Operador de Triagem

- **Representa**: equipe operacional da SAERJ responsável pelo dia a dia do SAC — é o **usuário principal da ferramenta**.
- **Acesso**: Painel de Triagem e Workflow (fila, aprovação de respostas de IA, atribuição a associados, acompanhamento/cobrança de SLA), Sandbox, Cadastro (Associados/Lojas/SLA), Dashboards de Governança.
- **Responsabilidades centrais**: monitorar as atividades, encaminhar chamados, cobrar resolução dentro do prazo, e revisar/aprovar toda resposta que sai para o cliente (nenhuma resposta é enviada sem passar por este perfil, exceto o resumo registrado pelo Atendente Telefônico durante a ligação).

### 4. Diretoria

- **Representa**: patrocinadores do projeto — André Legey (CEO) e Danielle Moitas (Marketing).
- **Acesso**: somente o Dashboard de performance de atendimento, em modo leitura.

## Matriz de permissões

| Ação | Associado | Atendente Telefônico | Operador de Triagem | Diretoria |
|---|:---:|:---:|:---:|:---:|
| Abrir chamado manual (telefone) | ❌ | ✅ | ❌ | ❌ |
| Cadastrar associados / lojas | ❌ | ❌ | ✅ | ❌ |
| Definir regras de SLA (severidade → prazo) | ❌ | ❌ | ✅ | ❌ |
| Ver fila de triagem (chamados não atribuídos) | ❌ | ❌ | ✅ | ❌ |
| Revisar/aprovar resposta sugerida pela IA | ❌ | ❌ | ✅ | ❌ |
| Atribuir chamado a um associado (dispara SLA) | ❌ | ❌ | ✅ | ❌ |
| Ver chamados das próprias lojas | ✅ | ❌ | ❌ | ❌ |
| Ver chamados de todos os associados | ❌ | ❌ | ✅ | ❌ |
| Assumir chamado (desbloqueia dados LGPD do cliente) | ✅ (próprio) | ❌ | — | ❌ |
| Ver dados financeiros/comportamentais do CRM (ticket médio, frequência) | ❌ | ❌ | ✅ | ❌ (só agregado) |
| Buscar cliente no CRM (CPF/telefone/nome) | ❌ | ✅ | ✅ | ❌ |
| Registrar resolução com evidência obrigatória | ✅ | ❌ | ❌ | ❌ |
| Solicitar transferência de custódia para outro associado | ✅ | ❌ | ✅ | ❌ |
| Ver dashboards de governança (mapa de calor, índice de aceitação) | ❌ | ❌ | ✅ | ✅ (leitura) |
| Ver linha do tempo / auditoria de um chamado | ❌ | ❌ | ✅ | ❌ |

## Regra de reatribuição dentro do mesmo associado

Como uma única conta gerencia todas as lojas de um associado, mover um chamado de uma loja para outra **do mesmo associado** é uma reclassificação direta, sem fluxo de aceite (a mesma conta já enxerga as duas filas). O fluxo formal de **transferência de custódia** (com aceite explícito e SLA que continua contando com o remetente até a confirmação) só existe quando o destino é **outro associado**.

## Rastreabilidade (trade-off aceito)

O log de auditoria registra a conta do associado que executou a ação (ex.: quem assumiu o chamado, quem redirecionou), não a pessoa física ou loja específica dentro do escritório do associado. Ver [Escopo do MVP](../01-visao-geral/02-escopo-mvp.md).

:::info Decisões — 16/07/2026
- **Parametrização de SLA**: fica com o mesmo Operador de Triagem, sem sub-perfil "gestor" separado neste MVP. Revisitar apenas se surgir necessidade real de segregação de responsabilidade após o Go-Live.
- **Diretoria**: conta individual por pessoa (André e Danielle) — não é acesso compartilhado. Permite auditoria de quem acessou o quê.
- **Múltiplas contas por papel**: o sistema suporta mais de um Atendente Telefônico e mais de um Operador de Triagem logados simultaneamente (múltiplas contas no mesmo grupo). Ver [regra de concorrência](../03-regras-de-negocio/02-triagem-e-workflow.md#concorrência-entre-operadores).
:::

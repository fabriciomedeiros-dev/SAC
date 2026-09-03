---
title: Matriz de Personas
sidebar_position: 1
---

# Personas e Permissões

O controle de usuários usa a infraestrutura nativa do Django. A matriz abaixo define os perfis de negócio do MVP.

## Perfis confirmados

### 1. Associado

- **Quantidade de contas**: uma conta operacional por associado; não há login por loja, jurídico ou gerente, nem gestão de usuários pelo associado no MVP.
- **Acesso**: Portal do Associado, limitado às lojas vinculadas.
- **Responsabilidade**: registrar interações e finalizar o chamado com ação tomada, resposta/canal/data e anexos quando a natureza exigir.

### 2. Operador de SAC

- **Representa**: a equipe operacional da SAERJ. Unifica as antigas funções de atendimento telefônico e triagem em um único painel.
- **Acesso**: abertura manual por telefone, caixa de entrada, dados contextuais do Data Lake dentro do SAC, triagem, contato com cliente, atribuição, cobrança de SLA, Sandbox, administração e dashboards de governança.
- **CRM contextual**: consulta os dados enriquecidos no SAC; não acessa diretamente o CRM/Data Lake.
- **Concorrência**: podem existir múltiplos operadores, mas um chamado fica bloqueado exclusivamente enquanto um operador o trata.

### 3. Agência Digital

- **Acesso**: abrir chamados críticos diretamente na ferramenta.
- **Restrições**: não acessa CRM/Data Lake, fila, SLA, dashboards ou chamados de terceiros.

### 4. Diretoria

- **Acesso**: indicadores agregados em modo leitura, sem dados de contato de clientes ou linha do tempo individual.

## Matriz de permissões

| Ação | Associado | Operador de SAC | Agência Digital | Diretoria |
|---|:---:|:---:|:---:|:---:|
| Abrir chamado manual por telefone | ❌ | ✅ | ❌ | ❌ |
| Abrir chamado crítico | ❌ | ✅ | ✅ | ❌ |
| Consultar contexto do Data Lake no SAC | ❌ | ✅ | ❌ | ❌ |
| Triar, revisar resposta e atribuir associado | ❌ | ✅ | ❌ | ❌ |
| Contatar o cliente antes do direcionamento | ❌ | ✅ | ❌ | ❌ |
| Acompanhar e cobrar SLA | ❌ | ✅ | ❌ | ❌ |
| Registrar interação e finalizar com evidência | ✅ | ❌ | ❌ | ❌ |
| Corrigir loja no mesmo associado | ✅ | ✅ | ❌ | ❌ |
| Redirecionar para outro associado | ✅ | ✅ | ❌ | ❌ |
| Ver dashboard próprio | ✅ | ❌ | ❌ | ❌ |
| Ver dashboards de governança | ❌ | ✅ | ❌ | ✅ |
| Ver linha do tempo do chamado | Próprios | ✅ | Próprios abertos | ❌ |

## Regras de custódia e rastreabilidade

- Trocar a loja dentro do mesmo associado é correção direta.
- Redirecionar para outro associado inicia um novo ciclo de SLA para o destino e preserva todos os ciclos e eventos anteriores.
- O histórico é imutável e registra a conta que executou a ação. A conta do associado pode registrar interações em nome de jurídico ou gerente, identificando o participante na própria interação.

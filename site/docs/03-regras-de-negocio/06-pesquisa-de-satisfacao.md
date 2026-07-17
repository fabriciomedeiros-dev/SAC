---
title: "Épico 6 — Pesquisa de Satisfação Pós-Atendimento (novo, fora do TAP original)"
sidebar_position: 6
---

# Épico 6 — Pesquisa de Satisfação Pós-Atendimento

:::note Origem
Não constava no TAP nem na matriz MoSCoW original. Adicionado por decisão de 13/07/2026: após um período do atendimento, o sistema deve perguntar ao cliente como foi o atendimento e registrar a resposta.
:::

**Objetivo**: capturar a percepção do cliente após a resolução do chamado, gerando um dado de satisfação que hoje não existe no fluxo (a IA mede sentimento na *entrada* da manifestação, não depois da resolução).

**Perfil envolvido**: Operador de Triagem (consulta dos resultados na rede toda) e Associado (consulta restrita às próprias lojas); envio é automatizado, sem interface de usuário para disparo manual.

:::info Classificação MoSCoW — decisão 16/07/2026
Entra no MVP como **Should Have** (ver [Escopo do MVP](../01-visao-geral/02-escopo-mvp.md)). O épico era considerado risco de escopo por ter sido adicionado após o cronograma já pressionado, mas com as regras abaixo fechadas o esforço fica previsível o suficiente para entrar na priorização.
:::

## Regras de negócio

### Disparo da pesquisa
- Enviada **24 horas após o chamado ser marcado como "Resolvido"** — prazo fixo, igual para todas as severidades.
- Canal de envio: **canal único padrão** (e-mail / App do Clube), independente do canal de origem da manifestação. Reclame Aqui e redes sociais não têm API de resposta confirmada (ver [Épico 1](./01-ingestao-e-inteligencia.md)), então não é possível reabrir contato por lá dias depois.

### Formato da pergunta
- Nota simples de **1 a 5**. Sem NPS, sem texto livre obrigatório — prioriza taxa de resposta e simplicidade de leitura no dashboard.

### Uso do resultado
- A nota passa a compor o **Índice de Aceitação** (Épico 4), junto com sentimento (IA), cumprimento de SLA e volume de reclamações vs. vendas — ver fórmula atualizada em [Dashboards e Governança](./04-dashboards-e-governanca.md).
- Nota baixa **não** dispara nenhuma ação automática (não gera chamado novo) — funciona só como indicador nos dashboards de governança neste MVP.

### Visibilidade
- **Operador de Triagem**: vê a nota agregada de todos os associados.
- **Associado**: vê a nota média das próprias lojas, como incentivo de melhoria (ver [Portal do Associado](./03-portal-do-associado.md)). Não vê a nota de outros associados.
- **Diretoria**: vê a nota agregada da rede, dentro do Índice de Aceitação — mesmo nível de acesso que já tinha para os demais indicadores.

:::caution Pendente
- Texto exato da pergunta enviada ao cliente e template do canal de envio (copy) — detalhamento de conteúdo, não bloqueia navegação/telas.
:::

---
title: "Épico 2 — Triagem e Gestão de Chamados (Workflow Core)"
sidebar_position: 2
---
 
# Épico 2 — Triagem e Gestão de Chamados (Workflow Core)

**Objetivo**: fornecer à SAERJ o painel de controle central para rotear chamados, acionar prazos dinâmicos e monitorar visualmente o cumprimento dos SLAs.

**Perfis envolvidos**: Atendente Telefônico (abertura manual) e Operador de Triagem (todo o restante do épico).

## Regras de negócio

<a id="abertura-manual-de-chamado-telefone"></a>
### Abertura Manual de Chamado (Telefone)
**Perfil: Atendente Telefônico**
- Canal exclusivo para atendimento por telefone — não passa pela esteira automática de captura do [Épico 1](./01-ingestao-e-inteligencia.md).
- O Atendente Telefônico coleta as informações necessárias diretamente com o cliente durante a ligação.
- **Busca do cliente no CRM**, por ordem de preferência: CPF (preferencial) → telefone → nome.
  - Se a busca por CPF ou telefone retornar exatamente um resultado, os dados existentes são preenchidos automaticamente.
  - Busca só por nome pode retornar mais de um resultado (nomes comuns) — nesse caso o sistema deve listar os candidatos e exigir que o operador confirme manualmente qual cliente é, em vez de vincular automaticamente.
  - Se o cliente não for encontrado, o operador cadastra manualmente os dados mínimos necessários para abrir o chamado.
- **Registro obrigatório da comunicação**: o atendente preenche um campo de texto obrigatório (mínimo 50 caracteres — decisão de 16/07/2026) com o resumo do que foi informado/combinado com o cliente durante a ligação. Esse texto é o **registro oficial da interação** — não é substituído pela transcrição automática abaixo, é o que garante o registro mesmo se a transcrição falhar ou atrasar.
- A partir daqui, o chamado segue o mesmo fluxo dos demais canais: classificação de severidade, atribuição ao associado e disparo de SLA — já sob responsabilidade do Operador de Triagem, não mais do Atendente Telefônico.

<a id="transcricao-automatica-da-ligacao"></a>
### Transcrição e resumo automático da ligação
:::info Arquitetura e decisões — 17/07/2026
A SAERJ já possui um PABX **Grandstream UCM6204** com servidor de gravação de chamadas nativo. Pipeline para enriquecer o chamado telefônico automaticamente, **sem substituir** o resumo manual do atendente:

```
Ligação
  → UCM6204 grava automaticamente (arquivo WAV, retido nativamente por 30 dias)
  → Serviço monitora a pasta de gravações
  → Whisper (API OpenAI) transcreve o áudio
  → Prompt de IA gera resumo, classificação (severidade/sentimento/tema) e mantém a transcrição completa
  → Anexado ao chamado: resumo IA, transcrição completa, tags sugeridas e link para o áudio — visível na Linha do Tempo e no painel de Cliente/CRM
```

- **Correlação com o chamado**: por ramal do atendente + horário de início da ligação (o atendente já está logado no SAC quando atende).
- **Transcrição via API da OpenAI (nuvem)** — decisão de negócio, ciente da implicação de LGPD (dado pessoal de reclamação trafegando para terceiro). Requer aviso de gravação ao cliente na ligação.
- **Retenção do áudio**: o UCM6204 retém nativamente por **30 dias** em memória interna — esse é o comportamento técnico padrão do equipamento, não uma escolha do SAC. A confirmação formal do protocolo de retenção/descarte (se 30 dias é suficiente, se precisa de cópia externa) **segue pendente de validação jurídica/compliance**.
- **Resumo manual do atendente permanece obrigatório e é o registro oficial imediato** — a transcrição e a classificação por IA chegam depois, de forma assíncrona, como **enriquecimento**. Se a transcrição falhar ou atrasar, nada quebra: o resumo manual já garantiu o registro.
- **Classificação (severidade/sentimento/tema)**: gerada pelo mesmo prompt que resume a ligação. Não existe um passo manual de "o operador volta depois para classificar" — o que existe é: se a classificação da IA já chegou quando o Operador abre o chamado na Fila de Triagem, as tags aparecem pré-preenchidas (igual aos demais canais do [Épico 1](./01-ingestao-e-inteligencia.md), sempre editáveis); se ainda não chegou, o Operador classifica manualmente como hoje, e o enriquecimento (resumo IA, transcrição completa, áudio) aparece depois no chamado sem exigir nenhuma ação de reclassificação.
- **No Detalhe do Chamado**, o Operador tem acesso a: resumo gerado pela IA, opção de ver a transcrição completa, e ouvir o áudio da ligação quando disponível.
:::

:::caution Pendente
- Confirmação formal do protocolo de retenção/descarte do áudio com jurídico/compliance (ver acima — o prazo técnico de 30 dias do PABX não é necessariamente o prazo de política definitivo).
:::

### Painel de fila de trabalho
**Perfil: Operador de Triagem**
- Lista centralizada de ocorrências pendentes, em formato de lista/tabela ordenável.
- Filtros de seleção múltipla por Fonte, Severidade sugerida e Data.

<a id="vinculo-crm-por-cpf"></a>
### Vínculo com o CRM por CPF (visão do Operador)
:::info Decisão — 16/07/2026
O CPF é a **chave de vínculo** entre a manifestação e o cadastro do cliente no CRM/Data Lake — reforça o Must Have "Integração com CRM (identificação por CPF)" já presente no [Escopo do MVP](../01-visao-geral/02-escopo-mvp.md).
:::
- **Quando há CPF identificado** (informado pelo próprio canal, ou resolvido por telefone/e-mail/@usuário na deduplicação, ou confirmado manualmente pelo Atendente/Operador), o Detalhe do Chamado busca automaticamente no CRM e exibe, num painel dedicado:
  - Nome completo e CPF do cliente.
  - **Dados de comportamento de compra**: ticket médio e frequência de compras na rede — exclusivo do Operador de Triagem (Associado não vê, Diretoria só vê agregado — ver [Personas e Permissões](../02-personas-e-permissoes/index.md)).
  - **Outras reclamações do mesmo cliente**: lista de chamados anteriores desse CPF em **qualquer canal, loja ou associado** da rede, com data, tema e status — não só chamados relacionados ao caso atual. Cada item da lista abre o respectivo chamado.
- **Quando não há CPF identificado** (comum em Redes Sociais e Reclame Aqui, que não pedem CPF na origem): painel mostra "Cliente não identificado no CRM" até uma correspondência manual do Operador.
- Este painel é mais amplo que a **Visão 360°** do Portal do Associado (Épico 3), que mostra só o histórico de chamados do cliente, sem dado financeiro/comportamental.

### Atribuição e disparo de SLA
- Operador de Triagem seleciona o **associado** responsável (não mais "loja", já que o login é por associado — ver [Personas e Permissões](../02-personas-e-permissoes/index.md)) e confirma a abertura do chamado.
- Ao confirmar, o status muda para "Encaminhado" e o cronômetro de SLA inicia oficialmente.
- O cliente recebe a resposta inicial (aprovada no Épico 1) neste momento.
- Cada chamado carrega a tag da **loja de origem** (identificada nos dados capturados) mesmo que a conta responsável seja a do associado — isso permite ao associado filtrar seus chamados por loja internamente.

### Cronômetro de SLA dinâmico (semáforo)
- Prazos por severidade (sugestão do TAP, a validar): Perecíveis/Vencidos 8h · Higiene/Limpeza 24h · Falta de Produto 48h · Geral/Elogios 72h.
- A contagem pausa fora do horário comercial (ex.: pausa às 18h, retoma às 08h do dia útil seguinte).
- Cores do card: Verde (dentro do prazo) · Amarelo (próximo do vencimento, ex.: 2h restantes) · Vermelho (SLA estourado).

### Acompanhamento e cobrança de chamados encaminhados
- Além da fila de entrada (chamados ainda não atribuídos), o Operador de Triagem tem uma visão dos chamados já **"Encaminhados"**, ordenável por proximidade do vencimento do SLA — é a partir dela que o Operador cobra a resolução.
- O semáforo (verde/amarelo/vermelho) é o **único** sinal de cobrança nesta versão — decisão de 16/07/2026 fechou notificação ativa (e-mail/in-app) como Won't Have nesta fase. Não há disparo automático de lembrete; a cobrança depende do Operador consultar a tela.

### Transferência de custódia (redirecionamento)
Regra revista em relação ao TAP original, por conta do login ser por associado:

- **Loja errada dentro do mesmo associado**: reclassificação direta da tag de loja no chamado, sem necessidade de aceite (a mesma conta já enxerga todas as suas lojas).
- **Chamado pertence a outro associado**: fluxo formal de transferência —
  1. O associado atual seleciona o associado correto de destino.
  2. O chamado permanece no painel do associado atual e o SLA continua contando até a confirmação.
  3. O associado de destino precisa clicar em "Aceitar Transferência".
  4. A alteração fica registrada no log de histórico do chamado.

<a id="concorrência-entre-operadores"></a>
:::info Decisões — 16/07/2026
- **Concorrência entre operadores**: lock *soft*. Ao abrir um chamado, o sistema marca "em análise por [nome do operador]" para quem mais olhar a fila — não bloqueia a ação, só avisa. Suficiente para o volume esperado no MVP; um lock rígido pode ser avaliado depois se virar problema real.
- **Notificações ativas de SLA (e-mail/in-app)**: **Won't Have nesta fase** — não consta na matriz MoSCoW e o semáforo visual já é o mecanismo de cobrança assumido. A ação de "cobrar associado" continua sendo o Operador olhar a tela de Encaminhados, sem lembrete automático.
- **Tamanho mínimo do "resumo da comunicação"** na abertura manual: 50 caracteres — mesmo valor usado no encerramento do Associado (ver [Portal do Associado](./03-portal-do-associado.md)), por consistência.
:::

:::note Fora de escopo (confirmado)
Transcrição automática da ligação telefônica não está no MVP — pode ser avaliada em fase futura.
:::

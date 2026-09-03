---
title: "Épico 3 — Portal do Associado"
sidebar_position: 3
---

# Épico 3 — Portal do Associado

**Objetivo**: ambiente web restrito e simplificado para os 11 associados operarem, com foco em tratativa rápida, segurança jurídica (LGPD) e registro de evidências.

**Perfil envolvido**: Associado.

## Regras de negócio

<a id="organização-da-tela-de-detalhe"></a>
### Organização da tela de Detalhe do Chamado
Gap identificado: a tela misturava informação objetiva do chamado (status, prazo, SLA), dado sensível do cliente e histórico de apoio num único bloco, dificultando a leitura rápida pelo associado. A tela passa a usar um layout em duas colunas (ver [Fluxo — Associado](../04-fluxos-de-navegacao/03-associado.md#2-detalhe-do-chamado--organização-da-tela)):

**Coluna central (principal) — interações do chamado**, em ordem cronológica:
- Linha do Tempo/Histórico: consolida abertura, atribuição, transferências e notas de andamento — é consulta e registro de auditoria, não dado de status isolado.
- Notas de andamento: campo onde o associado registra tratativas intermediárias.
- Ação Corretiva + botão "Resolver": ficam no final desta coluna, como o encerramento da interação, não como um bloco de status separado.

**Coluna lateral (à direita) — informações de apoio**, sem interação direta, em dois blocos empilhados:
1. **Status do Chamado** — sem dado sensível do cliente, sempre visível independente do modo (Pendente/Em Atendimento):
   - Número do chamado.
   - Canal de origem (Aberto via).
   - Data/hora de abertura.
   - Status/etapa atual (ex.: "Em Atendimento", "Na fila de atendimento").
   - Vencimento do SLA, com o mesmo semáforo verde/amarelo/vermelho da Fila (ver [Cronômetro de SLA dinâmico](./02-triagem-e-workflow.md#cronometro-de-sla-dinamico-semaforo)) — destaque visual claro quando fora do prazo.
   - Data/hora de resolução, quando já resolvido.
   - Reaberturas: quantidade e, quando aplicável, link para o chamado vinculado (ver [Reabertura de chamados](./02-triagem-e-workflow.md#reabertura-de-chamados)).
   - Tempo de vida do chamado, em horas corridas e em horas úteis (consistente com a pausa do cronômetro de SLA fora do horário comercial).
   - Botões de custódia **"Assumir Chamado"** e **"Solicitar Transferência"** ficam junto deste bloco — são ações sobre o chamado como um todo, não parte da conversa central.
2. **Dados do Cliente + Visão 360º** — dado sensível, sujeito à ofuscação/minimização já definida abaixo.

:::note Decisão
Não existe um status "Fechado" distinto de "Resolvido" neste MVP — diferente de outras ferramentas de mercado que separam "resolvido" (tratativa feita) de "fechado" (validado/encerrado depois). Aqui, "Resolver" já é o encerramento definitivo: o SLA para permanentemente e não há etapa posterior de validação/fechamento. Por isso o bloco de Status mostra apenas "Resolvido em", sem um campo "Fechado em" equivalente.
:::

### Aceite e desbloqueio de dados (LGPD)
- Antes do aceite, dados de contato do cliente aparecem ofuscados (ex.: `joao.***@gmail.com`, `(21) 9****-1234`).
- Ao clicar em "Assumir Chamado", o status muda para "Em Atendimento" e o sistema libera **apenas os dados estritamente necessários** para o associado entrar em contato e resolver o caso — princípio de minimização de dados (LGPD), não liberação total do cadastro do cliente.
- O log de auditoria registra qual **conta de associado** desbloqueou os dados e o timestamp — não identifica a pessoa física dentro do escritório do associado (ver [Escopo do MVP](../01-visao-geral/02-escopo-mvp.md)).

:::info Decisão — 16/07/2026 — campos liberados ao assumir
- **Sempre visível após assumir**: nome do cliente e **telefone** — é o meio universal de contato para resolver o caso, independente de como a manifestação chegou.
- **Condicional**: **e-mail** só é liberado quando o canal de origem da manifestação for e-mail.
- **Nunca visível ao associado**: CPF completo (fica só como chave interna de cruzamento no CRM/SAERJ — a Visão 360º já funciona sem exibir o CPF em tela).
:::

### Visão 360° do cliente
- Lista de cards resumidos de chamados anteriores do mesmo cliente (por CPF/e-mail) em toda a rede Supermarket.
- Dados financeiros/comportamentais do CRM (ticket médio, frequência) **não aparecem** aqui — são exclusivos do Operador de Triagem.

### Registro de tratamento interno
- Enquanto o chamado está "Em Atendimento", o associado pode adicionar **notas de andamento** (ex.: "produto já recolhido da gôndola", "cliente contatado às 14h, aguardando retorno").
- Cada nota fica registrada com data/hora na linha do tempo do chamado (Épico 4) — visível também ao Operador de Triagem, que usa isso para acompanhar se o associado está de fato trabalhando no caso antes de cobrar.
- Não substitui o campo obrigatório de "Ação Corretiva" no encerramento — são registros intermediários, o encerramento exige o resumo final.

### Encerramento com evidência obrigatória
- O botão "Resolver" só habilita se o campo "Ação Corretiva" tiver o mínimo de **50 caracteres** (confirmado em 16/07/2026, conforme sugestão do TAP).
- Permite anexar arquivos (PDF/imagens) como evidência.
- Ao confirmar, o cronômetro do SLA é interrompido permanentemente.

### Chamados em atraso — destaque obrigatório
- Chamados com SLA estourado (vermelho) devem se destacar visualmente na fila do associado (ex.: ordenados no topo, cor de alerta, contador de "X chamados em atraso" visível assim que o associado loga).
- Objetivo: pressionar o associado a finalizar chamados parados, não só informar — o atraso não pode ficar "escondido" numa lista comum.

### Chamados resolvidos (histórico)
:::info Decisão — 17/07/2026
Gap identificado: a fila principal do associado só mostrava chamados em aberto — depois de "Resolver", o chamado simplesmente desaparecia da visão dele, sem nenhum lugar para consultar depois (ex.: conferir a Ação Corretiva que ele mesmo registrou).
:::
- O Portal do Associado tem uma aba **"Resolvidos"**, com os chamados já concluídos das próprias lojas — somente leitura (Ação Corretiva, evidência anexada, data de resolução).
- O associado **não pode reabrir** — reabertura é [ação exclusiva do Operador de Triagem](./02-triagem-e-workflow.md#reabertura-de-chamados). Se o cliente reclamar de novo, o associado orienta o contato pelo canal de origem, que o Operador trata como reabertura.

### Chamados de múltiplas lojas
- Como o login é por associado, a fila do Portal exibe chamados de **todas as lojas vinculadas** a esse associado, com filtro por loja.
- Mover um chamado entre lojas do mesmo associado é reclassificação direta (ver [Triagem e Workflow](./02-triagem-e-workflow.md)).

### Transferência de custódia (visão do associado)
- Quando o chamado pertence a outro associado, o associado atual pode solicitar a transferência.
- O chamado e o SLA continuam sob responsabilidade do associado atual até que o associado de destino aceite.

### Nota de satisfação da própria loja
- O associado vê a nota média de satisfação (Épico 6) das próprias lojas — decisão de 16/07/2026, pensada como incentivo de melhoria contínua.
- Não vê a nota de outros associados (isso é privativo do Operador de Triagem e da Diretoria, nos Dashboards de Governança).

:::note Fora de escopo (confirmado)
Processo interno de resolução dentro do associado (quem, na prática, atende) não é modelado neste MVP.
:::

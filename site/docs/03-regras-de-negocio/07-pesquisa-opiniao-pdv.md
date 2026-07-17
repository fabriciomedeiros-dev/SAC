---
title: "Épico 7 — Pesquisa de Opinião no PDV (novo, fora do TAP original)"
sidebar_position: 7
---

# Épico 7 — Pesquisa de Opinião no PDV

:::note Origem
Não constava no TAP nem na matriz MoSCoW original. Adicionado por decisão de 16/07/2026: o pinpad do PDV, na finalização da compra, pode coletar uma pesquisa de opinião rápida, vinculada por CPF e cupom fiscal ao CRM.
:::

**Objetivo**: capturar um sinal de satisfação sobre a **experiência geral de compra**, no momento em que ela acontece — diferente do [Épico 6](./06-pesquisa-de-satisfacao.md), que mede a satisfação **pós-resolução de um chamado específico**. São duas fontes de dado independentes, com propósitos diferentes.

**Perfil envolvido**: Operador de Triagem e Associado (consulta do painel de avaliação); captura é automatizada pelo PDV, sem interface de usuário do SAC para disparo.

:::info Classificação MoSCoW — decisão 16/07/2026
Entra como **Could Have**: valioso, mas depende de uma integração técnica ainda não validada (ver risco abaixo). Não compromete sprint do MVP até essa validação acontecer.
:::

## Regras de negócio

### Captura no pinpad
- Na finalização da compra, o pinpad do PDV pode apresentar uma pesquisa de opinião rápida ao cliente.
- **Disparo e amostragem (quando aparece, para quem, com que frequência) são regras do próprio PDV/TEF** — o SAC não controla nem parametriza isso, apenas recebe o resultado quando ele existe.
- O vínculo com o CRM é feito por **CPF informado no cupom fiscal** — só existe pesquisa vinculável quando o cliente informa CPF na nota (prática já comum na rede).

### Vínculo com o CRM e uso do resultado
- Quando o CPF do cupom corresponde a um cliente já identificado no CRM, a nota fica anexada ao perfil desse cliente — visível junto com o histórico de reclamações no [painel de Cliente (CRM)](./02-triagem-e-workflow.md#vinculo-crm-por-cpf) do Operador.
- Agregado por loja, alimenta um **Painel de Avaliação de Loja** próprio (Dashboards de Governança) — **não entra na fórmula do Índice de Aceitação** do Épico 4, que já pondera a nota pós-atendimento do Épico 6. Mistura as duas neste momento arriscaria confundir "satisfação com a compra" com "satisfação com a resolução de um problema".
- **Nota baixa não gera chamado automático** — mesma lógica já fechada no Épico 6: funciona só como indicador, sem disparar fluxo novo.

### Visibilidade
- **Operador de Triagem**: painel de avaliação de todas as lojas da rede.
- **Associado**: painel de avaliação restrito às próprias lojas.
- **Diretoria**: indicador agregado por associado/região, dentro dos Dashboards de Governança — mesmo padrão de acesso já usado para os demais indicadores.

:::caution Risco — dependência técnica declarada
Integração com o pinpad/TEF da rede **ainda não foi validada com o fornecedor de PDV** — não há confirmação de que dá para capturar CPF + cupom fiscal + nota e enviar esse dado ao SAC. Enquanto isso não for validado, este épico fica com esforço não estimável e não deve ser comprometido em sprint. Ver classificação MoSCoW acima.
:::

:::caution Pendente
- Formato exato da nota (segue o mesmo 1–5 do Épico 6, ou é definido pelo fornecedor do PDV/TEF?).
- Layout e métricas exatas do "Painel de Avaliação de Loja" — depende de volume real de dados recebidos do PDV, que só se conhece após a validação técnica acima.
:::

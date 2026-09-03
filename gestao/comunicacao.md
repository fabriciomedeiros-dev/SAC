# Matriz de Comunicação do Projeto SAC

## Contatos de referência

| Pessoa | Papel | E-mail |
| --- | --- | --- |
| Danielle Moitas | Decisão de escopo | daniellemoitas@redesupermarket.com.br |
| Marcelo Rebelo | Orçamento e prioridade | marcelorebelo@redesupermarket.com.br |
| Alexandro Nascimento | Desenvolvimento | alexandro.nascimento@redesupermarket.com.br |
| Filipe Fachetti | Análise, dados e regras | filipe.fachetti@redesupermarket.com.br |
| Fabrício | Planejamento e execução | A definir |

## Matriz

| Comunicação | Gatilho/cadência | Responsável | Destinatários | Conteúdo mínimo |
| --- | --- | --- | --- | --- |
| Status executivo | Semanal, durante o desenvolvimento | Fabrício | Danielle e Marcelo; cópia para Alexandro e Filipe | Fase, progresso, próximos passos, riscos, dependências e decisões requeridas. |
| Status operacional | Semanal ou após reunião de trabalho | Fabrício | Alexandro e Filipe | Entregas, responsáveis, prazos, impedimentos e critérios de aceite. |
| Decisão de escopo | Sempre que houver alteração de MVP, requisito ou prioridade | Fabrício | Danielle | Contexto, opções, impacto, recomendação e decisão solicitada. |
| Alerta de custo/prioridade | Risco de orçamento, fornecedor ou prazo externo | Fabrício | Marcelo; cópia para Danielle | Dependência, custo/prazo, impacto e encaminhamento necessário. |
| Alerta técnico | Bloqueio de integração, ambiente ou desenvolvimento | Alexandro | Fabrício e Filipe; cópia para Marcelo se envolver custo | Descrição, impacto, alternativas e decisão/prazo necessários. |
| Validação de dados/regra | Ambiguidade ou mudança em dados e regra funcional | Filipe | Fabrício; Danielle quando alterar escopo | Regra afetada, evidência, impacto e proposta. |
| Marco e aceite | Conclusão de fase, MVP ou homologação | Fabrício | Equipe e patrocinadores | Evidências, escopo entregue, pendências e aceite solicitado. |
| Prontidão de Go-Live | Após a homologação | Fabrício | Danielle, Marcelo, Alexandro e Filipe | Resultado dos testes, riscos residuais e recomendação de autorização. |

## Regras de envio

- Fabrício consolida e envia as comunicações de status e marcos.
- Notificações de bloqueio são enviadas assim que identificadas; não aguardam o status semanal.
- Decisões de escopo só são consideradas vigentes após retorno de Danielle.
- Custos, fornecedores e priorização que precisem de patrocínio são encaminhados a Marcelo.
- O histórico de decisões e o status vigente devem ser atualizados em `gestao/` antes do envio de um marco ou status executivo.

## Modelos de assunto

- `[SAC][Status semanal] AAAA-MM-DD — fase e semáforo`
- `[SAC][Decisão de escopo] assunto — decisão solicitada até DD/MM`
- `[SAC][Bloqueio] dependência — impacto e encaminhamento`
- `[SAC][Marco] entrega — aceite solicitado`
- `[SAC][Go-Live] prontidão — recomendação de autorização`

## Modelo de status executivo

```text
Assunto: [SAC][Status semanal] AAAA-MM-DD — fase e semáforo

Fase atual:
Progresso desde o último status:
Próximos passos:
Riscos e dependências:
Decisões necessárias (responsável e data):
```

## Habilitação de envio

Esta matriz define destinatários e gatilhos. Para enviar e-mails pelo sistema, ainda será necessário escolher e configurar o serviço de entrega, credenciais, remetente autorizado e regra de aprovação antes do primeiro disparo.

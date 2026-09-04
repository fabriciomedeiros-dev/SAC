# Notificações de Projeto Geradas por IA

## Objetivo

O Project Notifier gera rascunhos de e-mail a partir do estado atual de cada projeto. A IA redige a comunicação; a decisão de envio permanece humana.

## Fontes dinâmicas de dados

Em cada execução, o serviço cria um retrato do projeto a partir dos arquivos abaixo:

1. `gestao/projeto.md` — fase, equipe, marcos e contexto.
2. `gestao/tarefas.md` — entregas, responsáveis, prazos e situação.
3. `gestao/decisoes.md` — decisões vigentes e decisões solicitadas.
4. `gestao/historico.md` — marcos recentes.
5. `gestao/comunicacao.md` — tipo de mensagem, destinatários e gatilhos.

O serviço pode receber informações adicionais de uma execução manual, como uma entrega concluída ou bloqueio novo. Essas informações ficam identificadas com data e responsável.

## Contrato do retrato do projeto

Antes de chamar a IA, o serviço organiza os dados no formato abaixo:

```json
{
  "projeto": "SAC",
  "data_referencia": "AAAA-MM-DD",
  "tipo_notificacao": "status_semanal",
  "destinatarios": ["nome ou e-mail"],
  "fase_atual": "texto",
  "concluido_desde_ultimo_status": ["fato registrado"],
  "proximos_passos": ["ação e responsável"],
  "riscos_e_dependencias": ["fato registrado"],
  "decisoes_necessarias": ["decisão, responsável e prazo"],
  "observacoes_adicionais": ["informação manual datada"],
  "fontes": ["arquivo e seção de origem"]
}
```

Campos sem informação devem ser enviados como lista vazia. O serviço não cria dados para preencher lacunas.

## Instruções para a IA

O prompt do sistema deve impor estas regras:

- Escreva em português do Brasil, em tom profissional, objetivo e colaborativo.
- Use exclusivamente fatos presentes no retrato do projeto.
- Não invente prazo, percentual, responsável, custo, decisão ou conclusão.
- Quando uma informação necessária estiver ausente, escreva `Informação pendente de atualização`.
- Não inclua segredos, credenciais, dados pessoais de clientes ou detalhes de casos Sensível/Jurídico.
- Separe fatos concluídos, próximos passos, riscos e decisões solicitadas.
- Não envie e-mail: apenas gere o rascunho.

## Formato de saída obrigatório

O serviço solicita saída estruturada para impedir que texto livre altere destinatários ou o fluxo de aprovação:

```json
{
  "assunto": "[SAC][Status semanal] AAAA-MM-DD — fase e semáforo",
  "resumo_executivo": "texto curto",
  "concluido": ["item"],
  "proximos_passos": ["item"],
  "riscos_e_dependencias": ["item"],
  "decisoes_necessarias": ["item"],
  "corpo_markdown": "mensagem pronta para revisão",
  "lacunas_de_dados": ["campo pendente"],
  "fontes_utilizadas": ["arquivo e seção"]
}
```

O assunto é produzido pela IA, mas os destinatários vêm exclusivamente da matriz de comunicação e da execução manual; a IA não define destinatários.

## Tipos de notificação

| Tipo | Uso | Regra adicional |
| --- | --- | --- |
| `status_semanal` | Atualização executiva recorrente. | Inclui fase, progresso, próximos passos, riscos e decisões. |
| `status_operacional` | Acompanhamento da equipe. | Destaca responsáveis, prazo e impedimentos. |
| `decisao_escopo` | Solicitação de decisão à Danielle. | Apresenta contexto, impacto e recomendação; não declara decisão tomada. |
| `alerta_custo_prioridade` | Risco de custo, fornecedor ou prioridade. | Destinado a Marcelo conforme matriz. |
| `alerta_tecnico` | Bloqueio de ambiente, integração ou desenvolvimento. | Mostra impacto, alternativa e prazo de decisão. |
| `marco_aceite` | Entrega pronta para validação. | Lista evidências e pendências. |
| `prontidao_go_live` | Resultado da homologação. | Não solicita autorização sem evidências registradas. |

## Aprovação e envio

1. O serviço lê os arquivos, monta o retrato e chama a OpenAI API.
2. Salva o rascunho e as fontes usadas em log.
3. Fabrício revisa, ajusta ou aprova o rascunho.
4. Somente após aprovação explícita o Project Notifier envia pelo Microsoft Graph usando `notificacoes.projetos@redesupermarket.com.br`.
5. O serviço registra data, assunto, destinatários, aprovador e resultado do envio.

## Segredos e retenção

- Credenciais Microsoft Graph e OpenAI API ficam apenas nas variáveis seguras do servidor.
- Não entram no Git, nos arquivos `gestao/`, no prompt ou no e-mail.
- Logs armazenam metadados de execução e o rascunho aprovado; não armazenam segredos.

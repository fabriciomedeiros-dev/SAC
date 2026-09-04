# Project Notifier — implantação inicial

Este notifier não chama IA. Ele gera uma prévia de e-mail a partir de `gestao/status-atual.md` e envia somente com `-Send` pelo ZeptoMail.

## Pré-requisitos no Windows Server

- PowerShell 5.1 ou posterior.
- Variável de ambiente `ZEPTO_API_TOKEN`, criada na conta que executará o notifier, com o token da API do agente Projetos no ZeptoMail.
- Opcional: `PROJECT_NOTIFIER_FROM=notificacoes.projetos@redesupermarket.com.br`.

Guarde o token em local seguro. Nunca o inclua no repositório, no arquivo de status ou em logs. Prefira uma variável de usuário da conta dedicada à tarefa, não um valor incluído no comando do Agendador.

## Atualizar o status

Edite `gestao/status-atual.md` antes de cada comunicação. Remova itens `A definir.` e registre apenas fatos confirmados.

## Gerar prévia

No diretório raiz do repositório:

```powershell
.\notifier\ProjectNotifier.ps1 `
  -Tipo status_semanal `
  -Para "destinatario@redesupermarket.com.br" `
  -Preview
```

O HTML é salvo em `notifier/outbox/`. Revise-o ou use o conteúdo como contexto para uma revisão manual no ChatGPT.

## Enviar depois de aprovar

```powershell
.\notifier\ProjectNotifier.ps1 `
  -Tipo status_semanal `
  -Para "destinatario@redesupermarket.com.br" `
  -Send
```

O PowerShell pede confirmação antes do envio. Para enviar uma versão editada, salve o HTML aprovado e informe `-ApprovedBodyPath C:\caminho\email-aprovado.html`.

## Agendamento

Depois de validar o envio manual, crie uma tarefa no Agendador do Windows que execute o comando de prévia ou o envio aprovado. Não agende `-Send` sem um processo de aprovação definido.

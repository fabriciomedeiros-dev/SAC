---
title: "Épico 2 — Triagem e Gestão de Chamados (Workflow Core)"
sidebar_position: 2
---

# Épico 2 — Triagem e Gestão de Chamados

**Perfil envolvido**: Operador de SAC. O mesmo perfil recebe contatos telefônicos e realiza toda a triagem, em painel único.

## Caixa de entrada e bloqueio

- A caixa centraliza chamados recebidos e os registrados por telefone.
- Vários operadores podem atuar simultaneamente, mas, ao iniciar o tratamento, o chamado fica bloqueado exclusivamente para o operador responsável até sua liberação ou conclusão da ação.
- A fila mostra canal, severidade, sentimento, tema, possível duplicidade e situação do tratamento.

## Abertura por telefone e identificação

- O Operador registra o atendimento telefônico e busca contexto no Data Lake dentro do SAC; não há acesso direto ao CRM.
- Antes de desistir, tenta identificar cliente e loja pelos dados disponíveis.
- Sem identificação suficiente de cliente ou loja, o chamado fica em **Aguardando complemento**. O tempo de triagem e o tempo aguardando o cliente são medidos separadamente.
- O Operador envia pedido de complemento e faz até três tentativas com intervalo de 24 horas. Sem resposta após uma semana, o chamado é arquivado. Se houver resposta, retorna à caixa de entrada.

## Triagem, contato e direcionamento

- O Operador confirma ou corrige as sugestões da IA, registra o vínculo manual quando necessário e pode contatar o cliente por e-mail antes do direcionamento.
- Quando faltarem dados, usa resposta padrão solicitando complemento.
- Após revisar a resposta, responde no canal de origem e registra cópia por e-mail quando disponível.
- O SLA do associado só começa quando o chamado é direcionado a um associado responsável.

## SLA e histórico

- O SLA do associado vai do direcionamento até a finalização pelo associado, que exige resposta e evidência.
- Cada chamado exibe: tempo total, tempo em triagem, tempo aguardando cliente e tempo do SLA do associado.
- Os prazos por severidade permanecem parametrizáveis. O Operador acompanha o semáforo e cobra o associado quando necessário.
- Ao redirecionar para outro associado, inicia-se novo ciclo de SLA para o destino; todos os ciclos e eventos anteriores permanecem no histórico.
- Se a correção for de loja dentro do mesmo associado, ela é direta e não inicia novo ciclo.

## Sensível/Jurídico

- Chamados sobre racismo, preconceito religioso ou falsas acusações recebem a tag **Sensível/Jurídico**.
- Seguem o SLA normal da severidade, com rastreabilidade reforçada.
- Detalhes desses casos não aparecem nos dashboards gerais.

## Reabertura

O Operador pode criar novo chamado vinculado a um chamado finalizado quando o cliente voltar a reclamar. O novo chamado segue o fluxo normal e preserva o vínculo com o caso anterior.

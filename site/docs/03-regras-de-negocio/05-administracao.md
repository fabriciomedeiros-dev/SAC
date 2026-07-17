---
title: "Épico 5 — Administração e Cadastro (novo, fora do TAP original)"
sidebar_position: 5
---

# Épico 5 — Administração e Cadastro

:::note Origem
Este épico não constava no TAP original. Foi identificado como lacuna durante a revisão de navegação: sem cadastro de associados, lojas e regras de SLA, os demais épicos não têm como funcionar. Adicionado por decisão de 13/07/2026.
:::

**Objetivo**: permitir que a SAERJ mantenha a base de associados, lojas e parâmetros de SLA sem depender de acesso técnico ao banco de dados.

**Perfil envolvido**: Operador de Triagem.

## Regras de negócio

### Cadastro de associados
- A Rede (SAERJ) cadastra e mantém os 11 associados: dados de identificação e conta de acesso ao Portal do Associado.

:::info Associados confirmados — 16/07/2026
ALVORADA · PADRÃO · TORRE · GMAP · REAL DE EDEN · BARRA OESTE · FLORESTA · FENIX · CRUZEIRO · NDP · RAMIGOS
:::

### Cadastro de lojas
- A Rede cadastra as lojas (150+) e as vincula a um associado responsável.
- Cada loja precisa de dado de localização (para o mapa de calor do Épico 4).

### Parametrização de SLA
- A Rede define e altera os prazos por severidade/tipo de problema (hoje sugeridos como 8h/24h/48h/72h no TAP).
- **Decisão 16/07/2026**: alteração de prazo **não é retroativa** — chamados já encaminhados mantêm o prazo com que foram abertos; só chamados atribuídos depois da mudança usam o novo valor.

:::info Decisões — 16/07/2026
- **Provisionamento de acesso**: o Operador de Triagem cadastra o associado na tela de Administração; ao salvar, o sistema dispara automaticamente um e-mail de convite com senha provisória. Não há criação manual de senha pelo Operador.
- **Inativação de loja/associado**: bloqueia a entrada de *novos* chamados para aquela loja/associado, mas não afeta chamados já abertos — eles continuam visíveis e devem ser concluídos normalmente. Exclusão definitiva só é permitida quando não há mais chamados abertos vinculados.
:::

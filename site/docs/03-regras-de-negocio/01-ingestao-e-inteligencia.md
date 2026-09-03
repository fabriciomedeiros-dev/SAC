---
title: "Épico 1 — Captura e Inteligência (Ingestão)"
sidebar_position: 1
---

# Épico 1 — Captura e Inteligência (Ingestão)

**Objetivo**: centralizar manifestações do MVP, filtrar ruído e apoiar o Operador de SAC na classificação e resposta.

## Canais do MVP

- **Reclame Aqui**: captura por API. A resposta é manual na origem e fica registrada no SAC.
- **E-mail, site e App do Clube**: entram no SAC pelos conectores/formulários definidos no pré-desenvolvimento.
- **Telefone**: registro manual pelo Operador de SAC.
- **Agência Digital**: abre chamados críticos diretamente, por perfil restrito.

Google, WhatsApp e BuzzMonitor não fazem parte do MVP. O Data Lake não é canal de reclamações.

Cada ocorrência guarda canal, data/hora, conteúdo e link para a origem quando houver. Falhas temporárias de uma fonte não interrompem as demais.

## Sandbox

- Mensagens sem sentido, sem contexto ou identificadas como spam vão para Sandbox.
- Não geram SLA e podem ser resgatadas pelo Operador de SAC.
- O expurgo é definitivo após sete dias da captura.
- O MVP não retém itens da Sandbox para treinamento contínuo da IA.

## IA e resposta humana

- A IA sugere severidade, sentimento, tema e rascunho de resposta.
- Todas as sugestões são editáveis e a IA nunca envia uma resposta automaticamente.
- O Operador revisa e aprova a resposta no canal de origem. Quando houver e-mail disponível, registra também a cópia por e-mail.
- Para site, a resposta é enviada por e-mail; para App do Clube, pela área/notificação interna e por e-mail; no telefone, o Operador solicita e-mail e registra o atendimento.
- Não existe área de acompanhamento para o cliente no MVP.

## Data Lake e deduplicação

- O Data Lake corporativo é consultado em modo leitura para enriquecer o chamado com CRM, vendas, loja preferida/compra, ticket médio, frequência e histórico.
- O vínculo automático só ocorre com CPF, e-mail ou telefone exato e único. Vínculos ambíguos exigem confirmação do Operador; vínculos manuais ficam registrados.
- Possíveis duplicidades são apenas alertadas. O Operador decide unir, relacionar ou ignorar, preservando o histórico da decisão.

# UX/UI notes — bitolando

## Diagnóstico rápido

A direção visual está forte: minimalista, editorial, com personalidade tecnológica suficiente depois da troca da marca. A combinação de preto real, tipografia grande, acento âmbar e bastante respiro funciona bem para um blog pessoal que quer parecer um lugar de pensamento organizado, não uma landing page.

O principal risco de UX não é estético; é de consistência. O usuário precisa sentir que público, login e admin fazem parte do mesmo produto. Quando o tema se perde entre telas, a interface passa a sensação de instabilidade. Por isso a persistência global de tema é a melhoria prioritária.

| Área | Estado atual | Sugestão |
|---|---|---|
| Tema | Visualmente bonito, mas podia perder estado entre layouts | Centralizar tema em `localStorage`, reaplicar em Turbo e usar o mesmo bootstrap em público, admin e login |
| Header | Agora ficou mais elegante com símbolo + texto | Manter o tamanho atual; evitar logo completa rasterizada no topo |
| Botão de tema | Ícone discreto, mas o foco azul do browser quebrava a estética | Usar foco customizado âmbar e `aria-pressed` |
| Home | Editorial, boa hierarquia no post principal | Adicionar mais contexto ao arquivo quando houver vários posts, talvez categoria + data + uma linha de resumo |
| Admin | Funcional e coerente com a estética do site | Melhorar ergonomia de escrita: preview markdown, autosave de rascunho e estados de validação mais visíveis |
| Mobile | A identidade deve funcionar, mas precisa de validação específica | Priorizar teste do header/nav e campos do admin em telas estreitas |

## Melhorias recomendadas por prioridade

**Prioridade 1:** manter tema consistente em todos os layouts. Isso reduz atrito e remove a sensação de bug visual ao navegar entre site, admin e login.

**Prioridade 2:** melhorar a experiência de escrita no admin. O admin já tem uma boa estética, mas como o projeto é um blog pessoal, a tela de criação de post é o coração do produto. Um preview markdown ao lado, autosave local de rascunho e uma indicação clara de publicado/rascunho/agendado trariam muito ganho real.

**Prioridade 3:** refinar o arquivo/listagem. A home está bonita quando há um post em destaque, mas o arquivo pode ganhar uma leitura mais editorial: número, categoria, data e uma frase curta. Isso combina com a proposta de caderno público organizado.

**Prioridade 4:** revisar estados interativos. Links, botões, inputs e foco devem usar o mesmo vocabulário visual: âmbar para ação/estado ativo, cinza para metadado, borda sutil para separação.

## Observação final

Eu não mexeria demais na estética agora. O projeto já tem um caminho visual claro. As próximas melhorias deveriam ser de consistência, escrita e navegação, não de “embelezamento”.

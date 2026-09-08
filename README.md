# Uso de IA na pesquisa científica — manual prático (MirandasTech)

Manual em formato de slides sobre uso responsável, configurável e auditável de IA generativa em pesquisa: regras vigentes (CNPq 2026, LGPD/ANPD, ICMJE, ERA), permissões por tarefa, configuração das ferramentas, registro de uso, trabalho em equipe, e o passo a passo por fase — pergunta, método, protocolo, busca, triagem (Rayyan, ASReview), acervo (Zotero), leitura, extração, agentes (repositório, AGENTS.md, skills, MCP), escrita, referências e declaração.

**Manual on-line:** https://manual.mirandastech.com.br/ · **PDF:** https://manual.mirandastech.com.br/manual.pdf · **HTML autônomo:** `manual/Manual_Uso_de_IA_na_Pesquisa_Cientifica_MirandasTech.html` · **PDF:** `manual/Manual_Uso_de_IA_na_Pesquisa_Cientifica_MirandasTech.pdf`

## Conteúdo do repositório
| Pasta | O que há |
|---|---|
| `manual/` | o manual (HTML autônomo e PDF) |
| `modelos/` | `AGENTS.md`, `DECISOES.md`, `ACORDO_ORIENTADOR.md`, `USO_DE_IA.csv`, `registro_exportacoes.csv` |
| `.claude/agents/orientador.md` + `.claude/skills/orientador-ia-pesquisa/` | **Agente Orientador**: guia a instalação, cria o projeto, responde às dúvidas iniciais e controla o checklist local `PROGRESSO_IA.md` apontando os slides do manual |
| `.claude/skills/triagem-assistida/` | skill de exemplo com teste de red team |
| `scripts/iniciar_projeto.py` · `scripts/instalar_skills.sh` | criam a estrutura do projeto com os modelos e instalam agente + skills no Claude Code |
| `scripts/` | `verificar_refs.py` (Crossref), `fig_openalex_anos.py` (figura por API) |
| `capturas/` | capturas de tela reais usadas no manual (ASReview LAB, Zotero, Connected Papers, APIs), datadas |

## Começar em três comandos
```bash
git clone https://github.com/joaopaulomirandamatias/ia-na-pesquisa-cientifica.git
bash ia-na-pesquisa-cientifica/scripts/instalar_skills.sh
python3 ia-na-pesquisa-cientifica/scripts/iniciar_projeto.py minha-pesquisa --tema "…" --metodo "revisão sistemática"
```
Depois, no Claude Code dentro de `minha-pesquisa/`: **«Orientador, começar projeto»**.

## Como citar
MATIAS, J. P. M. *Uso de IA na pesquisa científica: manual prático.* MirandasTech, v2.5, set. 2026. Licença CC BY 4.0.

## Declaração de uso de IA
Este material foi escrito com assistência de IA (Claude, Anthropic) na estruturação, redação, scripts e capturas, sob as regras que ele próprio descreve. O autor responde integralmente pelo conteúdo.

## Deploy (Railway)
`Dockerfile` + `Caddyfile` servem `site/` (o deck como `index.html` e o PDF em `/manual.pdf`). Para atualizar: regenerar o deck, copiar para `site/`, `git push` — o Railway reconstrói a cada push.

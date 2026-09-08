#!/usr/bin/env bash
# Instala as skills e o agente deste repositório para uso no Claude Code (pessoal: ~/.claude).
set -e
AQUI="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p ~/.claude/skills ~/.claude/agents
cp -r "$AQUI/.claude/skills/triagem-assistida" ~/.claude/skills/
cp -r "$AQUI/.claude/skills/orientador-ia-pesquisa" ~/.claude/skills/
cp "$AQUI/.claude/agents/orientador.md" ~/.claude/agents/
echo "instalado em ~/.claude:"; ls ~/.claude/skills | grep -E "triagem-assistida|orientador-ia-pesquisa"; ls ~/.claude/agents | grep orientador
echo; echo "Abra o Claude Code na pasta do seu projeto e diga: \"Orientador, começar projeto\"."

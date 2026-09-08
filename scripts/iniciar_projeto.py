#!/usr/bin/env python3
"""Cria a estrutura básica de um projeto de pesquisa com uso responsável de IA.

    python3 scripts/iniciar_projeto.py <pasta> --tema "..." --metodo "revisão sistemática"

Cria pastas, copia os modelos deste repositório, gera PROGRESSO_IA.md (o checklist do manual)
e inicializa o Git. Não sobrescreve arquivos que já existam.
"""
import argparse, shutil, subprocess, sys
from datetime import date
from pathlib import Path

AQUI = Path(__file__).resolve().parent.parent
MODELOS = AQUI / "modelos"
PASTAS = ["00_protocolo", "01_buscas", "02_triagem", "03_extracao", "04_sintese", "05_manuscrito", "tools", "dados_restritos_FORA_DO_GIT"]
ITENS = [
 ("Governança", "Acordo com o orientador assinado; protocolo congelado e datado antes da primeira busca; procedimento de emenda escrito", "6, 17"),
 ("Governança", "Arquivo de regras do agente com proibições absolutas, gates humanos e critério de conclusão", "37"),
 ("Dados", "Dado licenciado e pessoal fora do repositório; treinamento desligado nas ferramentas; hash registrado", "9, 11"),
 ("Busca", "String de cada base salva verbatim do histórico, com data, filtros, total e SHA-256 do export", "18, 22"),
 ("Busca", "Teste com e sem truncamento registrado; conjunto-semente com regra de decisão prévia", "19, 21"),
 ("Triagem", "Codebook versionado; toda recomendação de IA com status preliminar; decisão humana por registro", "23, 28"),
 ("Triagem", "κ com intervalo de confiança; grau de cegamento declarado; regra de parada do aprendizado ativo escrita antes", "26, 27"),
 ("Acesso", "Os três números do texto completo medidos separadamente; E5 declarado com lista", "31"),
 ("Extração", "Cada codificação com página e seção; extração assistida conferida no PDF; dupla codificação em amostra", "32, 33"),
 ("Figuras", "Toda figura gerada por script que lê o dado; nenhum número digitado; nenhuma imagem gerada por IA", "34"),
 ("Referências", "Todo DOI resolvido na Crossref na versão final; referência sem DOI com prova alternativa", "42"),
 ("Texto", "Marcas de IA contadas e removidas; um trecho lido em voz alta; comparação linha a linha com a versão do modelo", "40, 41"),
 ("Texto", "Todo número do texto bate com a tabela de origem; somas fecham; resumo contado", "44"),
 ("Equipe", "Registro de uso compartilhado com a coluna «quem»; todos os coautores leram o texto inteiro e aprovaram a declaração", "12, 13"),
 ("Declaração", "Uso de IA declarado com ferramenta, fase, finalidade, validação e o que a IA não fez", "43"),
 ("Entrega", "Guia de relato conferido item a item; disponibilidade de dados verdadeira no momento da submissão", "16"),
]

def main():
    ap = argparse.ArgumentParser(); ap.add_argument("pasta"); ap.add_argument("--tema", default="(a definir)"); ap.add_argument("--metodo", default="(a definir)")
    a = ap.parse_args(); raiz = Path(a.pasta).resolve(); raiz.mkdir(parents=True, exist_ok=True)
    for p in PASTAS: (raiz / p).mkdir(exist_ok=True)
    for m in ["AGENTS.md", "DECISOES.md", "ACORDO_ORIENTADOR.md", "USO_DE_IA.csv"]:
        dst = raiz / m
        if not dst.exists(): shutil.copy(MODELOS / m, dst)
    if not (raiz / "01_buscas/registro_exportacoes.csv").exists(): shutil.copy(MODELOS / "registro_exportacoes.csv", raiz / "01_buscas/registro_exportacoes.csv")
    gi = raiz / ".gitignore"
    if not gi.exists(): gi.write_text("dados_restritos_FORA_DO_GIT/\n*.xls\n*.xlsx\nexports/\n.env\n*.pdf\n", encoding="utf-8")
    prog = raiz / "PROGRESSO_IA.md"
    if not prog.exists():
        linhas = [f"# Progresso — {a.tema}", "", f"**Método:** {a.metodo} · **Início:** {date.today().isoformat()} · Manual: https://manual.mirandastech.com.br/", "",
                  "Regra: um item só é marcado `[x]` pelo Orientador depois de conferir a evidência. Anote data e evidência ao lado.", "",
                  "| # | Área | Item | Slides | Estado | Data | Evidência conferida |", "|---|---|---|---|---|---|---|"]
        for i, (area, item, sl) in enumerate(ITENS, 1): linhas.append(f"| {i} | {area} | {item} | {sl} | [ ] | | |")
        prog.write_text("\n".join(linhas) + "\n", encoding="utf-8")
    proto = raiz / "00_protocolo/protocolo.md"
    if not proto.exists():
        proto.write_text(f"# Protocolo — {a.tema}\n\n**Método:** {a.metodo}\n**Congelado em:** (preencher — depois disso, só por emenda)\n\n"
                         "1. Pergunta e subperguntas\n2. Bases e justificativa\n3. Blocos conceituais e strings (verbatim)\n4. Janela, idiomas, tipos documentais\n"
                         "5. Critérios de inclusão e códigos de exclusão\n6. Procedimento de triagem\n7. Conjunto-semente\n8. Campos de extração e codebook\n"
                         "9. Avaliação de qualidade\n10. Plano de síntese\n11. Gates humanos\n12. Procedimento de emenda\n\n## Emendas\n(nenhuma)\n", encoding="utf-8")
    if not (raiz / ".git").exists():
        subprocess.run(["git", "init", "-q"], cwd=raiz, check=False)
    print(f"projeto criado em {raiz}"); 
    for p in sorted(x.relative_to(raiz).as_posix() for x in raiz.rglob("*") if ".git" not in x.parts): print("  ", p)
    return 0

if __name__ == "__main__": sys.exit(main())

# Site do manual de IA + manuais irmãos servidos por caminho (/zotero, /metodologia, /gemini-notebook, /plugin, /prisma, /busca, /latex, /git, /dados, /bibliometria, /cienciaaberta, /defesa, /orientador, /professor), buscados no GitHub no build
FROM alpine/git:latest AS irmaos
WORKDIR /src
RUN apk add --no-cache curl unzip
RUN git clone --depth 1 https://github.com/joaopaulomirandamatias/zotero-pesquisa-cientifica.git zotero \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/metodologia-pesquisa-cientifica.git metodologia \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/gemini-notebook-pesquisa-cientifica.git gemini \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/pesquisa-mirandastech.git plugin \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/revisao-sistematica-pesquisa-cientifica.git prisma \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/busca-bases-pesquisa-cientifica.git busca \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/latex-overleaf-abntex2-pesquisa-cientifica.git latex \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/git-github-pesquisa-cientifica.git gitman \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/analise-de-dados-pesquisa-cientifica.git dados \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/bibliometria-pesquisa-cientifica.git bibliometria \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/ciencia-aberta-pesquisa-cientifica.git cienciaaberta \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/defesa-qualificacao-pesquisa-cientifica.git defesa \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/manual-do-orientador-pesquisa-cientifica.git orientador \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/manual-do-professor-pesquisa-cientifica.git professor \
 && curl -fsSL -o /tmp/ma.zip https://github.com/joaopaulomirandamatias/pesquisa-mirandastech/releases/download/manual-assets/manual-assets.zip \
 && unzip -q /tmp/ma.zip -d plugin/manual

FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY site/ /srv/
COPY capturas/ /srv/capturas/
COPY --from=irmaos /src/zotero/site/ /srv/zotero/
COPY --from=irmaos /src/zotero/capturas/ /srv/zotero/capturas/
COPY --from=irmaos /src/metodologia/site/ /srv/metodologia/
COPY --from=irmaos /src/metodologia/capturas/ /srv/metodologia/capturas/
COPY --from=irmaos /src/metodologia/figuras/ /srv/metodologia/figuras/
COPY --from=irmaos /src/gemini/site/ /srv/gemini-notebook/
COPY --from=irmaos /src/gemini/capturas/ /srv/gemini-notebook/capturas/
COPY --from=irmaos /src/plugin/manual/site/ /srv/plugin/
COPY --from=irmaos /src/plugin/manual/capturas/ /srv/plugin/capturas/
COPY --from=irmaos /src/prisma/site/ /srv/prisma/
COPY --from=irmaos /src/prisma/capturas/ /srv/prisma/capturas/
COPY --from=irmaos /src/busca/site/ /srv/busca/
COPY --from=irmaos /src/busca/capturas/ /srv/busca/capturas/
COPY --from=irmaos /src/latex/site/ /srv/latex/
COPY --from=irmaos /src/latex/capturas/ /srv/latex/capturas/
COPY --from=irmaos /src/gitman/site/ /srv/git/
COPY --from=irmaos /src/gitman/capturas/ /srv/git/capturas/
COPY --from=irmaos /src/dados/site/ /srv/dados/
COPY --from=irmaos /src/dados/capturas/ /srv/dados/capturas/
COPY --from=irmaos /src/bibliometria/site/ /srv/bibliometria/
COPY --from=irmaos /src/bibliometria/capturas/ /srv/bibliometria/capturas/
COPY --from=irmaos /src/cienciaaberta/site/ /srv/cienciaaberta/
COPY --from=irmaos /src/cienciaaberta/capturas/ /srv/cienciaaberta/capturas/
COPY --from=irmaos /src/defesa/site/ /srv/defesa/
COPY --from=irmaos /src/defesa/capturas/ /srv/defesa/capturas/
COPY --from=irmaos /src/orientador/site/ /srv/orientador/
COPY --from=irmaos /src/orientador/capturas/ /srv/orientador/capturas/
COPY --from=irmaos /src/professor/site/ /srv/professor/
COPY --from=irmaos /src/professor/capturas/ /srv/professor/capturas/
EXPOSE 8080
ENV PORT=8080
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

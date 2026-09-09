# Site do manual de IA + manuais irmãos servidos por caminho (/zotero, /metodologia, /gemini-notebook, /plugin, /prisma), buscados no GitHub no build
FROM alpine/git:latest AS irmaos
WORKDIR /src
RUN apk add --no-cache curl unzip
RUN git clone --depth 1 https://github.com/joaopaulomirandamatias/zotero-pesquisa-cientifica.git zotero \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/metodologia-pesquisa-cientifica.git metodologia \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/gemini-notebook-pesquisa-cientifica.git gemini \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/pesquisa-mirandastech.git plugin \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/revisao-sistematica-pesquisa-cientifica.git prisma \
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
EXPOSE 8080
ENV PORT=8080
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

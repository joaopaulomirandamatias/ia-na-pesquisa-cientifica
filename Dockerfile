# Site do manual de IA + manuais irmãos servidos por caminho (/zotero, /metodologia), buscados no GitHub no build
FROM alpine/git:latest AS irmaos
WORKDIR /src
RUN git clone --depth 1 https://github.com/joaopaulomirandamatias/zotero-pesquisa-cientifica.git zotero \
 && git clone --depth 1 https://github.com/joaopaulomirandamatias/metodologia-pesquisa-cientifica.git metodologia

FROM caddy:2-alpine
COPY Caddyfile /etc/caddy/Caddyfile
COPY site/ /srv/
COPY capturas/ /srv/capturas/
COPY --from=irmaos /src/zotero/site/ /srv/zotero/
COPY --from=irmaos /src/zotero/capturas/ /srv/zotero/capturas/
COPY --from=irmaos /src/metodologia/site/ /srv/metodologia/
COPY --from=irmaos /src/metodologia/capturas/ /srv/metodologia/capturas/
COPY --from=irmaos /src/metodologia/figuras/ /srv/metodologia/figuras/
EXPOSE 8080
ENV PORT=8080
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

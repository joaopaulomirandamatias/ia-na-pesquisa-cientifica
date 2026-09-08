#!/usr/bin/env python3
"""Figura por API aberta: obras por ano na OpenAlex para uma consulta. Troque a consulta e o e-mail."""
import json, urllib.request
import matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt

CONSULTA = '%22systematic%20review%22%20%22artificial%20intelligence%22'
url = (f"https://api.openalex.org/works?filter=title_and_abstract.search:{CONSULTA},"
       "publication_year:2015-2025&group_by=publication_year&mailto=SEU@EMAIL")
d = json.load(urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": "fig-openalex (mailto:SEU@EMAIL)"})))
rows = sorted((int(g["key"]), g["count"]) for g in d["group_by"])
print(rows)  # confira contra a resposta bruta antes de usar a figura

fig, ax = plt.subplots(figsize=(7.2, 3.1), dpi=100)
ax.bar([y for y, _ in rows], [n for _, n in rows], color="#17436B", width=0.72)
ax.set_xticks([y for y, _ in rows]); ax.spines[["top", "right"]].set_visible(False)
ax.set_ylabel("obras indexadas"); ax.set_title("OpenAlex — obras por ano para a consulta", loc="left", fontsize=10)
fig.tight_layout(); fig.savefig("fig_openalex_anos.svg")

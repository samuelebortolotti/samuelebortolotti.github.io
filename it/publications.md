---
layout: default
title: Publications
lang: it
ref: publications
nav_bar: publications
description: I miei ultimi articoli e preprint, sincronizzati da DBLP.
---
# Pubblicazioni

{% if site.data.publications %}
<p class="synced">
  Sincronizzato da <a href="{{ site.data.publications.source }}.html">{{ site.data.publications.source_name }}</a>
  il {{ site.data.publications.last_updated | date: "%-d/%m/%Y" }}
  &middot; {{ site.data.publications.count }} voci.
</p>
{% endif %}

{% assign publications = site.publications | sort: 'date' | reverse %}
{% assign current_year = '' %}
{% for publication in publications %}
  {% assign year = publication.date | date: '%Y' %}
  {% if year != current_year %}
    {% assign current_year = year %}
<h2 class="pub-year">{{ year }}</h2>
  {% endif %}
<div class="post">
  <h3 class="pub-title"><a class="post-link" href="{{ publication.url | relative_url }}">{{ publication.title }}</a></h3>
  <p class="pub-authors">
    {%- for author in publication.authors -%}
      {%- if author == "Samuele Bortolotti" -%}<b>{{ author }}</b>{%- else -%}{{ author }}{%- endif -%}
      {%- unless forloop.last -%}, {% endunless -%}
    {%- endfor -%}
  </p>
  <p class="pub-venue">
    {% if publication.conference_url %}<a href="{{ publication.conference_url }}"><em>{{ publication.conference }}</em></a>{% else %}<em>{{ publication.conference }}</em>{% endif %}
    {% if publication.paper %}&middot; <a href="{{ publication.paper }}">paper</a>{% endif %}
  </p>
</div>
{% endfor %}

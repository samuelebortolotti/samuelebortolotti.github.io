---
layout: default
title: Publications
permalink: publications/
redirect_from: /en/publications.html
lang: en
ref: publications
nav_bar: publications
---
# Publications

{% assign publications=site.publications | sort: 'date' | reverse %}
{% for publication in publications %}
<div class="post">
  <span style="font-weight: bold">{{ publication.date | date: "%b %-d, %Y" }}</span>
  <h2 style="margin:0px">
    <a class="post-link" href="{{ publication.url | prepend: site.baseurl }}">{{ publication.title }}</a>
  </h2>
  <p style="margin: 0.5em 0em;">
  {% for author in publication.authors %}
  {% if author == "Samuele Bortolotti" %}
    <b>{{ author }}</b>{% unless forloop.last %}, {% endunless %}
  {% else %}
    {{ author }}{% unless forloop.last %}, {% endunless %}
  {% endif %}
  {% endfor %}
  </p>
  <p><a href="{{ publication.conference_url }}"><em>{{ publication.conference }}</em></a> - (<a href="{{ publication.paper }}">PDF</a>)</p>
</div>
{% endfor %}
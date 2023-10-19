---
layout: default
title: Blog
lang: de
ref: blog
nav_bar: blog
---
# Blog
Hallo Leute, in diesem Abschnitt der Website werde Ich meine Gedanken mit Ihnen teilen.

Wenn ich etwas Zeit dafür finde, natürlich :).

{% assign posts=site.posts | where:"lang", page.lang | sort: 'date' | reverse %}
{% for post in posts%}
<div class="post">
  <span style="font-weight: bold">Erstellt: {{ post.date | date: "%b %-d, %Y" }} - Letzte Aktualisierung: {{ post.modification_date | date: "%b %-d, %Y" }} - {{ post.reading_time}}</span>
  <h2 style="margin:0px">
    <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
  </h2>
  <p style="opacity:0.8; margin:0px">{{ post.description }}</p>
</div>
{% endfor %}
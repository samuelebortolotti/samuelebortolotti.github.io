---
layout: default
title: Blog
lang: it
ref: blog
nav_bar: blog
---
# Blog
Ciao! Questa sezione sarà adibita alla condivisione di idee, pensieri ed esperienze.

Se trovo un po' di tempo per farlo, ovviamente :).

{% assign posts=site.posts | where:"lang", page.lang | sort: 'date' | reverse %}
{% for post in posts %}
<div class="post">
  <span style="font-weight: bold">Creato: {{ post.date | date: "%b %-d, %Y" }} - Ultima modifica: {{ post.modification_date | date: "%b %-d, %Y" }} - {{ post.reading_time}}</span>
  <h2 style="margin:0px">
    <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
  </h2>
  <p style="opacity:0.8; margin:0px">{{ post.description }}</p>
</div>
{% endfor %}
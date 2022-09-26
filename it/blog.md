---
layout: default
title: Blog
lang: it
ref: blog
nav_bar: blog
---
# Blog
{% assign posts=site.posts | where:"lang", page.lang %}
{% for post in posts %}
<div class="post">
  <span style="font-weight: bold">{{ post.date | date: "%b %-d, %Y" }} - {{ post.reading_time }}</span>
  <h2 style="margin:0px">
    <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
  </h2>
  <p style="opacity:0.8; margin:0px">{{ post.description }}</p>
</div>
{% endfor %}
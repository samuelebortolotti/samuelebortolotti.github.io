---
layout: default
title: Blog
permalink: /blog
redirect_from: /en/blog.html
lang: en
ref: blog
nav_bar: blog
---
# Blog
Greetings! In this section, I'll be sharing some of my thoughts and insights.

If I find some time to share them of course :).

{% assign posts=site.posts | where:"lang", page.lang | sort: 'date' | reverse %}
{% for post in posts %}
<div class="post">
  <span style="font-weight: bold">Created: {{ post.date | date: "%b %-d, %Y" }} - Last Update: {{ post.modification_date | date: "%b %-d, %Y" }} - {{ post.reading_time}}</span>
  <h2 style="margin:0px">
    <a class="post-link" href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a>
  </h2>
  <p style="opacity:0.8; margin:0px">{{ post.description }}</p>
</div>
{% endfor %}
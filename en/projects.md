---
layout: default
title: Projects
lang: en
permalink: /projects.html
redirect_from: /en/projects.html
ref: projects
nav_bar: projects
---
# Projects
This section aims to contain the description of the most relevant projects I have collaborated on and the ones I am currently working on.

{% assign projects=site.projects | where:"lang", page.lang %}
{% for project in projects %}
<div class="post">
  <span style="font-weight: bold">{{ project.date | date: "%b %-d, %Y" }}</span>
  <h2 style="margin:0px">
    <a class="post-link" href="{{ project.url | prepend: site.baseurl }}">{{ project.title }}</a>
  </h2>
  <h3 style="margin: 0.5em 0em;">
    <a class="post-link" href="{{ project.repository }}">[Repository]</a>
    <a class="post-link" href="{{ project.report }}">[Report]</a>
  </h3>
  <p style="opacity:0.8; margin:0px">{{ project.description }}</p>
</div>
{% endfor %}
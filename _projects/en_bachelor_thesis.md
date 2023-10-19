---
layout: post
title: Bachelor Thesis
lang: en
date: 2021-07-20
permalink: projects/bachelor-thesis.html
mathjax: true
ref: projects/bachelor-thesis.html
repository: https://github.com/samuelebortolotti/bachelor-thesis
url: https://github.com/samuelebortolotti/bachelor-thesis
report: https://github.com/samuelebortolotti/bachelor-thesis/tree/master/thesis/src
author: 
- Samuele Bortolotti
nav_bar: projects
type: project
description: This project represents my undergraduate thesis for a Computer Science degree at the University of Trento. It consists in developing an effective strategy for extracting the languages spoken by Wikipedia users, and extracting Wikipedia users’ user warnings and Wikibreaks, with a Focus on Studying their impact on users' activity level.
---
# Bachelor Thesis

## General Information:
In recent decades, Wikipedia has emerged as a leading platform for free and collaborative knowledge sharing, capturing the attention of the scientific community. While much focus has been on Wikipedia's content, the behavior of its active users has also become a subject of interest. Notably, a study by [Miquel-Ribé et al(2021)](https://wikiworkshop.org/2021/papers/Wiki_Workshop_2021_paper_22.pdf). highlights the issue of editor attrition, particularly among experienced contributors, raising questions about the factors contributing to their departure from the platform.

## Project Objective:
My bachelor's dissertation comprehensively analyzes Wikipedia user data, focusing on several key aspects, including language proficiency, wikibreak patterns, and user warnings. The thesis involved the development and implementation of data mining strategies to extract valuable insights from Wikipedia's vast content.

## Key Analysis Areas:
1. **Language Proficiency:** The study begins by identifying the languages known by Wikipedia users to determine the most commonly spoken languages within the community.

2. **Wikibreak Patterns:** Templates related to wikibreaks, which describe users' activity cycles on the platform, were extracted to understand their usage patterns and popularity. Categorizations were developed to classify various types of wikibreaks, allowing for the tracking of active wikibreaks over time.

3. **User Warnings:** User warning templates were retrieved and categorized by severity. A timeline analysis was conducted to assess the impact of warnings on user activity, especially in the months following a high-severity warning.

## Data Extraction and Analysis:
The project involved data mining techniques to extract and analyze user data, addressing the research objectives mentioned above. The methodologies implemented in the dissertation include:

- Understanding Wikipedia's content structure, page organization, and revision history.
- Developing methods for identifying and classifying templates within Wikipedia. This method involved the creation of a pipeline which scans the content of the Wikipedia dump, identifies and extracts the content concerning the selected templates.
- Recognizing template meanings and implementing semantic classifications.
- Creating a tool that consolidates user warning, wikibreak, and user action data to generate statistics and explore the correlation between user behavior and received warnings.

In Wikipedia, the inclusion of templates presents a nuanced challenge due to the existence of two distinct methods: transclusion and substitution, each with its own set of advantages and drawbacks.

### Transclusion
Transclusion is the more prevalent method used to insert templates into Wikipedia pages. This approach involves placing the template reference (a "live" link) within the current document. Any future modifications to the template's appearance will automatically reflect across all pages referencing it. This sequential inclusion of templates containing transcluded templates is referred to as nested inclusion. The basic syntax for inserting a template via transclusion is as follows:

<pre>
&#123;&#123;&#123;&#123;Template name&#125;&#125;
</pre>

This syntax can be extended to include parameters:

<pre>
&#123;&#123;&#123;&#123;Template name | parameter | parameter | ...&#125;&#125;
</pre>

Transclusion ensures that changes to a template are universally applied across all pages utilizing it.

![Transcluded template](https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Transclusion-multiple-foo.svg/1024px-Transclusion-multiple-foo.svg.png){: width="100%"}

### Substitution
Substitution offers an alternative method for template inclusion. It entails embedding the template code directly into the current document using the "subst" function. This means that any future modifications to the original template will not affect pages where it has been substituted. The required syntax for inserting a template via substitution is as follows:

<pre>
&#123;&#123;subst: Template name&#125;&#125;
</pre>

Similar to transclusion, substitution syntax can accommodate additional parameters:

<pre>
&#123;&#123;subst: Template name | parameter | parameter | ...&#125;&#125;
</pre>

One significant advantage of substitution is its ability to include and modify code without altering the original template, thereby preserving the integrity of transcluded instances. For user warning templates, substitution is commonly employed to safeguard templates against vandalism. The outcomes of template substitution are independent of the template page after the substitution is complete. Here's an example of the wikicode after applying the substitution function:

*Substitution function code:*
<pre>
&#123;&#123;subst:foo&#125;&#125;
</pre>

*Code inserted in the target page:*
```
Sample template content.
```

Both transclusion and substitution methods can be organized recursively, but when a substituted template contains transcluded templates, the default behavior retains unmodified references generated by the transclusion process. However, it is possible to customize the substitution function to create a chain of substitutions and insert the code from each mentioned template, thus altering the inclusion process.

### Users's warning extraction
Unlike wikibreaks and languages, which are often inserted using transclusion, users' warnings do not follow a preferred strategy.

For this reason, naive and efficient approaches that extract template information using regular expressions will not work in all cases.

To identify substituted templates, the idea has been to first identify the template by recognizing its most important words.
 
To do this, we utilize [tf-idf (term frequency–inverse document frequency)](https://en.wikipedia.org/wiki/Tf%E2%80%93idf), a numerical statistic, to identify the most meaningful words within template revisions. This metric measures a word's importance in a document collection (corpus) by considering both its frequency in a document (term frequency, $tf$) and how uniquely it characterizes the entire corpus (inverse document frequency, $idf$).

**Term Frequency ($tf$):** 

{::nomarkdown}
$$tf(t, d) = \frac{f_{t,d}}{\sum_{t' \in d} f_{t',d}}$$
{:/}

Term frequency measures how often a term appears within a specific document. The more frequent a word is in a document, the more important it is to that document.

**Inverse Document Frequency ($idf$):** 

{::nomarkdown}
$$idf(t, D) = \frac{\log |D|}{|\{d \in D : t \in d\}|}$$
{:/}

Inverse document frequency evaluates how uniquely a term characterizes the entire corpus. It is calculated as the logarithm of the total number of documents in the corpus divided by the number of documents containing the specific word.

**Overall Metric ($tf$-$idf$):** 

{::nomarkdown}
$$tf-idf(t, d, D) = tf(t, d) \cdot idf(t, D)$$
{:/}

The final $tf$-$idf$ metric combines both term frequency and inverse document frequency to determine a word's importance. If a term appears in all documents, its $tf$-$idf$ score is 0, indicating it's not characteristic to the corpus.

However, in certain cases, such as identifying characteristic words in block templates, the $tf$-$idf$ metric may have limitations. For instance, common words like 'block' may appear frequently in all template revisions, resulting in a low $idf$ score. Yet, these words can be crucial for identifying specific templates within a page.

Once the $tf$-$idf$ metric is retrieved, the program searches for the most relevant word occurrences within the user page by employing the [Aho–Corasick algorithm](https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm). If all the occurrences have been found, then the template is considered included.

The problem with this approach, despite its relative efficiency, is the number of false positives that the procedure can generate.

## Results

In this section, we discuss the languages spoken by Wikipedia users and the correlation between users' warning and dropoff.

Regarding the languages spoken by Wikipedia users, we have proven that English is the most frequently mentioned language in Italian Wikipedia, followed by Italian itself. 

We have also demonstrated that Italian overwhelmingly dominates the languages known at a native speaker level within the Italian Wikipedia community, with English trailing behind in third place.

The most interesting part of the study aimed to assess the impact of high-severity user warnings on user activity levels in Italian Wikipedia. The analysis excluded bans and temporary blocks due to their predictable effects on user behavior.

Our findings indicate that more than 80% of users across all categories experienced a decrease in activity following high-severity warnings. Notably, this trend was consistent for both genders, albeit slightly more pronounced for women. 

In summary, we have proven that high-severity user warnings have a significant impact on user activity levels in Italian Wikipedia, leading to decreased user activity across the board.

## Conclusion and Future Work
While this project represents a preliminary exploration of Wikipedia user behavior, it serves as a foundation for future analyses. The contributions of this work include improved comprehension of Wikipedia's content structure, template inclusion mechanisms, and the development of a tool for data consolidation and analysis.

Understanding user behavior on Wikipedia is crucial for enhancing the platform's sustainability and addressing issues related to editor attrition. This research provides valuable insights into the dynamics of one of the world's largest collaborative knowledge platforms.
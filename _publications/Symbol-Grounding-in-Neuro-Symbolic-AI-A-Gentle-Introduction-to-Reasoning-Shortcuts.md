---
layout: post
permalink: /publications/Symbol-Grounding-in-Neuro-Symbolic-AI-A-Gentle-Introduction-to-Reasoning-Shortcuts.html
title: "Symbol Grounding in Neuro-Symbolic AI: A Gentle Introduction to Reasoning Shortcuts"
date: 2026-01-01
redirect_from:
  - /publications/Symbol-Grounding-in-Neuro‑Symbolic-AI-A-Gentle-Introduction-to-Reasoning-Shortcuts.html
  - /en/publications/Symbol-Grounding-in-Neuro-Symbolic-AI-A-Gentle-Introduction-to-Reasoning-Shortcuts.html
  - /it/publications/Symbol-Grounding-in-Neuro-Symbolic-AI-A-Gentle-Introduction-to-Reasoning-Shortcuts.html
  - /de/publications/Symbol-Grounding-in-Neuro-Symbolic-AI-A-Gentle-Introduction-to-Reasoning-Shortcuts.html
authors:
  - Emanuele Marconato
  - Samuele Bortolotti
  - Emile van Krieken
  - Paolo Morettin
  - Elena Umili
  - Antonio Vergari
  - Efthymia Tsamoura
  - Andrea Passerini
  - Stefano Teso
conference: JAIR 2026
conference_url: https://www.jair.org/index.php/jair/article/view/22389
paper: https://www.jair.org/index.php/jair/article/view/22389/27344
lang: en
ref: publications
nav_bar: publications
dblp_key: journals/jair/MarconatoBKMUVTPT26
dblp_url: https://dblp.org/rec/journals/jair/MarconatoBKMUVTPT26.html
dblp_keys: journals/jair/MarconatoBKMUVTPT26, journals/corr/abs-2510-14538
---

# Symbol Grounding in Neuro-Symbolic AI: A Gentle Introduction to Reasoning Shortcuts

## Abstract

Neuro-symbolic (NeSy) AI aims to develop deep neural networks whose predictions comply with prior knowledge encoding, e.g. safety or structural constraints. As such, it represents one of the most promising avenues for reliable and trustworthy AI. The core idea behind NeSy AI is to combine neural and symbolic steps: neural networks are typically responsible for mapping low-level inputs into high-level symbolic concepts, while symbolic reasoning infers predictions compatible with the extracted concepts and the prior knowledge. Despite their promise, it was recently shown that - whenever the concepts are not supervised directly - NeSy models can be affected by Reasoning Shortcuts (RSs). That is, they can achieve high label accuracy by grounding the concepts incorrectly. RSs can compromise the interpretability of the model's explanations, performance in out-of-distribution scenarios, and therefore reliability. At the same time, RSs are difficult to detect and prevent unless concept supervision is available, which is typically not the case. However, the literature on RSs is scattered, making it difficult for researchers and practitioners to understand and tackle this challenging problem. This overview addresses this issue by providing a gentle introduction to RSs, discussing their causes and consequences in intuitive terms. It also reviews and elucidates existing theoretical characterizations of this phenomenon. Finally, it details methods for dealing with RSs, including mitigation and awareness strategies, and maps their benefits and limitations. By reformulating advanced material in a digestible form, this overview aims to provide a unifying perspective on RSs to lower the bar to entry for tackling them. Ultimately, we hope this overview contributes to the development of reliable NeSy and trustworthy AI models.

## How to cite

```
@article{marconato2026symbol,
  author       = {Emanuele Marconato and
                  Samuele Bortolotti and
                  Emile van Krieken and
                  Paolo Morettin and
                  Elena Umili and
                  Antonio Vergari and
                  Efthymia Tsamoura and
                  Andrea Passerini and
                  Stefano Teso},
  title        = {Symbol Grounding in Neuro-Symbolic {AI:} {A} Gentle Introduction to
                  Reasoning Shortcuts},
  journal      = {J. Artif. Intell. Res.},
  volume       = {86},
  year         = {2026},
  url          = {https://doi.org/10.1613/jair.1.22389},
  doi          = {10.1613/JAIR.1.22389}
}
```

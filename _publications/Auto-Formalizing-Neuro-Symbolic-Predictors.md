---
layout: post
permalink: /publications/Auto-Formalizing-Neuro-Symbolic-Predictors.html
title: Auto-Formalizing Neuro-Symbolic Predictors
date: 2026-10-01
redirect_from:
  - /en/publications/Auto-Formalizing-Neuro-Symbolic-Predictors.html
  - /it/publications/Auto-Formalizing-Neuro-Symbolic-Predictors.html
  - /de/publications/Auto-Formalizing-Neuro-Symbolic-Predictors.html
ref: publications
authors:
  - Samuele Bortolotti
  - Weixin Chen
  - Han Zhao
  - Andrea Passerini
  - Stefano Teso
  - Antonio Vergari
conference: arXiv preprint
conference_url: https://arxiv.org/abs/2610.01519
paper: https://arxiv.org/pdf/2610.01519
lang: en
nav_bar: publications
---

# Auto-Formalizing Neuro-Symbolic Predictors

## Abstract

Neuro-Symbolic (NeSy) predictors incorporate prior knowledge into the prediction process of neural networks, ensuring that outputs satisfy specified constraints, making them particularly suitable for high-stakes applications where compliance with domain knowledge is essential. A key bottleneck in this paradigm is the acquisition of symbolic constraints: encoding domain knowledge into logical formulas remains a manual and expert-intensive process. In this work, we investigate the extent to which auto-formalization via LLMs can systematically translate textual knowledge into symbolic knowledge that can be plugged into NeSy predictors. To this end, we introduce auto-nesy-bench, a new benchmark for evaluating constraint formalization and its impact on downstream accuracy of NeSy predictors. Through an extensive evaluation across several domains, we find that LLMs can formalize constraints to a meaningful extent, generating formulas that are often similar to those provided by human experts. Moreover, when the generated formulas are syntactically valid, they can lead to high-quality downstream predictions. The code and benchmark are available at [https://unitn-sml.github.io/auto-nesy-bench/](https://unitn-sml.github.io/auto-nesy-bench/).

## How to cite

```
@misc{bortolotti2026autoformalizing,
 title={Auto-Formalizing Neuro-Symbolic Predictors}, 
 author={Samuele Bortolotti* and Weixin Chen* and Han Zhao and Andrea Passerini and Stefano Teso and Antonio Vergari},
 year={2026},
 eprint={2610.01519},
 archivePrefix={arXiv},
 primaryClass={cs.LG},
 url={https://arxiv.org/abs/2610.01519}, 
 booktitle={Under Review}
}
```

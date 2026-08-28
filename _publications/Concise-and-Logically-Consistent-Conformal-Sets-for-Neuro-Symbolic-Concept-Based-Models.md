---
layout: post
permalink: /publications/Concise-and-Logically-Consistent-Conformal-Sets-for-Neuro-Symbolic-Concept-Based-Models.html
title: Concise and Logically Consistent Conformal Sets for Neuro-Symbolic Concept-Based Models
date: 2026-05-01
redirect_from:
  - /en/publications/Concise-and-Logically-Consistent-Conformal-Sets-for-Neuro-Symbolic-Concept-Based-Models.html
  - /it/publications/Concise-and-Logically-Consistent-Conformal-Sets-for-Neuro-Symbolic-Concept-Based-Models.html
  - /de/publications/Concise-and-Logically-Consistent-Conformal-Sets-for-Neuro-Symbolic-Concept-Based-Models.html
ref: publications
authors:
  - Samuele Bortolotti
  - Emanuele Marconato
  - Andrea Pugnana
  - Andrea Passerini
  - Stefano Teso
conference: arXiv preprint
conference_url: https://arxiv.org/abs/2605.18202
paper: https://arxiv.org/pdf/2605.18202
lang: en
nav_bar: publications
dblp_key: journals/corr/abs-2605-18202
dblp_url: https://dblp.org/rec/journals/corr/abs-2605-18202.html
dblp_keys: journals/corr/abs-2605-18202
---

# Concise and Logically Consistent Conformal Sets for Neuro-Symbolic Concept-Based Models

## Abstract

Neuro-Symbolic Concept-based Models (NeSy-CBMs) are a family of architectures that integrate neural networks with symbolic reasoning for enhanced reliability in high-stakes applications. They work by first extracting high-level concepts from the input and then inferring a task label from these compatibly with given logical constraints. Yet, their label and concept predictions can be overconfident, making it difficult for stakeholders to gauge when the model's decisions can be trusted. We address this issue by integrating ideas from Conformal Prediction (CP), a framework providing rigorous, distribution-free coverage guarantees. We formalize three desiderata -- consistency, coverage, and conciseness -- that any conformal method for NeSy-CBMs should satisfy, and show that existing approaches fall short of at least one. We then introduce COCOCO, a post-hoc framework that conformalizes concepts and labels jointly and reconciles them via a single deduction-abduction revision step. COCOCO satisfies all three desiderata, retains distribution-free coverage, is robust to imperfect knowledge and supports user-specified size budgets. Our experiments on 8 data sets highlight how COCOCO compares favorably against competitors and natural baselines in terms of performance and set size.

## How to cite

```
@misc{bortolotti2026concise,
  author        = {Samuele Bortolotti and
                   Emanuele Marconato and
                   Andrea Pugnana and
                   Andrea Passerini and
                   Stefano Teso},
  title         = {Concise and Logically Consistent Conformal Sets for Neuro-Symbolic
                   Concept-Based Models},
  booktitle     = {arXiv preprint},
  year          = {2026},
  eprint        = {2605.18202},
  archivePrefix = {arXiv},
  primaryClass  = {cs.LG},
  url           = {https://doi.org/10.48550/arXiv.2605.18202},
  doi           = {10.48550/ARXIV.2605.18202}
}
```

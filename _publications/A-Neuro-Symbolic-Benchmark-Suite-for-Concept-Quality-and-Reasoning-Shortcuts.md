---
layout: post
permalink: /publications/A-Neuro-Symbolic-Benchmark-Suite-for-Concept-Quality-and-Reasoning-Shortcuts.html
title: A Neuro-Symbolic Benchmark Suite for Concept Quality and Reasoning Shortcuts
date: 2024-06-14
redirect_from:
  - /en/publications/A-Neuro-Symbolic-Benchmark-Suite-for-Concept-Quality-and-Reasoning-Shortcuts.html
  - /it/publications/A-Neuro-Symbolic-Benchmark-Suite-for-Concept-Quality-and-Reasoning-Shortcuts.html
  - /de/publications/A-Neuro-Symbolic-Benchmark-Suite-for-Concept-Quality-and-Reasoning-Shortcuts.html
ref: /publications/A-Neuro-Symbolic-Benchmark-Suite-for-Concept-Quality-and-Reasoning-Shortcuts.html
authors:
  - Samuele Bortolotti
  - Emanuele Marconato
  - Tommaso Carraro
  - Paolo Morettin
  - Emile van Krieken
  - Antonio Vergari
  - Stefano Teso
  - Andrea Passerini
conference: NeurIPS 2024
lang: en
ref: publications
conference_url: https://neurips.cc/Conferences/2024
paper: https://proceedings.neurips.cc/paper_files/paper/2024/hash/d1d11bf8299334d354949ba8738e8301-Abstract-Datasets_and_Benchmarks_Track.html
nav_bar: publications
---

# A Neuro-Symbolic Benchmark Suite for Concept Quality and Reasoning Shortcuts

## Abstract

The advent of powerful neural classifiers has increased interest in problems that require both learning and reasoning. These problems are critical for understanding important properties of models, such as trustworthiness, generalization, interpretability, and compliance to safety and structural constraints. However, recent research observed that tasks requiring both learning and reasoning on background knowledge often suffer from reasoning shortcuts (RSs): predictors can solve the downstream reasoning task without associating the correct concepts to the high-dimensional data. To address this issue, we introduce rsbench, a comprehensive benchmark suite designed to systematically evaluate the impact of RSs on models by providing easy access to highly customizable tasks affected by RSs. Furthermore, rsbench implements common metrics for evaluating concept quality and introduces novel formal verification procedures for assessing the presence of RSs in learning tasks. Using rsbench, we highlight that obtaining high quality concepts in both purely neural and neuro-symbolic models is a far-from-solved problem. rsbench is available at [https://unitn-sml.github.io/rsbench/](https://unitn-sml.github.io/rsbench/).

## How to cite

```
@inproceedings{bortolotti2024benchmark,
  author = {Bortolotti, Samuele and Marconato, Emanuele and Carraro, Tommaso and Morettin, Paolo and van Krieken, Emile and Vergari, Antonio and Teso, Stefano and Passerini, Andrea},
  booktitle = {Advances in Neural Information Processing Systems},
  editor = {A. Globerson and L. Mackey and D. Belgrave and A. Fan and U. Paquet and J. Tomczak and C. Zhang},
  pages = {115861--115905},
  publisher = {Curran Associates, Inc.},
  title = {A Neuro-Symbolic Benchmark Suite for Concept Quality and Reasoning Shortcuts},
  url = {https://proceedings.neurips.cc/paper_files/paper/2024/file/d1d11bf8299334d354949ba8738e8301-Paper-Datasets_and_Benchmarks_Track.pdf},
  volume = {37},
  year = {2024}
}
```

<!-- ## Posters

### [NeurIPS 2024](https://neurips.cc/Conferences/2024)

<object data="/posters/2024_benchmark_nips.pdf" type="application/pdf" width="100%" height="100%" margin="auto">
    <embed src="/posters/2024_benchmark_nips.pdf" type="application/pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="/posters/2024_benchmark_nips.pdf">Download PDF</a>.</p>
    </embed>
</object>

## Slides

### [NeurIPS 2024](https://neurips.cc/virtual/2024/poster/97846)

<object data="/slides/Benchmark_slides_nips24.pdf" type="application/pdf" width="100%" height="100%" margin="auto">
    <embed src="/slides/Benchmark_slides_nips24.pdf" type="application/pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="/slides/Benchmark_slides_nips24.pdf">Download PDF</a>.</p>
    </embed>
</object> -->
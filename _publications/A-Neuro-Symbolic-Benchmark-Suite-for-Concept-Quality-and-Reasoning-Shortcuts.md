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
paper: https://openreview.net/forum?id=5VtI484yVy
nav_bar: publications
---

# A Neuro-Symbolic Benchmark Suite for Concept Quality and Reasoning Shortcuts

## Abstract

The advent of powerful neural classifiers has increased interest in problems that require both learning and reasoning. These problems are critical for understanding important properties of models, such as trustworthiness, generalization, interpretability, and compliance to safety and structural constraints. However, recent research observed that tasks requiring both learning and reasoning on background knowledge often suffer from reasoning shortcuts (RSs): predictors can solve the downstream reasoning task without associating the correct concepts to the high-dimensional data. To address this issue, we introduce rsbench, a comprehensive benchmark suite designed to systematically evaluate the impact of RSs on models by providing easy access to highly customizable tasks affected by RSs. Furthermore, rsbench implements common metrics for evaluating concept quality and introduces novel formal verification procedures for assessing the presence of RSs in learning tasks. Using rsbench, we highlight that obtaining high quality concepts in both purely neural and neuro-symbolic models is a far-from-solved problem. rsbench is available at [https://unitn-sml.github.io/rsbench/](https://unitn-sml.github.io/rsbench/).

## How to cite

```
@inproceedings{bortolotti2024benchmark,
  title={A Neuro-Symbolic Benchmark Suite for Concept Quality and Reasoning Shortcuts},
  author={Samuele Bortolotti and Emanuele Marconato and Tommaso Carraro and Paolo Morettin and Emile van Krieken and Antonio Vergari and Stefano Teso and Andrea Passerini},
  booktitle={The Thirty-eight Conference on Neural Information Processing Systems Datasets and Benchmarks Track},
  year={2024},
  abstract={The advent of powerful neural classifiers has increased interest in problems that require both learning and reasoning. These problems are critical for understanding important properties of models, such as trustworthiness, generalization, interpretability, and compliance to safety and structural constraints. However, recent research observed that tasks requiring both learning and reasoning on background knowledge often suffer from reasoning shortcuts (RSs): predictors can solve the downstream reasoning task without associating the correct concepts to the high-dimensional data. To address this issue, we introduce rsbench, a comprehensive benchmark suite designed to systematically evaluate the impact of RSs on models by providing easy access to highly customizable tasks affected by RSs. Furthermore, rsbench implements common metrics for evaluating concept quality and introduces novel formal verification procedures for assessing the presence of RSs in learning tasks. Using rsbench, we highlight that obtaining high quality concepts in both purely neural and neuro-symbolic models is a far-from-solved problem. rsbench is available at: https://unitn-sml.github.io/rsbench.},
  url={https://openreview.net/forum?id=5VtI484yVy}
}
```
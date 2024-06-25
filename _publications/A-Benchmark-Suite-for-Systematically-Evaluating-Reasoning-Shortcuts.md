---
layout: post
permalink: /publications/A-Benchmark-Suite-for-Systematically-Evaluating-Reasoning-Shortcuts.html
title: A Benchmark Suite for Systematically Evaluating Reasoning Shortcuts
date: 2024-06-14
redirect_from:
  - /en/publications/A-Benchmark-Suite-for-Systematically-Evaluating-Reasoning-Shortcuts.html
  - /it/publications/A-Benchmark-Suite-for-Systematically-Evaluating-Reasoning-Shortcuts.html
  - /de/publications/A-Benchmark-Suite-for-Systematically-Evaluating-Reasoning-Shortcuts.html
ref: /publications/A-Benchmark-Suite-for-Systematically-Evaluating-Reasoning-Shortcuts.html
authors:
  - Samuele Bortolotti
  - Emanuele Marconato
  - Tommaso Carraro
  - Paolo Morettin
  - Emile van Krieken
  - Antonio Vergari
  - Stefano Teso
  - Andrea Passerini
conference: ArXiv Pre-print
lang: en
ref: publications
conference_url: https://arxiv.org/abs/2406.10368
paper: https://arxiv.org/pdf/2406.10368.pdf
nav_bar: publications
---

# A Benchmark Suite for Systematically Evaluating Reasoning Shortcuts

## Abstract

The advent of powerful neural classifiers has increased interest in problems that require both learning and reasoning. These problems are critical for understanding important properties of models, such as trustworthiness, generalization, interpretability, and compliance to safety and structural constraints. However, recent research observed that tasks requiring both learning and reasoning on background knowledge often suffer from reasoning shortcuts (RSs): predictors can solve the downstream reasoning task without associating the correct concepts to the high-dimensional data. To address this issue, we introduce rsbench, a comprehensive benchmark suite designed to systematically evaluate the impact of RSs on models by providing easy access to highly customizable tasks affected by RSs. Furthermore, rsbench implements common metrics for evaluating concept quality and introduces novel formal verification procedures for assessing the presence of RSs in learning tasks. Using rsbench, we highlight that obtaining high quality concepts in both purely neural and neuro-symbolic models is a far-from-solved problem. rsbench is available at [https://unitn-sml.github.io/rsbench/](https://unitn-sml.github.io/rsbench/).

## How to cite

```
@misc{bortolotti2024benchmark,
      title={A Benchmark Suite for Systematically Evaluating Reasoning Shortcuts}, 
      author={Samuele Bortolotti and Emanuele Marconato and Tommaso Carraro and Paolo Morettin and Emile van Krieken and Antonio Vergari and Stefano Teso and Andrea Passerini},
      year={2024},
      eprint={2406.10368},
      archivePrefix={arXiv},
      primaryClass={id='cs.LG' full_name='Machine Learning' is_active=True alt_name=None in_archive='cs' is_general=False description='Papers on all aspects of machine learning research (supervised, unsupervised, reinforcement learning, bandit problems, and so on) including also robustness, explanation, fairness, and methodology. cs.LG is also an appropriate primary category for applications of machine learning methods.'}
}
```
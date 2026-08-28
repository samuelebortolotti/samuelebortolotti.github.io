---
layout: post
permalink: /publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
title: BEARS Make Neuro-Symbolic Models Aware of their Reasoning Shortcuts
date: 2024-07-01
redirect_from:
  - /en/publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
  - /it/publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
  - /de/publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
ref: publications
authors:
  - Emanuele Marconato
  - Samuele Bortolotti
  - Emile van Krieken
  - Antonio Vergari
  - Andrea Passerini
  - Stefano Teso
conference: UAI 2024
lang: en
conference_url: https://www.auai.org/uai2024/
paper: https://proceedings.mlr.press/v244/marconato24a.html
nav_bar: publications
dblp_key: conf/uai/MarconatoBKVPT24
dblp_url: https://dblp.org/rec/conf/uai/MarconatoBKVPT24.html
dblp_keys: conf/uai/MarconatoBKVPT24, journals/corr/abs-2402-12240
---

# BEARS Make Neuro-Symbolic Models Aware of their Reasoning Shortcuts

## Abstract

Neuro-Symbolic (NeSy) predictors that conform to symbolic knowledge - encoding, e.g., safety constraints - can be affected by Reasoning Shortcuts (RSs): They learn concepts consistent with the symbolic knowledge by exploiting unintended semantics. RSs compromise reliability and generalization and, as we show in this paper, they are linked to NeSy models being overconfident about the predicted concepts. Unfortunately, the only trustworthy mitigation strategy requires collecting costly dense supervision over the concepts. Rather than attempting to avoid RSs altogether, we propose to ensure NeSy models are aware of the semantic ambiguity of the concepts they learn, thus enabling their users to identify and distrust low-quality concepts. Starting from three simple desiderata, we derive bears (BE Aware of Reasoning Shortcuts), an ensembling technique that calibrates the model's concept-level confidence without compromising prediction accuracy, thus encouraging NeSy architectures to be uncertain about concepts affected by RSs. We show empirically that bears improves RS-awareness of several state-of-the-art NeSy models, and also facilitates acquiring informative dense annotations for mitigation purposes. 

## How to cite

```
@InProceedings{marconato24bears,
  title = 	 {BEARS Make Neuro-Symbolic Models Aware of their Reasoning Shortcuts},
  author =       {Marconato, Emanuele and Bortolotti, Samuele and van Krieken, Emile and Vergari, Antonio and Passerini, Andrea and Teso, Stefano},
  booktitle = 	 {Proceedings of the Fortieth Conference on Uncertainty in Artificial Intelligence},
  pages = 	 {2399--2433},
  year = 	 {2024},
  editor = 	 {Kiyavash, Negar and Mooij, Joris M.},
  volume = 	 {244},
  series = 	 {Proceedings of Machine Learning Research},
  month = 	 {15--19 Jul},
  publisher =    {PMLR},
  pdf = 	 {https://raw.githubusercontent.com/mlresearch/v244/main/assets/marconato24a/marconato24a.pdf},
  url = 	 {https://proceedings.mlr.press/v244/marconato24a.html},
  abstract = 	 {Neuro-Symbolic (NeSy) predictors that conform to symbolic knowledge {–} encoding, e.g., safety constraints {–} can be affected by Reasoning Shortcuts (RSs): They learn concepts consistent with the symbolic knowledge by exploiting unintended semantics. RSs compromise reliability and generalization and, as we show in this paper, they are linked to NeSy models being overconfident about the predicted concepts. Unfortunately, the only trustworthy mitigation strategy requires collecting costly dense supervision over the concepts. Rather than attempting to avoid RSs altogether, we propose to ensure NeSy models are aware of the semantic ambiguity of the concepts they learn, thus enabling their users to identify and distrust low-quality concepts. Starting from three simple desiderata, we derive bears (BE Aware of Reasoning Shortcuts), an ensembling technique that calibrates the model’s concept-level confidence without compromising prediction accuracy, thus encouraging NeSy architectures to be uncertain about concepts affected by RSs. We show empirically that bears improves RS-awareness of several state-of-the-art NeSy models, and also facilitates acquiring informative dense annotations for mitigation purposes.}
}
```
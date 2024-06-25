---
layout: post
permalink: /publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
title: BEARS Make Neuro-Symbolic Models Aware of their Reasoning Shortcuts
date: 2024-02-20
redirect_from:
  - /en/publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
  - /it/publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
  - /de/publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
ref: /publications/BEARS-Make-Neuro-Symbolic-Models-Aware-of-their-Reasoning-Shortcuts.html
authors:
  - Emanuele Marconato
  - Samuele Bortolotti
  - Emile van Krieken
  - Antonio Vergari
  - Andrea Passerini
  - Stefano Teso
conference: UAI2024
lang: en
ref: publications
conference_url: https://arxiv.org/abs/2402.12240
paper: https://arxiv.org/pdf/2402.12240.pdf
nav_bar: publications
---

# BEARS Make Neuro-Symbolic Models Aware of their Reasoning Shortcuts

## Abstract

Neuro-Symbolic (NeSy) predictors that conform to symbolic knowledge - encoding, e.g., safety constraints - can be affected by Reasoning Shortcuts (RSs): They learn concepts consistent with the symbolic knowledge by exploiting unintended semantics. RSs compromise reliability and generalization and, as we show in this paper, they are linked to NeSy models being overconfident about the predicted concepts. Unfortunately, the only trustworthy mitigation strategy requires collecting costly dense supervision over the concepts. Rather than attempting to avoid RSs altogether, we propose to ensure NeSy models are aware of the semantic ambiguity of the concepts they learn, thus enabling their users to identify and distrust low-quality concepts. Starting from three simple desiderata, we derive bears (BE Aware of Reasoning Shortcuts), an ensembling technique that calibrates the model's concept-level confidence without compromising prediction accuracy, thus encouraging NeSy architectures to be uncertain about concepts affected by RSs. We show empirically that bears improves RS-awareness of several state-of-the-art NeSy models, and also facilitates acquiring informative dense annotations for mitigation purposes. 

## How to cite

```
@misc{marconato2024bears,
      title={BEARS Make Neuro-Symbolic Models Aware of their Reasoning Shortcuts}, 
      author={Emanuele Marconato and Samuele Bortolotti and Emile van Krieken and Antonio Vergari and Andrea Passerini and Stefano Teso},
      year={2024},
      eprint={2402.12240},
      archivePrefix={arXiv},
      primaryClass={cs.LG}
}
```

## Posters

### [ICT days 2024](https://www.ictdays.it/en/home-en/)

<object data="/posters/2024_bears_ictdays.pdf" type="application/pdf" width="425px" height="600px" margin="auto">
    <embed src="/posters/2024_bears_ictdays.pdf" type="application/pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="/posters/2024_bears_ictdays.pdf">Download PDF</a>.</p>
    </embed>
</object>


### [Nordic Probabilistic AI School 2024](https://nordic.probabilistic.ai/)

<object data="/posters/2024_bears_probai.pdf" type="application/pdf" width="425px" height="600px" margin="auto">
    <embed src="/posters/2024_bears_probai.pdf" type="application/pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="/posters/2024_bears_probai.pdf">Download PDF</a>.</p>
    </embed>
</object>
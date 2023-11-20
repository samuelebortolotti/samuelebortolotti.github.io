---
layout: post
title: Master Thesis
lang: en
date: 2023-10-18
permalink: projects/master-thesis.html
ref: projects/master-thesis.html
repository: https://github.com/samuelebortolotti/master-thesis
url: https://github.com/samuelebortolotti/master-thesis
report: https://github.com/samuelebortolotti/master-thesis/tree/master/thesis/src
author: 
- Samuele Bortolotti
nav_bar: projects
type: project
description: This project represents my master's thesis for a Computer Science degree at the University of Trento. It pioneers an interactive debugging protocol merging Interactive Machine Learning and Neuro-Symbolic AI. It introduces a multi-round approach for comprehensive model debugging, automatically extracting relevant arguments, and facilitating user-machine dialogues. With successful bug correction, argument selection, and identification of confounding sources, it sets the stage for enhanced interactive debugging in complex machine learning models.
---

# Master Thesis

## Project Overview

This thesis explores the convergence of Interactive Machine Learning and Neuro-Symbolic Artificial Intelligence. The primary objective is to develop an interactive debugging protocol for hierarchical classifiers. Current methods for explanatory debugging in machine learning are often limited to *one-shot* interactions, where the machine provides explanations for individual predictions. This project addresses the need for more comprehensive debugging by proposing a *multi-round* interaction approach. This approach facilitates structured arguments between the machine and the user to validate or challenge predictions and model-related statements.

## Objectives

1. **Multi-Round Interaction:** Develop a multi-round interaction approach to enable more extensive debugging compared to one-shot interactions.

2. **Automated Argument Extraction:** Automatically extract relevant arguments from the model using eXplainable Artificial Intelligence (XAI) relevance measures.

3. **User-Model Interaction:** Facilitate dialogical interaction between the user and the machine, allowing structured arguments for debugging.

4. **Model Validation:** Validate the effectiveness of the interactive debugging protocol on Neuro-Symbolic architectures, including [Coherent Hierarchical Multi-Label Classification Networks](https://proceedings.neurips.cc/paper_files/paper/2020/file/6dd4e10e3296fa63738371ec0d5df818-Paper.pdf) and [Semantic Probabilistic Layers](https://openreview.net/pdf?id=o-mxIWAY1T8).

5. **Feasibility of Bug Correction:** Investigate the feasibility of correcting Neuro-Symbolic models with prior knowledge of underlying bugs.

## Key Results:

- Correction of confounded model beliefs: this project demonstrates that correcting model beliefs is achievable, especially when prior knowledge of the type of bugs is available.

- Argument selection: This thesis identified metrics for argument selection outperform random selection, reducing interaction time and user annoyance.

- Identifying sources of confounding: The project explores metrics, such as gradients and entropies, for identifying sources of confounding in model predictions.

- Explanatory debugging framework: Combining confounding as a relevance measure and effective debugging, the groundwork for an explanatory debugging process is established.

## Future Directions:

- Incorporate Additional Labels: Expand the work by including additional labels that encompass inter-class concepts, allowing for the correction of label-related bugs across the hierarchy.

- Human-in-the-Loop and SPL: Further investigate the relationship between human-in-the-loop techniques and SPL, addressing challenges to enhance model trustworthiness.

- Model Uncertainty Estimation: Explore strategies for accurate model uncertainty estimation, differentiating between aleatoric and epistemic uncertainties.

- User Interaction Evaluation: Assess the overall procedure's efficacy with real-life users through surveys and questionnaires, gathering qualitative feedback.

## Conclusion

This project introduces an innovative interactive debugging protocol that extends beyond one-shot interactions. While serving as a starting point, it has the potential to significantly influence future research in Interactive Machine Learning and Neuro-Symbolic AI.
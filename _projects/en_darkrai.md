---
layout: post
title: DarkrAI
lang: en
date: 2022-10-1
permalink: projects/darkrai.html
ref: projects/darkrai.html
repository: https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL
url: https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL
report: https://github.com/Simone-Alghisi/pareto-epsilon-greedy-RL/blob/master/report/main.pdf
author: 
- Samuele Bortolotti
- Simone Alghisi
- Massimo Rizzoli
- Erich Robbi
nav_bar: projects
type: project
description: DarkrAI is a project which consists in training two epsilon-greedy reinforcement learning agents for Pokémon battles. It has been developed for the University of Trento's Computer Science master's program as part of the Bio-Inspired Artificial Intelligence course.
---

# DarkrAI: a Pareto ε-greedy policy

## General information

This project explores the use of bio-inspired techniques to enhance reinforcement learning (RL) performance and accelerate the learning process. Specifically, we focus on training RL agents for Pokémon battles, a complex domain with numerous possible outcomes in each turn.

### Approach

We've devised a novel approach that combines various elements:

1. **Damage Calculator**: To accurately assess the impact of Pokémon moves, we've set up a node server interfacing with a damage calculator API server. This infrastructure provides precise data on move effects.

2. **NSGA-II Optimization**: We employ the NSGA-II genetic algorithm to solve a multi-objective optimization problem. NSGA-II identifies Pareto optimal moves that Pokémon can make in a given turn, enhancing decision-making.

3. **Artificial Neural Network (ANN)**: We've designed an ANN, whose weights are learned through RL. This network aids in optimizing Pokémon actions.

4. **Training Environment**: We utilize Pokémon Showdown, an online battle simulator, as our training environment. The `poke-env` Python library facilitates communication with the simulator and enables the development of custom trainable agents.

5. **Data from Pikalytics**: To address uncertainties about the opponent's Pokémon, we incorporate data from Pikalytics, offering competitive analysis and team-building insights.

### Results

Our experiments demonstrate promising results. The ParetoPlayer, an agent trained with our approach, shows the potential to improve training by providing higher rewards. However, in situations with a small search space and a single win condition, Player outperforms ParetoPlayer.

We acknowledge that further optimization, exploration of hyperparameters, and network topology adjustments could enhance results. Challenges include the time-consuming nature of NSGA-II, which currently relies on CPU computation, and addressing forced switches, a separate network issue.

For comprehensive details, methodology, implementation choices, and results, refer to our [report](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/report/main.pdf) and [presentation slides](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/presentation/main.pdf).

![Pokémon Battle](https://raw.githubusercontent.com/samuelebortolotti/pareto-epsilon-greedy-RL/master/presentation/assets/2v2_fixed.gif){: width="100%"}

Our statistical tests include:

- [`normality.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/normality.R): Tests the normality of reward differences between two RL runs.
- [`regression.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/regression.R) (Obsolete): Produces a regression line from average episode rewards.
- [`10_runs_agg.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/10_runs_agg.r): Generates a regression line and performs a Kolmogorov-Smirnov test on average episode rewards.
- [`significance_if_not_normal.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/significance_if_not_normal.R): Conducts a Wilcoxon rank-sum test on episode reward data.
- [`significance_if_normal.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/significance_if_normal.R): Runs a Student's t-test on episode reward data.

For more information on our statistical tests, consult the [analysis README](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/README.md).

## Contributors
- Samuele Bortolotti
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Massimo Rizzoli](https://github.com/massimo-rizzoli)
- [Erich Robbi](https://github.com/erich-r)
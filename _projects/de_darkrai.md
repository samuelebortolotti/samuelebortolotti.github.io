---
layout: post
title: DarkrAI
lang: de
date: 2022-10-1
permalink: de/projects/darkrai.html
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
description: DarkrAI ist ein Projekt, bei dem zwei Epsilon-Greedy-Verstärkungslernagenten für Pokémon-Kämpfe trainiert werden. Es wurde für den Informatik-Masterstudiengang der Universität Trient im Rahmen des Kurses "Bio-Inspired Artificial Intelligence" entwickelt.
---

# DarkrAI: a Pareto ε-greedy policy

## Allgemeine Informationen

Dieses Projekt erforscht den Einsatz von bio-inspirierten Techniken, um die Leistung von Reinforcement Learning (RL) zu verbessern und den Lernprozess zu beschleunigen. Insbesondere konzentrieren wir uns auf das Training von RL-Agenten für Pokémon-Kämpfe, ein komplexes Gebiet mit zahlreichen möglichen Ergebnissen in jeder Runde.

### Ansatz

Wir haben einen neuen Ansatz entwickelt, der verschiedene Elemente kombiniert:

1. **Schadensberechnung**: Um die Auswirkungen von Pokémon-Zügen genau zu bewerten, haben wir einen Node-Server eingerichtet, der mit einem API-Server für Schadensberechnungen verbunden ist. Diese Infrastruktur liefert präzise Daten über die Auswirkungen von Zügen.

2. **NSGA-II-Optimierung**: Wir setzen den genetischen Algorithmus NSGA-II ein, um ein multikriterielles Optimierungsproblem zu lösen. NSGA-II identifiziert Pareto-optimale Züge, die Pokémon in einer bestimmten Runde ausführen können, und verbessert so die Entscheidungsfindung.

3. **Künstliches Neuronales Netz (ANN)**: Wir haben ein ANN entwickelt, dessen Gewichte durch RL gelernt werden. Dieses Netzwerk hilft bei der Optimierung von Pokémon-Aktionen.

4. **Trainingsumgebung**: Wir verwenden Pokémon Showdown, einen Online-Kampfsimulator, als Trainingsumgebung. Die Python-Bibliothek "poke-env" erleichtert die Kommunikation mit dem Simulator und ermöglicht die Entwicklung von benutzerdefinierten trainierbaren Agenten.

5. **Daten von Pikalytics**: Um Unsicherheiten über die Pokémon des Gegners zu beseitigen, beziehen wir Daten von Pikalytics ein, die Wettbewerbsanalysen und Erkenntnisse zur Teambildung bieten.

### Ergebnisse

Unsere Experimente zeigen vielversprechende Ergebnisse. Der ParetoPlayer, ein mit unserem Ansatz trainierter Agent, zeigt das Potenzial, das Training durch höhere Belohnungen zu verbessern. In Situationen mit einem kleinen Suchraum und einer einzigen Gewinnbedingung übertrifft Player jedoch ParetoPlayer.

Wir erkennen an, dass weitere Optimierungen, die Erforschung von Hyperparametern und Anpassungen der Netzwerktopologie die Ergebnisse verbessern könnten. Zu den Herausforderungen gehören die zeitaufwändige Natur von NSGA-II, das derzeit auf CPU-Berechnungen angewiesen ist, und die Bewältigung erzwungener Wechsel, ein separates Netzwerkproblem.

Umfassende Details, Methodik, Umsetzungsentscheidungen und Ergebnisse finden Sie in unserem [Bericht](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/report/main.pdf) und [Präsentationsfolien](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/presentation/main.pdf).

![Pokémon Battle](https://raw.githubusercontent.com/samuelebortolotti/pareto-epsilon-greedy-RL/master/presentation/assets/2v2_fixed.gif){: width="100%"}

Unsere statistischen Tests umfassen:

- [`normality.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/normality.R): Testet die Normalität der Belohnungsunterschiede zwischen zwei RL-Läufen.
- [`regression.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/regression.R) (Veraltet): Erzeugt eine Regressionslinie aus durchschnittlichen Episodenbelohnungen.
- [`10_runs_agg.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/10_runs_agg.r): Erzeugt eine Regressionsgerade und führt einen Kolmogorov-Smirnov-Test für durchschnittliche Episodenbelohnungen durch.
- [`significance_if_not_normal.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/significance_if_not_normal.R): Führt einen Wilcoxon-Rangsummentest für Episodenbelohnungsdaten durch.
- [significance_if_normal.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/significance_if_normal.R): Führt einen Student's t-Test für Episodenbelohnungsdaten durch.

Weitere Informationen zu unseren statistischen Tests finden Sie in der [analysis README](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/README.md).

## Mitwirkende
- Samuele Bortolotti
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Massimo Rizzoli](https://github.com/massimo-rizzoli)
- [Erich Robbi](https://github.com/erich-r)
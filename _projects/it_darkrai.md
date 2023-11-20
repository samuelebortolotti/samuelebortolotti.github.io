---
layout: post
title: DarkrAI
lang: it
date: 2022-10-1
permalink: it/projects/darkrai.html
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
description: DarkrAI è un progetto che consiste nell'addestramento di due epsilon-greedy agents di reinforcement learning per le battaglie di Pokémon. È stato sviluppato per il corso di laurea magistrale in Informatica dell'Università di Trento nell'ambito del corso di Bio-Inspired Artificial Intelligence.
---

# DarkrAI: a Pareto ε-greedy policy

## Informazioni generali

Questo progetto esplora l'uso di tecniche di ottimizzazione derivate dalla biologia per migliorare le prestazioni di un agente di reinforcement learning (RL) e accelerare il processo di apprendimento. In particolare, ci concentriamo sull'addestramento di RL agents per le battaglie Pokémon, un dominio complesso con numerosi esiti possibili in ogni turno.

### Approccio

Abbiamo ideato un approccio che combina diversi elementi:

1. **Calcolatore i danni**: Per valutare con precisione l'impatto delle mosse dei Pokémon, abbiamo creato un server NodeJS che si interfaccia con un server per il calcolo dei danni mediante apposite API. Questa infrastruttura fornisce dati precisi sugli effetti delle mosse.

2. **Ottimizzazione mediante NSGA-II**: Utilizziamo l'algoritmo genetico NSGA-II per risolvere un problema di ottimizzazione multi-obiettivo. NSGA-II identifica le mosse Pareto ottimali che i Pokémon possono fare in un determinato turno, migliorando il processo decisionale.

3. **Artificial Neural Network (ANN)**: Abbiamo progettato una ANN, i cui pesi vengono appresi tramite RL. Questa rete aiuta a ottimizzare le azioni dei Pokémon.

4. **Ambiente di allenamento**: Utilizziamo Pokémon Showdown, un simulatore di battaglie online, come ambiente di allenamento. La libreria Python `poke-env` facilita la comunicazione con il simulatore e consente lo sviluppo di agenti addestrabili personalizzati.

5. **Dati di Pikalytics**: Per risolvere le incertezze sui Pokémon dell'avversario, incorporiamo i dati di Pikalytics, che offrono approfondimenti sulla costruzione della squadra avversaria.

### Risultati

I nostri esperimenti mostrano risultati promettenti. ParetoPlayer, un agente addestrato con il nostro approccio, mostra del potenziale per migliorare l'addestramento fornendo ricompense più elevate. Tuttavia, in situazioni con uno spazio di ricerca ridotto e una singola condizione di vittoria, Player supera ParetoPlayer.

Riconosciamo che ulteriori ottimizzazioni, l'esplorazione degli iperparametri e la regolazione della topologia della rete potrebbero migliorare i risultati. Le sfide includono la natura dispendiosa in termini di tempo di NSGA-II, che attualmente si basa su CPU, e la risoluzione degli switch forzati.

Per i dettagli completi, la metodologia, le scelte di implementazione e i risultati, consultare la [relazione](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/report/main.pdf) e le [slides della presentazione](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/presentation/main.pdf).

![Battaglia Pokémon](https://raw.githubusercontent.com/samuelebortolotti/pareto-epsilon-greedy-RL/master/presentation/assets/2v2_fixed.gif){: width="100%"}

I nostri test statistici includono:

- [`normalità.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/normality.R): Verifica la normalità delle differenze di ricompensa tra due run di RL.
- [`regression.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/regression.R) (Obsoleto): Produce una retta di regressione a partire dalle ricompense medie degli episodi.
- [`10_runs_agg.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/10_runs_agg.r): Genera una retta di regressione ed esegue un test di Kolmogorov-Smirnov sulle ricompense medie degli episodi.
- [`significance_if_not_normal.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/significance_if_not_normal.R): Esegue un test Wilcoxon rank-sum sui dati delle ricompense degli episodi.
- [`significance_if_normal.R`](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/significance_if_normal.R): Esegue un test t di Student sui dati di ricompensa degli episodi.

Per ulteriori informazioni sui nostri test statistici, consultare il [README dell'analisi dati](https://github.com/samuelebortolotti/pareto-epsilon-greedy-RL/blob/master/analysis/README.md).

## Collaboratori
- Samuele Bortolotti
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Massimo Rizzoli](https://github.com/massimo-rizzoli)
- [Erich Robbi](https://github.com/erich-r)
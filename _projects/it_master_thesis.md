---
layout: post
title: Tesi di laurea magistrale
lang: it
date: 2023-10-18
permalink: it/projects/master-thesis.html
ref: projects/master-thesis.html
repository: https://github.com/samuelebortolotti/master-thesis
url: https://github.com/samuelebortolotti/master-thesis
report: https://github.com/samuelebortolotti/master-thesis/tree/master/thesis/src
author: 
- Samuele Bortolotti
nav_bar: projects
type: project
description: Questo progetto è un riassunto del lavoro che ho svolto per la mia tesi di laurea magistrale in Informatica presso l'Università di Trento. Il progetto è un protocollo di debugging interattivo che fonde Interactive Machine Learning e Neuro-Symbolic AI. Esso introduce un approccio multi-round per il debugging del modello, estraendo automaticamente gli argomenti rilevanti e facilitando il dialogo tra utente e macchina.
---

# Tesi di laurea magistrale

## Panoramica del progetto

Questa tesi esplora l'intersezione tra Interactive Machine Learning e Neuro-Simbolic Artificial Intelligence. L'obiettivo primario è sviluppare un protocollo di debugging interattivo per classificatori gerarchici. Gli attuali metodi di explanatory debugging sono limitati a interazioni "one-shot", in cui la macchina fornisce spiegazioni per singole previsioni. Questo progetto risponde alla necessità di un debugging più completo proponendo un approccio di interazione *multi-round*. Questo approccio facilita le discussioni strutturate tra la macchina e l'utente per convalidare o contestare le previsioni e le affermazioni relative al modello.

## Obiettivi

1. Sviluppare un approccio di interazione multi-round per consentire un debugging più esteso rispetto alle interazioni one-shot.

2. Estrarre automaticamente gli argomenti rilevanti dal modello utilizzando metodi di eXplainable Artificial Intelligence (XAI).

3. Facilitare l'interazione tra l'utente e la macchina, consentendo argomenti strutturati per il debug.

4. Convalidare l'efficacia del protocollo di debug interattivo su architetture neuro-simboliche, tra cui [Coherent Hierarchical Multi-Label Classification Networks](https://proceedings.neurips.cc/paper_files/paper/2020/file/6dd4e10e3296fa63738371ec0d5df818-Paper.pdf) e [Semantic Probabilistic Layers](https://openreview.net/pdf?id=o-mxIWAY1T8).

5. Indagare la fattibilità della correzione dei modelli neuro-simbolici con la conoscenza preventiva dei bug sottostanti.

## Risultati chiave:

- Correzione delle convinzioni confuse del modello: questo progetto dimostra che la correzione delle convinzioni del modello è fattibile, soprattutto quando è disponibile una conoscenza preliminare del tipo di bug.

- Selezione degli argomenti: Questa tesi ha identificato delle metriche per la selezione degli argomenti che superano la selezione casuale, riducendo il tempo di interazione.

- Identificazione delle fonti di confusione: Il progetto esplora diverse metriche, come i gradienti e le entropie, per identificare le fonti di confusione nelle previsioni dei modelli.

- Combinando le metriche per idenfitificare il tipo di confusione e il successo del progetto sul debugging, vengono gettate le basi per un nuovo processo di debugging esplicativo.

## Direzioni future:

- Incorporare etichette aggiuntive: Espandere il lavoro includendo etichette aggiuntive che comprendano concetti interclasse, consentendo la correzione di bug legati alle etichette in tutta la gerarchia.

- Human-in-the-loop e SPL: approfondire la relazione tra le tecniche human-in-the-loop e SPL, affrontando le sfide per migliorare l'affidabilità del modello.

- Stima dell'incertezza del modello: Esplorare le strategie per una stima accurata dell'incertezza del modello, distinguendo tra incertezze aleatorie ed epistemiche.

- Valutazione dell'interazione con l'utente: Valutare l'efficacia della procedura complessiva con utenti reali attraverso sondaggi e questionari, raccogliendo feedback qualitativi.

## Conclusione

Questo progetto introduce un innovativo protocollo di debugging interattivo che va oltre le interazioni one-shot. Pur essendo un punto di partenza, ha il potenziale per influenzare in modo significativo la ricerca futura nel campo dell'apprendimento automatico interattivo e dell'intelligenza artificiale neuro-simbolica.
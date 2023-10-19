---
layout: post
lang: it
title: File Analyzer
description: Efficiente programma multithread e multiprocesso in C per analizzare ricorsivamente i file contenuti in una cartella e produrre statistiche su di essi.
date: 2020-04-28
permalink: it/projects/file-analyzer.html
ref: projects/file-analyzer.html
repository: https://github.com/fedeizzo/file-analyzer
url: https://github.com/fedeizzo/file-analyzer
report: https://github.com/fedeizzo/file-analyzer/blob/master/README.md 
author: 
- Samuele Bortolotti
- Federico Izzo
- Simone Alghisi
- Emanuele Beozzo
nav_bar: projects
type: project
---
# File Analyzer

## Informazioni generali
Progetto di gruppo per il corso di Sistema Operativi della laurea triennale in Informatica dell'Università di Trento.

## Descrizione e obiettivi
L'obiettivo principale di questo progetto è contare le occorrenze di caratteri ASCII all'interno di uno o più file.

Per rendere il tutto il più estensibile e modulare possibile, abbiamo sviluppato diversi componenti, ognuno dei quali ha compiti specifici. In particolare:

- **Counter** genera il reporter e l'analyzer.
- **Reporter** crea l'interfaccia utente da terminale **Tui** e comunica con l'analyzer.
- **Analyzer** riceve tutti gli input dall'utente e trova tutti i file all'interno di una directory ricorsivamente. Mentre i file vengono scoperti, l'analyzer invia i file da analizzare ai manager.
- Il **manager** prende i file da analizzare e ne divide il contenuto in jobs. Un job consiste nell'analizzare il contenuto di un file tra due punti specifici. Quando i jobs sono pronti, essi vengono inviati ai workers per essere svolti.
- Il **worker** riceve il file, il punto di inizio e il punto di fine del job. Dopodiché procede a leggere e contare i caratteri all'interno della porzione del file.

La struttura del programma è rappresentata qui:

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png?raw=truehttps://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png" alt="Struttura del programma" width="100%">

## Risultati
- Abbiamo sviluppato un efficiente programma *multithread* e *multiprocesso* in *C* per analizzare ricorsivamente i file contenuti in una cartella e produrre statistiche su di essi - *media di 51 file/secondo*.
- L'interazione con l'utente è supportata da una *interfaccia utente da terminale* (TUI) per gestire i file da considerare, il numero di processi da generare, le statistiche da mostrare e per attraversare il file system locale.

Qui di seguito viene mostrato uno scorcio dell'esecuzione del programma: 

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/GIFME.gif?raw=true" alt="Sistema al lavoro" width="100%">

## Contributori
- Samuele Bortolotti
- [Federico Izzo](https://github.com/fedeizzo)
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Emanuele Beozzo](https://github.com/emanuelebeozzo)
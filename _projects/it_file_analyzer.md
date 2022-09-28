---
layout: post
lang: it
title: File Analyzer
description: Programma multithread e multiprocesso scritto in C per analizzare ricorsivamente i file contenuti all'interno di una cartella producendo statistiche su di essi.
date: 2020-04-28
permalink: /it/file-analyzer.html
order: 2
ref: file-analyzer.html
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

## Informazioni generali
Progetto di gruppo per il corso di Sistema Operativi del Corso di Laurea Triennale in Informatica dell'Università degli Studi di Trento.

- **Repository**: [file-analyzer](https://github.com/fedeizzo/file-analyzer)
- **Linguaggio**: *C*
- **Data di inizio**: 2020/04/28
- **Data di fine**: 2020/06/07

## Description & Objectives
L'obiettivo principale di questo progetto è quello di contare le occorrenze dei caratteri ASCII all'interno di uno o più file.

Per rendere tutto il più estensibile e modulare, abbiamo sviluppato diversi componenti, ognuno di essi con compiti specifici. In particolare:

- **Contatore**: genera il reporter e l'analyzer.
- **Reporter**: crea l'interfaccia utente del terminale **Tui** e comunica con l'analyzer.
- **Analyzer** prende l'input dall'utente invia tutti i file in una cartella ai manager.
- **Manager** prende i file e li divide in più componenti. Quando i componenti sono stati partizionati vengono inviati ai worker.
- **Worker** riceve il file, e ne legge il contenuto.

La struttura del programma è illustrata qui:

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png?raw=truehttps://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png" alt="Struttura del Programma" width="100%">

## Risultati
- We have developed an efficient *multithread* and *multiprocess* program in *C* to analyze recursively the files contained inside a folder and produce statistics about them — *average of 51 files/seconds*.
- User interaction is supported through a *Terminal User Interface* (TUI) to handle which files to consider, the number of processes to be spawned, the statistics to be shown, and to traverse the local file system.

A glance of the program execution is shown here:

- Abbiamo sviluppato un programma *multithread* e *multiprocesso* in *C* per analizzare ricorsivamente i file contenuti all'interno di una cartella e produrre statistiche su di essi — *media di 51 file/secondo*.
- L'interazione utente è supportata tramite una *Interfaccia utente da terminale* (TUI) per gestire i file, il numero di processi da generare, le statistiche da mostrare e per attraversare il file system locale.

Un esempio dell'esecuzione del programma è mostrata qui:

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/GIFME.gif?raw=true" alt="Sistema al lavoro" width="100%">

## Valutazione finale
30 Cum Laude (su 30)

## Contributori
- Samuele Bortolotti
- [Federico Izzo](https://github.com/fedeizzo)
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Emanuele Beozzo](https://github.com/emanuelebeozzo)
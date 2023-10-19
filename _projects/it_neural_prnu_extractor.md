---
layout: post
title: Neural PRNU Extractor
lang: it
date: 2022-11-22
mathjax: true
permalink: it/projects/neural-prnu-extractor.html
ref: projects/neural-prnu-extractor.html
repository: https://github.com/samuelebortolotti/neural-prnu-extractor
url: https://github.com/samuelebortolotti/neural-prnu-extractor
report: https://github.com/samuelebortolotti/neural-prnu-extractor/blob/master/README.rst
author: 
- Samuele Bortolotti
- Simone Alghisi
- Massimo Rizzoli
nav_bar: projects
type: project
description: Neural-PRNU-Extractor è un progetto basato su PyTorch che estende FFDNet, originariamente progettato per image denoising. È stato adattato per estrarre i pattern PRNU delle telecamere. Questo progetto è stato sviluppato per il corso Signal, Image, and Video del corso di laurea magistrale in Sistemi di Intelligenza Artificiale e Informatica dell'Università di Trento.
---

# Neural-PRNU-Extractor

## Project Overview

Neural-PRNU-Extractor è progetto basato su un'implementazione modificata della rete di denoising [FFDNet](https://arxiv.org/abs/1710.04026). Questo progetto è stato sviluppato nell'ambito del corso Signal, Image, and Video del corso di laurea magistrale in Sistemi di Intelligenza Artificiale e Informatica dell'Università di Trento.

## Caratteristiche principali

- Estrazione del PRNU: A differenza di FFDNet originale, questa versione modificata si concentra sull'estrazione del PRNU (Photo Response Non-Uniformity) delle fotocamere.

- Opzioni di addestramento: Neural-PRNU-Extractor offre la possibilità di addestrare la rete utilizzando il filtro di Wiener come strategia di estrazione del rumore.

## Obiettivo del progetto

{::nomarkdown}
L'obiettivo principale di Neural-PRNU-Extractor è la riduzione del rumore nelle immagini. Esso mira a prevedere e rimuovere il rumore dalle immagini catturate da fotocamere digitali e a pellicola, migliorandone l'idoneità per varie applicazioni di computer vision. Inoltre, è in grado di prevedere efficacemente i livelli di rumore (\(\sigma \ in [0, 75]\)) nelle immagini.
{:/}

Neural-PRNU-Extractor può calcolare e valutare PRNU basati su un set di dati di immagini piatte, consentendo l'identificazione del dispositivo specifico che ha generato un'immagine. PRNU, o Photo Response Non-Uniformity, è un fattore cruciale nei sensori di immagini digitali, comunemente presenti nelle fotocamere e negli strumenti ottici, rendendolo uno strumento prezioso per l'identificazione e la verifica dei dispositivi.

La pipeline di estrazione PRNU può essere visualizzata qui: <a href="https://github.com/samuelebortolotti/neural-prnu-extractor/blob/master/presentation/imgs/prnu_extraction_pipeline.pdf?raw=true">Scarica PDF</a>

## Contributori
- Samuele Bortolotti
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Massimo Rizzoli](https://github.com/massimo-rizzoli)
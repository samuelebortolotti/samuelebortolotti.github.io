---
layout: post
title: Neural PRNU Extractor
lang: de
date: 2022-11-22
mathjax: true
permalink: de/projects/neural-prnu-extractor.html
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
description: Neural-PRNU-Extractor ist ein PyTorch-basiertes Projekt, das FFDNet erweitert, das ursprünglich für die Entrauschung von Bildern entwickelt wurde. Es wurde angepasst, um PRNU-Muster von Kameras zu extrahieren. Dieses Projekt wurde für den Signal-, Bild- und Videokurs im Rahmen des Masterstudiengangs für Systeme der Künstlichen Intelligenz und Informatik an der Universität Trient entwickelt.
---

# Neural-PRNU-Extractor

## Projektübersicht

Neural-PRNU-Extractor ist eine modifizierte PyTorch-Implementierung der [FFDNet](https://arxiv.org/abs/1710.04026) Bildentrauschungstechnik. Ursprünglich als Teil des Signal-, Bild- und Videokurses für den Masterstudiengang in Künstlicher Intelligenz und Informatik an der Universität Trient entwickelt, erweitert dieses Projekt die Fähigkeiten von FFDNet.

## Hauptmerkmale

- **PRNU-Extraktion:** Anders als das ursprüngliche FFDNet konzentriert sich diese modifizierte Version auf die Extraktion der PRNU (Photo Response Non-Uniformity) der Kameras.

- **Trainingsoptionen:** Neural-PRNU-Extractor bietet die Flexibilität, das Netzwerk mit dem Wiener Filter als Rauschextraktionsstrategie zu trainieren, zusätzlich zu der in der FFDNet-Veröffentlichung beschriebenen Methode.

## Projektziel

{::nomarkdown}
Das Hauptziel von Neural-PRNU-Extractor ist die Rauschunterdrückung in Bildern. Es zielt darauf ab, Rauschen aus Bildern, die von Digital- und Filmkameras aufgenommen wurden, vorherzusagen und zu entfernen, um ihre Eignung für verschiedene Anwendungen im Bereich der Computer Vision zu verbessern. Das Projekt kann Rauschpegel (\(\sigma \in [0, 75]\)) in Bildern effektiv vorhersagen.
{:/}

Darüber hinaus kann Neural-PRNU-Extractor PRNU-Muster basierend auf einem Datensatz flacher Bilder berechnen und auswerten und so das spezifische Gerät identifizieren, das ein Bild erzeugt hat. PRNU (Photo Response Non-Uniformity) ist ein entscheidender Faktor in digitalen Bildsensoren, die häufig in Kameras und optischen Instrumenten zu finden sind, und macht sie zu einem wertvollen Werkzeug zur Geräteidentifizierung und -verifizierung.

Die PRNU-Extraktionspipeline kann hier eingesehen werden: <a href="https://github.com/samuelebortolotti/neural-prnu-extractor/blob/master/presentation/imgs/prnu_extraction_pipeline.pdf?raw=true">PDF herunterladen</a>

## Mitwirkende
- Samuele Bortolotti
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Massimo Rizzoli](https://github.com/massimo-rizzoli)
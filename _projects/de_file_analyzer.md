---
layout: post
lang: de
title: File Analyzer
description: Ein effizientes Multithread- und Multiprozess-Programm in C, das die in einem Ordner enthaltenen Dateien rekursiv analysiert und Statistiken über sie erstellt.
date: 2020-04-28
permalink: de/projects/file-analyzer.html
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

## Allgemeine Informationen
Gruppenprojekt für den Kurs Operative Systeme (OS) des Bachelor-Studiengangs Informatik an der Universität Trient.

## Beschreibung & Zielsetzung
Das Hauptaugenmerk dieses Projekts liegt auf der Zählung des Vorkommens von ASCII-Zeichen innerhalb einer oder mehrerer Dateien.

Um das Ganze so erweiterbar und modular wie möglich zu gestalten, haben wir mehrere Komponenten entwickelt, von denen jede spezifische Aufgaben hat. Im Besonderen:

- **Counter** erzeugt den Reporter und den Analyzer.
- **Reporter** erstellt die Terminal-Benutzeroberfläche **Tui** und kommuniziert mit dem Analysator.
- **Analyzer** nimmt alle Eingaben des Benutzers entgegen und findet alle Dateien in einem bestimmten Verzeichnis. Während der Suche nach Dateien sendet der Analyzer die gefundenen Dateien an den Manager.
- Der **Manager** nimmt die Dateien und teilt sie in mehrere Arbeiten auf. Eine Arbeit beginnt an einem bestimmten Punkt der Datei und endet an einem anderen. Wenn die Arbeiten fertig sind, werden sie an die Arbeiter geschickt.
- Der **Arbeiter** nimmt die Datei, den Startpunkt und den Endpunkt. Danach liest er den Teil der Datei.

Die Programmstruktur ist hier abgebildet:

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png?raw=truehttps://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png" alt="Struktur des Programms" width="100%">

## Ergebnisse
- Wir haben ein effizientes *Multithread*- und *Multiprozess*-Programm in *C* entwickelt, um die in einem Ordner enthaltenen Dateien rekursiv zu analysieren und Statistiken über sie zu erstellen - *Durchschnitt von 51 Dateien/Sekunde*.
- Die Benutzerinteraktion wird durch eine *Terminal User Interface* (TUI) unterstützt, um die zu berücksichtigenden Dateien, die Anzahl der zu startenden Prozesse, die anzuzeigenden Statistiken und das Durchlaufen des lokalen Dateisystems zu steuern.

Ein Blick auf die Programmausführung ist hier zu sehen: 

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/GIFME.gif?raw=true" alt="System bei der Arbeit" width="100%">

## Mitwirkende
- Samuele Bortolotti
- [Federico Izzo](https://github.com/fedeizzo)
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Emanuele Beozzo](https://github.com/emanuelebeozzo)
---
layout: post
title: Masterarbeit
lang: de
date: 2023-10-18
permalink: de/projects/master-thesis.html
ref: projects/master-thesis.html
repository: https://github.com/samuelebortolotti/master-thesis
url: https://github.com/samuelebortolotti/master-thesis
report: https://github.com/samuelebortolotti/master-thesis/tree/master/thesis/src
author: 
- Samuele Bortolotti
nav_bar: projects
type: project
description: Dieses Projekt ist meine Masterarbeit für ein Informatikstudium an der Universität von Trient. Es leistet Pionierarbeit für ein interaktives Debugging-Protokoll, das Interaktives Maschinelles Lernen und Neuro-Symbolische KI miteinander verbindet. Es führt einen Mehrrundenansatz für umfassendes Modell-Debugging ein, der automatisch relevante Argumente extrahiert und Dialoge zwischen Benutzer und Maschine erleichtert. Mit erfolgreicher Fehlerkorrektur, Argumentauswahl und Identifizierung von Störquellen schafft es die Voraussetzungen für ein verbessertes interaktives Debugging in komplexen maschinellen Lernmodellen.
---

# Masterarbeit

## Projektübersicht

Diese Arbeit erforscht die Konvergenz von Interaktivem Maschinellem Lernen und Neuro-Symbolischer Künstlicher Intelligenz. Das Hauptziel ist die Entwicklung eines interaktiven Debugging-Protokolls für hierarchische Klassifikatoren. Derzeitige Methoden zur erklärenden Fehlersuche beim maschinellen Lernen beschränken sich oft auf *Ein-Schuss*-Interaktionen, bei denen die Maschine Erklärungen für einzelne Vorhersagen liefert. Dieses Projekt befasst sich mit der Notwendigkeit einer umfassenderen Fehlersuche, indem es einen *Multi-Runden*-Interaktionsansatz vorschlägt. Dieser Ansatz erleichtert strukturierte Argumente zwischen der Maschine und dem Benutzer, um Vorhersagen und modellbezogene Aussagen zu validieren oder in Frage zu stellen.

## Zielsetzungen

1. **Mehrrunden-Interaktion:** Entwicklung eines Mehrrunden-Interaktionsansatzes, um eine umfassendere Fehlersuche im Vergleich zu One-Shot-Interaktionen zu ermöglichen.

2. **Automatisierte Argumentextraktion:** Automatische Extraktion relevanter Argumente aus dem Modell unter Verwendung von Relevanzmaßen der eXplainable Artificial Intelligence (XAI).

3. **Benutzer-Modell-Interaktion:** Erleichtert die dialogische Interaktion zwischen dem Benutzer und der Maschine und ermöglicht strukturierte Argumente zur Fehlersuche.

4. **Modellvalidierung:** Validierung der Wirksamkeit des interaktiven Debugging-Protokolls auf neurosymbolischen Architekturen, einschließlich [Coherent Hierarchical Multi-Label Classification Networks](https://proceedings.neurips.cc/paper_files/paper/2020/file/6dd4e10e3296fa63738371ec0d5df818-Paper.pdf) und [Semantic Probabilistic Layers](https://openreview.net/pdf?id=o-mxIWAY1T8).

5. **Durchführbarkeit der Fehlerkorrektur:** Untersuchung der Durchführbarkeit der Korrektur von neurosymbolischen Modellen mit vorheriger Kenntnis der zugrunde liegenden Fehler.

## Wichtigste Ergebnisse:

- Korrektur verworrener Modellüberzeugungen: Dieses Projekt zeigt, dass die Korrektur von Modellüberzeugungen möglich ist, insbesondere wenn Vorwissen über die Art der Fehler vorhanden ist.

- Auswahl von Argumenten: Im Rahmen dieser Arbeit wurden Metriken für die Auswahl von Argumenten identifiziert, die die zufällige Auswahl übertreffen und die Interaktionszeit sowie die Verärgerung der Benutzer reduzieren.

- Identifizierung von Fehlerquellen: Das Projekt erforscht Metriken wie Gradienten und Entropien zur Identifizierung von Verwechslungsquellen in Modellvorhersagen.

- Rahmen für erklärende Fehlersuche: Durch die Kombination von Confounding als Relevanzmaß und effektiver Fehlersuche wird die Grundlage für einen erklärenden Fehlersuchprozess geschaffen.

## Zukünftige Richtungen:

- Einbindung zusätzlicher Labels: Ausweitung der Arbeit durch Einbeziehung zusätzlicher Labels, die klassenübergreifende Konzepte umfassen und die Korrektur von Label-bezogenen Fehlern in der gesamten Hierarchie ermöglichen.

- Human-in-the-Loop und SPL: Weitere Untersuchung der Beziehung zwischen Human-in-the-Loop-Techniken und SPL, wobei die Herausforderungen zur Verbesserung der Vertrauenswürdigkeit von Modellen angegangen werden.

- Schätzung der Modellunsicherheit: Untersuchung von Strategien zur genauen Schätzung der Modellunsicherheit, wobei zwischen aleatorischen und epistemischen Unsicherheiten unterschieden wird.

- Bewertung der Benutzerinteraktion: Bewertung der Wirksamkeit des Gesamtverfahrens mit realen Nutzern durch Umfragen und Fragebögen, um qualitatives Feedback zu erhalten.

## Schlussfolgerung

Dieses Projekt stellt ein innovatives interaktives Debugging-Protokoll vor, das über einmalige Interaktionen hinausgeht. Es dient als Ausgangspunkt und hat das Potenzial, die zukünftige Forschung im Bereich des interaktiven maschinellen Lernens und der neurosymbolischen KI maßgeblich zu beeinflussen.
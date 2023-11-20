---
layout: post
title: Distributed Multi-level Cache
lang: de
date: 2022-07-29
permalink: de/projects/multilevel-cache.html
ref: projects/multilevel-cache.html
repository: https://github.com/samuelebortolotti/multilevel-cache
url: https://github.com/samuelebortolotti/multilevel-cache
report: https://github.com/samuelebortolotti/multilevel-cache/blob/master/doc/Report.pdf
author: 
- Samuele Bortolotti
- Luca De Menego
nav_bar: projects
type: project
description: Distributed Multi-level Cache ist ein verteiltes Cache-System mit mehreren Ebenen, das dafür ausgelegt ist, Abstürze auf verschiedenen Hierarchieebenen zu bewältigen und gleichzeitig eine client-zentrierte Konsistenz zu gewährleisten. Dieses System wurde im Rahmen des Kurses "Verteilte Systeme 1" im Masterstudiengang Informatik an der Universität Trient entwickelt.
---
# Distributed Multi-level Cache
In diesem Projekt geht es um die Implementierung eines verteilten mehrstufigen Cache-Protokolls unter Verwendung von [Java 8] (https://www.oracle.com/java/technologies/java8.html) und [Akka] (https://akka.io/). Das Hauptziel besteht darin, ein robustes System zu schaffen, das Cache-Operationen auf verschiedenen Ebenen innerhalb einer verteilten Umgebung effektiv verwaltet und dabei **clientzentrierte Konsistenz** gewährleistet. Dieses Projekt wird im Rahmen des Kurses Distributed Systems 1 an unserer Institution, der Universität Trento, entwickelt.

## Allgemeine Informationen
Das Kernkonzept dieses Projekts konzentriert sich auf die Implementierung eines verteilten mehrstufigen Cache-Protokolls. Caches spielen als grundlegende Komponente des Systems eine entscheidende Rolle bei der Speicherung häufig angeforderter Objekte und der autonomen Beantwortung von Client-Anfragen. Diese Architektur ist so konzipiert, dass sie die Überlastung der Datenbank verringert und die Leistung optimiert.

Zu den Hauptakteuren in diesem Projekt gehören Clients, Caches und eine zentrale Datenbank. Mehrere Clients interagieren mit dem System und führen sowohl Lese- als auch Schreibvorgänge an den in der Datenbank gespeicherten Daten durch. Die Cache-Schicht, die sich in der Nähe der Clients befindet, ist in erster Linie für die effiziente Bearbeitung von Lesevorgängen zuständig. Schreibvorgänge werden dagegen an die primäre Datenbank weitergeleitet. Das Protokoll stellt sicher, dass Clients, die mit demselben Cache interagieren, nach erfolgreichen Schreiboperationen keine veralteten Werte erhalten, und bietet somit eine letztendliche Konsistenz. Darüber hinaus enthält das Projekt zwei "kritische" Varianten der Kernoperationen, nämlich **CRITREAD** und **CRITWRITE**, um erweiterte Sicherheiten zu bieten.

Es wird davon ausgegangen, dass der Inhalt der *Datenbank während der gesamten Ausführung des Protokolls konstant bleibt*. Der Einfachheit halber beschränken sich die sowohl in den Datenbanken als auch in den Caches gespeicherten Daten auf ganzzahlige Werte.

**Cache-Hierarchie:**

Die Caches in diesem Projekt sind in einer hierarchischen Baumstruktur organisiert. Einige Caches arbeiten auf der ersten Ebene (L1-Caches) und unterhalten eine direkte Verbindung zur Datenbank. L1-Caches fungieren als Eltern für die Caches der zweiten Ebene (L2-Caches), die direkt mit den Clients interagieren, ihre Anfragen bearbeiten und Ergebnisse zurückgeben.

**Unterstützte Operationen:**

Das Projekt unterstützt die folgenden Operationen:

1. **LESEN**: Wenn ein L2-Cache eine Leseanforderung erhält, prüft er, ob der angeforderte Wert in seinem Speicher vorhanden ist. Wenn er ihn findet, antwortet er sofort. Andernfalls leitet er die Anfrage an seinen übergeordneten L1-Cache weiter. Je nach Szenario kann der L1-Cache mit dem Wert antworten (Durchlesemodus) oder die Hauptdatenbank konsultieren. Die Antworten werden auf dem Anforderungspfad zurückverfolgt, wobei die Caches das Element für künftige Anforderungen speichern. Client-Timeouts sollten die Zeit berücksichtigen, die eine Anfrage benötigt, um die Datenbank zu erreichen.

2. **WRITE**: Schreibanfragen werden direkt an die Datenbank gesendet, die den Vorgang ausführt und alle zugehörigen L1-Caches über die Aktualisierung benachrichtigt. Daraufhin leiten alle L1-Caches die Aktualisierung an ihre entsprechenden L2-Caches weiter. Auf diese Weise wird sichergestellt, dass die Änderung an jeden Cache weitergegeben wird, was eine Voraussetzung für die Erreichung der Konsistenz ist. Das geschriebene Element wird nur in den Caches aktualisiert, die es zuvor enthielten.

3. **CRITREAD**: Ähnlich wie bei einem Lesevorgang holt CRITREAD den neuesten Wert aus der Datenbank. Im Gegensatz zu einem regulären Lesevorgang wird diese Anforderung jedoch auch dann übermittelt, wenn sich das Element bereits im L2- oder L1-Cache befindet.

4. **CRITWRITE**: CRITWRITE ist analog zur WRITE-Operation und beinhaltet eine Anfrage an die Datenbank. Die Datenbank muss jedoch sicherstellen, dass kein Cache einen veralteten Wert für das geschriebene Element enthält, bevor sie den Schreibvorgang ausführt. Die Datenbank überträgt die Änderung, ähnlich wie bei der WRITE-Operation, sobald sie bestätigt, dass die zwischengespeicherten Objekte aktualisiert wurden.

**Abstürze und Wiederherstellungen:**

Caches innerhalb des Systems können während kritischer algorithmischer Prozesse abstürzen. Um dies zu vermeiden, verwendet das Projekt einen einfachen Timeout-basierten Mechanismus zur Erkennung von Abstürzen. Wenn ein Client einen Absturz in einem L2-Cache feststellt, wählt er einen alternativen L2-Cache und leitet seine Anfragen um. Wenn ein L2-Cache den Absturz seines L1-Elternspeichers feststellt, bestimmt er die primäre Datenbank als neuen Elternspeicher. Bei einem Cache-Absturz gehen alle gespeicherten Objekte verloren, vorausgesetzt, sie wurden im flüchtigen Speicher abgelegt. Die Caches behalten jedoch wichtige Systeminformationen, einschließlich des Datenbankakteurs und der ActorRef ihrer Baumnachbarn. Caches erholen sich automatisch und nehmen den Betrieb nach einem vordefinierten Zeitintervall wieder auf.

Weitere Informationen über das Framework oder seine Implementierung finden Sie in diesem Bericht.

## Mitwirkende
- Samuele Bortolotti
- [Luca De Menego](https://github.com/lucademenego99)
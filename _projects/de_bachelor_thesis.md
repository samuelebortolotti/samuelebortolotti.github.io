---
layout: post
title: Bachelorarbeit
lang: de
date: 2021-07-20
permalink: de/projects/bachelor-thesis.html
mathjax: true
ref: projects/bachelor-thesis.html
repository: https://github.com/samuelebortolotti/bachelor-thesis
url: https://github.com/samuelebortolotti/bachelor-thesis
report: https://github.com/samuelebortolotti/bachelor-thesis/tree/master/thesis/src
author: 
- Samuele Bortolotti
nav_bar: projects
type: project
description: Bei diesem Projekt handelt es sich um meine Bachelorarbeit für einen Informatikabschluss an der Universität Trient. Es besteht in der Entwicklung einer effektiven Strategie zur Extraktion der von den Wikipedia-Nutzern gesprochenen Sprachen und zur Extraktion der Benutzerwarnungen und Wikibreaks der Wikipedia-Nutzer, mit dem Schwerpunkt auf der Untersuchung ihrer Auswirkungen auf das Aktivitätsniveau der Nutzer.
---
# Bachelorarbeit

## Allgemeine Informationen:
In den letzten Jahrzehnten hat sich Wikipedia zu einer führenden Plattform für den freien und kollaborativen Wissensaustausch entwickelt und die Aufmerksamkeit der wissenschaftlichen Gemeinschaft auf sich gezogen. Während das Hauptaugenmerk auf den Inhalten von Wikipedia liegt, ist auch das Verhalten der aktiven Nutzer von Interesse. Eine Studie von [Miquel-Ribé et al. (2021)](https://wikiworkshop.org/2021/papers/Wiki_Workshop_2021_paper_22.pdf). hebt das Problem der Abwanderung von Redakteuren hervor, insbesondere unter erfahrenen Autoren, und wirft die Frage nach den Faktoren auf, die zu ihrem Ausstieg aus der Plattform beitragen.

## Projektziel:
In meiner Bachelorarbeit habe ich Wikipedia-Nutzerdaten umfassend analysiert und mich dabei auf mehrere Schlüsselaspekte konzentriert, darunter Sprachkenntnisse, Wikibreak-Muster und Nutzerwarnungen. Die Arbeit umfasste die Entwicklung und Implementierung von Data-Mining-Strategien, um wertvolle Erkenntnisse aus den umfangreichen Inhalten von Wikipedia zu gewinnen.

## Hauptanalysebereiche:
1. **Sprachkenntnisse:** Die Studie beginnt mit der Identifizierung der Sprachen, die die Wikipedia-Benutzer kennen, um die am häufigsten gesprochenen Sprachen innerhalb der Gemeinschaft zu ermitteln.

2. **Wikibreak-Muster:** Vorlagen für Wikibreaks, die die Aktivitätszyklen der Nutzer auf der Plattform beschreiben, wurden extrahiert, um deren Nutzungsmuster und Beliebtheit zu verstehen. Es wurden Kategorisierungen entwickelt, um verschiedene Arten von Wikibreaks zu klassifizieren, was die Verfolgung aktiver Wikibreaks im Laufe der Zeit ermöglicht.

3. **Benutzerwarnungen:** Vorlagen für Benutzerwarnungen wurden abgerufen und nach Schweregrad kategorisiert. Es wurde eine zeitliche Analyse durchgeführt, um die Auswirkungen der Warnungen auf die Nutzeraktivitäten zu bewerten, insbesondere in den Monaten nach einer Warnung mit hohem Schweregrad.

## Datenextraktion und -analyse:
Im Rahmen des Projekts wurden Data-Mining-Techniken eingesetzt, um Nutzerdaten zu extrahieren und zu analysieren und so die oben genannten Forschungsziele zu erreichen. Zu den in der Dissertation eingesetzten Methoden gehören:

- Verständnis der Inhaltsstruktur von Wikipedia, der Seitenorganisation und der Revisionsgeschichte.
- Entwicklung von Methoden zur Identifizierung und Klassifizierung von Vorlagen in Wikipedia. Diese Methode beinhaltet die Entwicklung einer Pipeline, die den Inhalt des Wikipedia-Dumps scannt, identifiziert und den Inhalt bezüglich der ausgewählten Vorlagen extrahiert.
- Erkennung von Vorlagenbedeutungen und Implementierung semantischer Klassifizierungen.
- Erstellung eines Tools, das Daten zu Benutzerwarnungen, Wikibreaks und Benutzeraktionen zusammenführt, um Statistiken zu erstellen und die Korrelation zwischen Benutzerverhalten und erhaltenen Warnungen zu untersuchen.

In der Wikipedia stellt die Aufnahme von Vorlagen eine nuancierte Herausforderung dar, da es zwei verschiedene Methoden gibt: Transklusion und Substitution, die jeweils ihre eigenen Vor- und Nachteile haben.

### Transklusion
Die Transklusion ist die am weitesten verbreitete Methode, um Vorlagen in Wikipedia-Seiten einzufügen. Bei dieser Methode wird der Verweis auf die Vorlage (ein "Live"-Link) in das aktuelle Dokument eingefügt. Zukünftige Änderungen am Erscheinungsbild der Vorlage werden automatisch auf alle Seiten übertragen, die auf die Vorlage verweisen. Diese sequentielle Einbeziehung von Vorlagen, die transkludierte Vorlagen enthalten, wird als verschachtelte Einbeziehung bezeichnet. Die grundlegende Syntax für das Einfügen einer Vorlage mittels Transklusion lautet wie folgt:

<pre>
&#123;&#123;&#123;&#123;Template name&#125;&#125;
</pre>

Diese Syntax kann erweitert werden, um Parameter einzubeziehen:

<pre>
&#123;&#123;&#123;&#123;Template name | parameter | parameter | ...&#125;&#125;
</pre>

Die Transklusion stellt sicher, dass Änderungen an einer Vorlage universell auf allen Seiten, die diese Vorlage verwenden, angewendet werden.

![Transcluded template](https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Transclusion-multiple-foo.svg/1024px-Transclusion-multiple-foo.svg.png){: width="100%"}

### Substitution
Die Substitution bietet eine alternative Methode zur Einbindung von Vorlagen. Dabei wird der Code der Vorlage mit der Funktion "subst" direkt in das aktuelle Dokument eingebettet. Das bedeutet, dass zukünftige Änderungen an der Originalvorlage keine Auswirkungen auf die Seiten haben, auf denen sie ersetzt wurde. Die erforderliche Syntax für das Einfügen einer Vorlage mittels Substitution lautet wie folgt:

<pre>
&#123;&#123;subst: Template name&#125;&#125;
</pre>

Ähnlich wie bei der Transklusion können bei der Substitutionssyntax zusätzliche Parameter verwendet werden:

<pre>
&#123;&#123;subst: Template name | parameter | parameter | ...&#125;&#125;
</pre>

Ein wesentlicher Vorteil der Substitution ist die Möglichkeit, Code einzubinden und zu ändern, ohne die ursprüngliche Vorlage zu verändern, wodurch die Integrität der eingeschlossenen Instanzen erhalten bleibt. Bei Vorlagen mit Benutzerwarnungen wird die Substitution üblicherweise eingesetzt, um Vorlagen vor Vandalismus zu schützen. Die Ergebnisse der Vorlagensubstitution sind unabhängig von der Vorlagenseite, nachdem die Substitution abgeschlossen ist. Hier ist ein Beispiel für den Wikicode nach Anwendung der Substitutionsfunktion:

*Substitution function code:*
<pre>
&#123;&#123;subst:foo&#125;&#125;
</pre>

*Code inserted in the target page:*
```
Sample template content.
```

Sowohl Transklusions- als auch Substitutionsmethoden können rekursiv organisiert werden, aber wenn eine substituierte Vorlage transkludierte Vorlagen enthält, werden standardmäßig die durch den Transklusionsprozess erzeugten unveränderten Referenzen beibehalten. Es ist jedoch möglich, die Substitutionsfunktion so anzupassen, dass sie eine Kette von Substitutionen erstellt und den Code aus jeder erwähnten Vorlage einfügt, wodurch der Einschlussprozess verändert wird.

### Extraktion von Warnungen der Benutzer
Im Gegensatz zu Wikibreaks und Sprachen, die oft durch Transklusion eingefügt werden, folgen die Benutzerwarnungen keiner bevorzugten Strategie.

Aus diesem Grund werden naive und effiziente Ansätze, die Informationen über Vorlagen mit Hilfe regulärer Ausdrücke extrahieren, nicht in allen Fällen funktionieren.

Um substituierte Vorlagen zu identifizieren, besteht die Idee darin, zunächst die Vorlage durch Erkennung ihrer wichtigsten Wörter zu identifizieren.
 
Zu diesem Zweck verwenden wir [tf-idf (term frequency-inverse document frequency)](https://en.wikipedia.org/wiki/Tf%E2%80%93idf), eine numerische Statistik, um die wichtigsten Wörter innerhalb der Vorlagenrevisionen zu identifizieren. Diese Metrik misst die Bedeutung eines Wortes in einer Dokumentensammlung (Korpus), indem sie sowohl seine Häufigkeit in einem Dokument (Termfrequenz, $tf$) als auch seine Einzigartigkeit im gesamten Korpus (inverse Dokumentfrequenz, $idf$) berücksichtigt.

**Begriffshäufigkeit ($tf$):** 

{::nomarkdown}
$$tf(t, d) = \frac{f_{t,d}}{\sum_{t' \in d} f_{t',d}}$$
{:/}

Die Begriffshäufigkeit misst, wie oft ein Begriff in einem bestimmten Dokument vorkommt. Je häufiger ein Wort in einem Dokument vorkommt, desto wichtiger ist es für dieses Dokument.

**Inverse Document Frequency ($idf$):** 

{::nomarkdown}
$$idf(t, D) = \frac{\log |D|}{|\{d \in D : t \in d\}|}$$
{:/}

Die inverse Dokumentenhäufigkeit bewertet, wie eindeutig ein Begriff den gesamten Korpus charakterisiert. Sie wird berechnet als der Logarithmus der Gesamtzahl der Dokumente im Korpus geteilt durch die Anzahl der Dokumente, die das spezifische Wort enthalten.

**Gesamtmetrik ($tf$-$idf$):** 

{::nomarkdown}
$$tf-idf(t, d, D) = tf(t, d) \cdot idf(t, D)$$
{:/}

Die endgültige $tf$-$idf$-Metrik kombiniert sowohl die Termhäufigkeit als auch die inverse Dokumenthäufigkeit, um die Bedeutung eines Wortes zu bestimmen. Wenn ein Begriff in allen Dokumenten vorkommt, ist sein $tf$-$idf$-Wert 0, was bedeutet, dass er für den Korpus nicht charakteristisch ist.

In bestimmten Fällen, z. B. bei der Identifizierung von charakteristischen Wörtern in Blockvorlagen, kann die $tf$-$idf$-Metrik jedoch ihre Grenzen haben. So können z. B. häufig vorkommende Wörter wie "Block" in allen Vorlagenrevisionen häufig vorkommen, was zu einem niedrigen $idf$-Wert führt. Dennoch können diese Wörter für die Identifizierung bestimmter Vorlagen innerhalb einer Seite entscheidend sein.

Sobald die $tf$-$idf$-Metrik ermittelt ist, sucht das Programm mit Hilfe des [Aho-Corasick-Algorithmus](https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm) nach den relevantesten Wortvorkommen innerhalb der Benutzerseite. Wenn alle Vorkommen gefunden wurden, wird die Vorlage als enthalten betrachtet.

Das Problem bei diesem Ansatz ist, trotz seiner relativen Effizienz, die Anzahl der falsch-positiven Ergebnisse, die das Verfahren erzeugen kann.

## Ergebnisse

In diesem Abschnitt gehen wir auf die von den Wikipedia-Benutzern gesprochenen Sprachen und die Korrelation zwischen der Warnung der Benutzer und dem Abbruch ein.

Was die von den Wikipedia-Nutzern gesprochenen Sprachen betrifft, so haben wir nachgewiesen, dass Englisch die am häufigsten genannte Sprache in der italienischen Wikipedia ist, gefolgt von Italienisch selbst. 

Wir haben auch gezeigt, dass Italienisch bei den Sprachen, die in der italienischen Wikipedia-Gemeinschaft von Muttersprachlern gesprochen werden, überwiegt, während Englisch an dritter Stelle liegt.

Der interessanteste Teil der Studie zielte darauf ab, die Auswirkungen von Benutzerwarnungen mit hohem Schweregrad auf die Benutzeraktivität in der italienischen Wikipedia zu bewerten. Bei der Analyse wurden Verbote und vorübergehende Sperren aufgrund ihrer vorhersehbaren Auswirkungen auf das Nutzerverhalten ausgeschlossen.

Unsere Ergebnisse zeigen, dass mehr als 80 % der Benutzer in allen Kategorien einen Rückgang der Aktivität nach hochgradigen Verwarnungen verzeichneten. Bemerkenswert ist, dass dieser Trend bei beiden Geschlechtern gleich ist, wenn auch bei Frauen etwas stärker ausgeprägt. 

Zusammenfassend lässt sich sagen, dass wir bewiesen haben, dass Warnungen mit hohem Schweregrad einen signifikanten Einfluss auf die Benutzeraktivität in der italienischen Wikipedia haben, was zu einem Rückgang der Benutzeraktivität auf breiter Front führt.

## Fazit und zukünftige Arbeit
Dieses Projekt stellt zwar eine vorläufige Untersuchung des Wikipedia-Nutzerverhaltens dar, dient jedoch als Grundlage für künftige Analysen. Zu den Beiträgen dieser Arbeit gehören ein besseres Verständnis der Inhaltsstruktur von Wikipedia, Mechanismen zur Aufnahme von Vorlagen und die Entwicklung eines Tools zur Datenkonsolidierung und -analyse.

Das Verständnis des Nutzerverhaltens in der Wikipedia ist von entscheidender Bedeutung für die Verbesserung der Nachhaltigkeit der Plattform und die Bewältigung von Problemen im Zusammenhang mit der Abwanderung von Redakteuren. Diese Forschung liefert wertvolle Einblicke in die Dynamik einer der weltweit größten kollaborativen Wissensplattformen.
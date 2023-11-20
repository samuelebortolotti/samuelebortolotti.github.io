---
layout: post
title: Tesi di laurea triennale
lang: it
date: 2021-07-20
permalink: it/projects/bachelor-thesis.html
mathjax: true
ref: projects/bachelor-thesis.html
repository: https://github.com/samuelebortolotti/bachelor-thesis
url: https://github.com/samuelebortolotti/bachelor-thesis
report: https://github.com/samuelebortolotti/bachelor-thesis/tree/master/thesis/src
author: 
- Samuele Bortolotti
nav_bar: projects
type: project
description: Questo progetto rappresenta il lavoro che ho svolto per la mia tesi di laurea in Informatica presso l'Università di Trento. Consiste nello sviluppo di una strategia efficace per l'estrazione delle lingue parlate dagli utenti di Wikipedia e per l'estrazione degli avvisi degli utenti di Wikipedia e dei Wikibreak, con un focus sullo studio del loro impatto sul livello di attività degli utenti.
---
# Tesi di laurea triennale

## Informazioni generali:
Negli ultimi decenni, Wikipedia è emersa come piattaforma leader per la condivisione libera e collaborativa della conoscenza, catturando l'attenzione della comunità scientifica. Sebbene l'attenzione si sia concentrata sui contenuti di Wikipedia, anche il comportamento dei suoi utenti attivi è diventato oggetto di interesse. In particolare, uno studio di [Miquel-Ribé et al(2021)](https://wikiworkshop.org/2021/papers/Wiki_Workshop_2021_paper_22.pdf) mette in evidenza il problema dell'abbandono dei redattori, in particolare tra i collaboratori esperti, sollevando interrogativi sui fattori che contribuiscono al loro abbandono della piattaforma.

## Obiettivo del progetto:
La mia tesi di laurea analizza in modo esaustivo i dati degli utenti di Wikipedia, concentrandosi su diversi aspetti chiave, tra cui la competenza linguistica, i modelli di pausa dei wikibreak e gli avvisi utente. La tesi prevede lo sviluppo e l'implementazione di strategie di data mining per estrarre informazioni preziose dal vasto contenuto di Wikipedia.

## Aree di analisi chiave:
1. Lo studio inizia con l'identificazione delle lingue conosciute dagli utenti di Wikipedia per determinare le lingue più comunemente parlate all'interno della comunità.

2. I modelli relativi ai wikibreak, che descrivono i cicli di attività degli utenti sulla piattaforma, sono stati estratti per comprenderne i modelli di utilizzo e la popolarità. Sono state sviluppate delle categorie per classificare i vari tipi di wikibreak, consentendo di tracciare i wikibreak attivi nel tempo.

3. I modelli di avviso utente sono stati recuperati e classificati in base alla gravità. È stata condotta un'analisi temporale per valutare l'impatto degli avvisi sull'attività degli utenti, in particolare nei mesi successivi a un avviso di elevata gravità.

## Estrazione e analisi dei dati:
Il progetto ha utilizzato tecniche di data mining per estrarre e analizzare i dati degli utenti, rispondendo agli obiettivi di ricerca sopra menzionati. Le metodologie implementate nella tesi comprendono:

- Comprendere la struttura dei contenuti, l'organizzazione delle pagine e la storia delle revisioni di Wikipedia.
- Sviluppare metodi per identificare e classificare i template all'interno di Wikipedia. Questo metodo ha comportato la creazione di una pipeline che scansiona il contenuto del dump di Wikipedia, identifica ed estrae il contenuto relativo ai template selezionati.
- Riconoscere i significati dei template e implementare classificazioni semantiche.
- Creazione di uno strumento che consolida i dati relativi agli avvisi degli utenti, ai wikibreak e alle azioni degli utenti per generare statistiche ed esplorare la correlazione tra il comportamento degli utenti e gli avvisi ricevuti.

In Wikipedia, l'inclusione dei template rappresenta una sfida difficile, a causa dell'esistenza di due metodi distinti: la transclusione e la sostituzione, ciascuno con i propri vantaggi e svantaggi.

### Transclusione
La transclusione è il metodo più diffuso per inserire i template nelle pagine di Wikipedia. Questo approccio prevede il posizionamento del riferimento al template (un link "vivo") all'interno del documento corrente. Qualsiasi modifica futura all'aspetto del template si rifletterà automaticamente su tutte le pagine che vi fanno riferimento. Questa inclusione sequenziale di template contenenti template transclusi viene definita inclusione annidata. La sintassi di base per inserire un modello tramite transclusione è la seguente:

<pre>
&#123;&#123;&#123;&#123;Template name&#125;&#125;
</pre>

Questa sintassi può essere estesa per includere parametri:

<pre>
&#123;&#123;&#123;&#123;&#123;Template name | parameter | parameter | ...&#125;&#125;
</pre>

La transclusione assicura che le modifiche a un template siano applicate universalmente a tutte le pagine che lo utilizzano.

![Template transcluso](https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Transclusion-multiple-foo.svg/1024px-Transclusion-multiple-foo.svg.png){: width="100%"}

### Sostituzione
La sostituzione offre un metodo alternativo per l'inclusione dei template. Consiste nell'incorporare il codice del modello direttamente nel documento corrente usando la funzione "subst". Ciò significa che qualsiasi modifica futura al template originale non avrà effetto sulle pagine in cui è stato sostituito. La sintassi richiesta per inserire un template tramite sostituzione è la seguente:

<pre>
&#123;&#123;subst: Nome del template&#125;&#125;
</pre>

Analogamente alla transclusione, la sintassi di sostituzione può contenere parametri aggiuntivi:

<pre>
&#123;&#123;subst: Nome del template | parametro | parametro | ...&#125;&#125;
</pre>

Un vantaggio significativo della sostituzione è la capacità di includere e modificare il codice senza alterare il template originale, preservando così l'integrità delle istanze trascluse. Per i template di avviso utente, la sostituzione è comunemente utilizzata per salvaguardare i template dal vandalismo. I risultati della sostituzione dei template sono indipendenti dalla pagina del template al termine della sostituzione. Ecco un esempio di wikicodice dopo l'applicazione della funzione di sostituzione:

*Codice della funzione di sostituzione:*
<pre>
&#123;&#123;subst:foo&#125;&#125;
</pre>

*Codice inserito nella pagina di destinazione:*
```
Esempio di contenuto del modello.
```

Entrambi i metodi di transclusione e sostituzione possono essere organizzati in modo ricorsivo, ma quando un modello sostituito contiene modelli transclusi, il comportamento predefinito mantiene i riferimenti non modificati generati dal processo di transclusione. Tuttavia, è possibile personalizzare la funzione di sostituzione per creare una catena di sostituzioni e inserire il codice di ogni template citato, alterando così il processo di inclusione.

### Estrazione degli avvisi degli utenti
A differenza delle wikibreak e delle lingue, che vengono spesso inserite utilizzando la transclusione, gli avvisi degli utenti non seguono una strategia preferita.

Per questo motivo, gli approcci ingenui ed efficienti che estraggono le informazioni sui template usando le espressioni regolari non funzionano in tutti i casi.

Per identificare i template sostituiti, l'idea è stata quella di identificare prima il template riconoscendo le sue parole più importanti.
 
A tal fine, utilizziamo [tf-idf (term frequency-inverse document frequency)](https://en.wikipedia.org/wiki/Tf%E2%80%93idf), una statistica numerica, per identificare le parole più significative all'interno delle revisioni dei template. Questa metrica misura l'importanza di una parola in una raccolta di documenti (corpus) considerando sia la sua frequenza in un documento (frequenza di termine, $tf$) sia il modo in cui caratterizza in modo univoco l'intero corpus (frequenza di documento inversa, $idf$).

**Frequenza dei termini ($tf$):** 

{::nomarkdown}
$$tf(t, d) = \frac{f_{t,d}}{\sum_{t' \in d} f_{t',d}}$$
{:/}

La frequenza dei termini misura la frequenza con cui un termine appare in uno specifico documento. Più una parola è frequente in un documento, più è importante per quel documento.

**Frequenza inversa del documento ($idf$):** 

{::nomarkdown}
$$idf(t, D) = \frac{\log |D|}{|\{d \in D : t \in d\}|}$$
{:/}

La frequenza inversa dei documenti valuta quanto un termine caratterizzi in modo univoco l'intero corpus. È calcolata come il logaritmo del numero totale di documenti nel corpus diviso per il numero di documenti contenenti la parola specifica.

**Metrica complessiva ($tf$-$idf$):** 

{::nomarkdown}
$$tf-idf(t, d, D) = tf(t, d) \cdot idf(t, D)$$
{:/}

La metrica finale $tf$-$idf$ combina la frequenza dei termini e la frequenza inversa dei documenti per determinare l'importanza di una parola. Se un termine compare in tutti i documenti, il suo punteggio $tf$-$idf$ è 0, a indicare che non è caratteristico del corpus.

Tuttavia, in alcuni casi, come l'identificazione di parole caratteristiche nei template a blocchi, la metrica $tf$-$idf$ può avere dei limiti. Ad esempio, parole comuni come "blocco" possono comparire frequentemente in tutte le revisioni dei template, dando luogo a un punteggio $idf$ basso. Eppure, queste parole possono essere cruciali per identificare template specifici all'interno di una pagina.

Una volta recuperata la metrica $tf$-$idf$, il programma cerca le occorrenze delle parole più rilevanti all'interno della pagina utente utilizzando l'algoritmo [Aho-Corasick](https://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_algorithm). Se tutte le occorrenze sono state trovate, il modello viene considerato incluso.

Il problema di questo approccio, nonostante la sua relativa efficienza, è il numero di falsi positivi che la procedura può generare.

## Risultati

In questa sezione, discutiamo le lingue parlate dagli utenti di Wikipedia e la correlazione tra l'avviso degli utenti e l'abbandono.

Per quanto riguarda le lingue parlate dagli utenti di Wikipedia, abbiamo dimostrato che l'inglese è la lingua più frequentemente citata nella Wikipedia italiana, seguita dall'italiano stesso. 

Abbiamo anche dimostrato che l'italiano domina in modo schiacciante tra le lingue conosciute a livello di madrelingua all'interno della comunità italiana di Wikipedia, mentre l'inglese si colloca al terzo posto.

La parte più interessante dello studio mira a valutare l'impatto degli avvisi utente ad alta gravità sui livelli di attività degli utenti nella Wikipedia italiana. L'analisi ha escluso i divieti e i blocchi temporanei a causa dei loro effetti prevedibili sul comportamento degli utenti.

I nostri risultati indicano che oltre l'80% degli utenti di tutte le categorie ha registrato una diminuzione dell'attività in seguito ad avvisi di elevata gravità. In particolare, questa tendenza è stata costante per entrambi i sessi, anche se leggermente più pronunciata per le donne. 

In sintesi, abbiamo dimostrato che gli avvertimenti ad alta gravità hanno un impatto significativo sui livelli di attività degli utenti nella Wikipedia italiana, portando a una diminuzione dell'attività degli utenti in generale.

## Conclusioni e lavoro futuro
Sebbene questo progetto rappresenti un'esplorazione preliminare del comportamento degli utenti di Wikipedia, serve come base per analisi future. I contributi di questo lavoro includono una migliore comprensione della struttura dei contenuti di Wikipedia, i meccanismi di inclusione dei template e lo sviluppo di uno strumento per il consolidamento e l'analisi dei dati.

La comprensione del comportamento degli utenti di Wikipedia è fondamentale per migliorare la sostenibilità della piattaforma e per affrontare i problemi legati all'abbandono dei redattori. Questa ricerca fornisce preziose indicazioni sulle dinamiche di una delle più grandi piattaforme di conoscenza collaborativa del mondo.
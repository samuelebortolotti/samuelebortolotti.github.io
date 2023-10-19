---
layout: post
title: Distributed Multi-level Cache
lang: it
date: 2022-07-29
permalink: it/projects/multilevel-cache.html
ref: projects/multilevel-cache.html
repository: https://github.com/samuelebortolotti/multilevel-cache
url: https://github.com/samuelebortolotti/multilevel-cache
report: https://github.com/samuelebortolotti/multilevel-cache/blob/master/doc/Report.pdf
author: 
- Samuele Bortolotti
- Luca De Menego
nav_bar: projects
type: project
description: Distributed Multi-level Cache è un sistema di cache distribuita a più livelli progettato per gestire i crash a vari livelli gerarchici, garantendo al contempo la coerenza client-centrica. Questo sistema è stato sviluppato nell'ambito del corso di Sistemi Distribuiti 1 del master in Informatica dell'Università di Trento.
---
# Distributed Multi-level Cache
Questo progetto ruota attorno all'implementazione di un protocollo di cache distribuito a più livelli utilizzando [Java 8](https://www.oracle.com/java/technologies/java8.html) e [Akka](https://akka.io/). L'obiettivo primario è quello di creare un sistema robusto che gestisca efficacemente le operazioni di cache a vari livelli all'interno di un ambiente distribuito, garantendo al contempo una **coerenza centrata sul cliente**. Questo progetto è stato sviluppato nell'ambito del corso di Sistemi Distribuiti 1 presso la nostra istituzione, l'Università di Trento.

## Informazioni generali
Il concetto centrale di questo progetto è l'implementazione di un protocollo di cache distribuito a più livelli. Le cache, in quanto componente fondamentale del sistema, svolgono un ruolo cruciale nell'immagazzinare gli oggetti più frequentemente richiesti e nel rispondere autonomamente alle richieste dei client. Questa architettura è progettata per alleviare la congestione del database e ottimizzare le prestazioni.

Gli attori principali di questo progetto sono i client, le cache e un database centrale. Più client interagiscono con il sistema, eseguendo operazioni di lettura e scrittura sui dati memorizzati nel database. Il livello di cache, situato vicino ai client, è principalmente responsabile della gestione efficiente delle operazioni di lettura. Le operazioni di scrittura, invece, sono dirette al database primario. Il protocollo garantisce che i client che interagiscono con la stessa cache non ricevano valori obsoleti dopo operazioni di scrittura riuscite, offrendo così un'eventuale coerenza. Inoltre, il progetto incorpora due varianti "critiche" delle operazioni principali, ossia **CRITREAD** e **CRITWRITE**, per fornire maggiori garanzie.

Si presume che il contenuto del *database rimanga costante* durante l'esecuzione del protocollo. Per semplicità, i dati memorizzati nei database e nelle cache sono limitati a numeri interi.

**Gerarchia della cache:**

Le cache di questo progetto sono organizzate in una struttura gerarchica ad albero. Alcune cache operano al primo livello (cache L1) e mantengono una connessione diretta con il database. Le cache L1 fungono da genitori per le cache di secondo livello (cache L2), che interagiscono direttamente con i client, elaborando le loro richieste e restituendo i risultati.

**Operazioni supportate:**

Il progetto supporta le seguenti operazioni:

1. **LETTURA**: Quando una cache L2 riceve una richiesta di lettura, controlla se il valore richiesto è presente nella sua memoria. Se lo trova, risponde prontamente. Altrimenti, inoltra la richiesta alla sua cache L1. A seconda dello scenario, la cache L1 può rispondere con il valore (modalità read-through) o consultare il database principale. Le risposte vengono inoltrate a ritroso lungo il percorso della richiesta e le cache memorizzano l'elemento per richieste future. I timeout dei client devono considerare il tempo necessario a una richiesta per raggiungere il database.

2. **WRITE**: le richieste di scrittura vengono inviate direttamente al database, che esegue l'operazione e notifica l'aggiornamento a tutte le cache L1 associate. Successivamente, tutte le cache L1 inoltrano l'aggiornamento alle corrispondenti cache L2. Questo approccio garantisce che la modifica venga propagata a ogni cache, un requisito per ottenere la coerenza finale. In particolare, l'elemento scritto viene aggiornato solo nelle cache che lo contenevano in precedenza.

3. **CRITREAD**: simile a un'operazione di lettura, CRITREAD recupera il valore più recente dal database. Tuttavia, a differenza di una normale lettura, questa richiesta viene trasmessa anche se l'elemento è già presente nella cache L2 o L1.

4. **CRITWRITE**: CRITWRITE è analogo all'operazione WRITE, che implica una richiesta al database. Tuttavia, il database deve garantire che nessuna cache conservi un valore obsoleto per l'elemento scritto prima di applicare l'operazione di scrittura. Il database propaga la modifica, in modo simile all'operazione WRITE, una volta confermato che gli oggetti memorizzati nella cache sono stati aggiornati.

**Crashes e ripristini:**

Le cache all'interno del sistema potrebbero subire arresti anomali durante i processi algoritmici critici. Per risolvere questo problema, il progetto utilizza un semplice meccanismo di rilevamento degli arresti anomali basato sul timeout. Quando un client rileva un arresto anomalo in una cache L2, seleziona una cache L2 alternativa e reindirizza le sue richieste. Se una cache L2 identifica il crash del suo genitore L1, designa il database primario come nuovo genitore. In caso di arresto anomalo della cache, tutti gli oggetti archiviati vengono persi, presupponendo che siano stati archiviati nella memoria volatile. Tuttavia, le cache conservano le informazioni di sistema essenziali, incluso l'attore del database e l'ActorRef degli alberi vicini. Le cache si ripristinano automaticamente e riprendono il funzionamento dopo un intervallo di tempo predefinito.

Per ulteriori informazioni sul quadro normativo o sulla sua attuazione si rimanda al rapporto.

## Contributori
- Samuele Bortolotti
- [Luca De Menego](https://github.com/lucademenego99)
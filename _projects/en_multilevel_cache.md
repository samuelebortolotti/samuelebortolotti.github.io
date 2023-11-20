---
layout: post
title: Distributed Multi-level Cache
lang: en
date: 2022-07-29
permalink: projects/multilevel-cache.html
ref: projects/multilevel-cache.html
repository: https://github.com/samuelebortolotti/multilevel-cache
url: https://github.com/samuelebortolotti/multilevel-cache
report: https://github.com/samuelebortolotti/multilevel-cache/blob/master/doc/Report.pdf
author: 
- Samuele Bortolotti
- Luca De Menego
nav_bar: projects
type: project
description: Distributed Multi-level Cache is a distributed cache system with multiple levels designed to handle crashes at various hierarchy levels while ensuring client-centric consistency. This system was developed as part of the Distributed Systems 1 course in the Computer Science master's program at the University of Trento.
---
# Distributed Multi-level Cache
This project revolves around the implementation of a distributed multi-level cache protocol using [Java 8](https://www.oracle.com/java/technologies/java8.html) and [Akka](https://akka.io/). The primary objective is to create a robust system that effectively manages cache operations at various levels within a distributed environment while ensuring **client-centric consistency**. This project is developed as part of the Distributed Systems 1 course at our institution, the University of Trento.

## General Information
The core concept of this project centers on the implementation of a distributed multi-level cache protocol. Caches, as a fundamental component of the system, play a crucial role in storing frequently requested objects and autonomously responding to client requests. This architecture is designed to alleviate database congestion and optimize performance.

The key actors in this project include clients, caches, and a central database. Multiple clients interact with the system, performing both read and write operations on data stored in the database. The cache layer, situated near the clients, is primarily responsible for handling read operations efficiently. In contrast, write operations are directed to the primary database. The protocol ensures that clients interacting with the same cache do not receive outdated values after successful write operations, thus offering eventual consistency. Additionally, the project incorporates two "critical" variations of the core operations, namely **CRITREAD** and **CRITWRITE**, to provide enhanced assurances.

It is assumed that the *database's content remains constant* throughout the protocol's execution. For the sake of simplicity, the data stored in both databases and caches is limited to integer numbers.

**Cache Hierarchy:**

Caches in this project are organized in a hierarchical tree structure. Some caches operate at the first level (L1 caches) and maintain a direct connection to the database. L1 caches act as parents to the second-level caches (L2 caches), which interact directly with clients, processing their requests and returning results.

**Supported Operations:**

The project supports the following operations:

1. **READ**: When an L2 cache receives a read request, it checks if the requested value is present in its memory. If found, it promptly responds. Otherwise, it forwards the request to its parent L1 cache. Depending on the scenario, the L1 cache may respond with the value (read-through mode) or consult the main database. Responses traverse backward along the request path, with caches storing the item for future requests. Client timeouts should consider the time required for a request to reach the database.

2. **WRITE**: Write requests are sent directly to the database, which executes the operation and notifies all associated L1 caches of the update. Subsequently, all L1 caches relay the update to their corresponding L2 caches. This approach ensures that the change is propagated to every cache, a requirement for achieving eventual consistency. Notably, the written item is updated only in caches that previously held it.

3. **CRITREAD**: Similar to a read operation, CRITREAD fetches the most recent value from the database. However, unlike a regular read, this request is transmitted even if the item is already present in the L2 or L1 cache.

4. **CRITWRITE**: CRITWRITE is analogous to the WRITE operation, involving a request to the database. However, the database must ensure that no cache retains an outdated value for the written item before applying the write operation. The database propagates the change, similar to the WRITE operation, once it confirms that the cached objects have been updated.

**Crashes and Recoveries:**

Caches within the system may encounter crashes during critical algorithmic processes. To address this, the project employs a straightforward timeout-based crash detection mechanism. When a client detects a crash in an L2 cache, it selects an alternate L2 cache and reroutes its requests. If an L2 cache identifies the crash of its L1 parent, it designates the primary database as the new parent. In the event of a cache crash, all stored objects are lost, assuming they were stored in volatile memory. However, caches retain essential system information, including the database actor and the ActorRef of their tree neighbors. Caches automatically recover and resume operation after a predefined time interval.

For additional information regarding the framework or its implementation, please refer to the report.

## Contributors
- Samuele Bortolotti
- [Luca De Menego](https://github.com/lucademenego99)
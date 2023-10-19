---
layout: post
title: Particle Swarm Optimization
lang: en
mathjax: true
date: 2022-11-22
permalink: projects/pso.html
ref: projects/pso.html
repository: https://github.com/samuelebortolotti/ParticleSwarmOptimization-OpenMPI
url: https://github.com/samuelebortolotti/ParticleSwarmOptimization-OpenMPI
report: https://fedeizzo.github.io/ParticleSwarmOptimization-OpenMPI/report.pdf
author: 
- Samuele Bortolotti
- Federico Izzo
nav_bar: projects
type: project
description: PSO-OpenMPI is a project developed specifically for the High Performance Computing for Data Science course as part of the Master's Degree program in Computer Science at the University of Trento. It provides a fundamental implementation of Particle Swarm Optimization (PSO) with support for cluster-based computations using OpenMPI, along with efficient thread parallelization through OpenMP.
---
# Particle Swarm Optimization: a parallelized approach

## General Information

Parallel Particle Swarm Optimization (PSO) project delves into the realm of optimization techniques, focusing primarily on the concepts of "particles" and "particle perception."

In the context of PSO, a particle is a fundamental entity characterized by:

- A position, denoted as $x$, representing a candidate solution for an optimization problem.
- A velocity component, denoted as $v$, which is used to perturb the particle's position.
- A performance measure, denoted as $f(x)$ or fitness value, quantifying the quality of the candidate solution.

The entire collection of particles forms a "swarm."

Each particle needs to perceive the positions and associated performance measures of neighboring particles. This allows each particle to remember the best performance position ($z$) among its neighbors and its own best performance ($y$) up to the current point.

This project implements a version of PSO employing a "distance-based" neighborhood approach in a nearest neighbor fashion. Specifically, each particle maintains a fixed number of neighbors, which dynamically adjusts based on the particle's position within the landscape.

## Parametrization

The PSO algorithm involves several critical parameters:

- Swarm size, typically around 20 particles for problems with a dimensionality ranging from 2 to 200.
- Neighborhood size, typically between 3 to 5 neighbors or a global neighborhood.
- Velocity update factors.

## Continuous Optimization

The PSO begins with the initialization of a swarm of particles, each assigned random positions and velocities.

During each iteration, each particle updates its velocity using the equation:

{::nomarkdown}
$$v' = w \cdot v + \phi_1 U_1 \cdot (y - x) + \phi_2 U_2 \cdot (z - x)$$
{:/}

Here:
- $x$ and $v$ represent the particle's current position and velocity.
- $y$ and $z$ denote the personal best and social/global best positions, respectively.
- $w$ stands for the inertia weight that factors in the current velocity.
- $\phi_1$ and $\phi_2$ are acceleration coefficients or learning rates, governing cognitive and social influences, respectively.
- $U_1$ and $U_2$ are random numbers uniformly distributed between 0 and 1.

Subsequently, each particle updates its position using:

{::nomarkdown}
$$x' = x + v'$$
{:/}

If there's an improvement in performance, the particle updates its personal best ($y$) and potentially the global best ($z$).

## State-of-the-Art Analysis

A review of existing PSO implementations revealed three primary categories:

1. Algorithms that modify the PSO behavior by introducing new features.
2. PSO implementations focused on solving specific real-world problems.
3. Efforts aimed at optimizing the runtime execution speed.

The project excludes the second category as these solutions are highly problem-dependent. The first category is suitable for benchmarking analysis but often requires code modifications, leading to potential inconsistencies. The third category, which optimizes runtime speed, serves as the primary competitor, and various PSO versions have been implemented.


| **Ref.**           | **Year** | **Type**      | **Code** | **Note** |
|--------------------|----------|---------------|----------|----------|
| [Kennedy, J. and Eberhart, R.](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=488968&casa_token=eqJLQ_W1pp0AAAAA:xo3yRuvebzTFfkNDtll0jBbqH--kmGtJCCcDlG5K2XSQm28LhdIvRlrYWuwMxLxmy4YD6ghRr_c) | 1995     | Serial        | No       | -        |
| [toddguant](https://github.com/toddgaunt/cpso)       | 2019     | Serial        | Yes      | 1        |
| [sousouho](https://github.com/sousouhou/succinctPSO)        | 2019     | Serial        | Yes      | 1        |
| [kkentzo](https://github.com/kkentzo/pso)         | 2020     | Serial        | Yes      | 1        |
| [fisherling](https://github.com/fisherling/pso)      | 2020     | Serial        | Yes      | 1        |
| [Antonio O.S. Moraes et al.](https://doi.org/10.1016/j.apm.2014.12.034)     | 2014     | MPI           | No       | -        |
| [Nadia Nedjah et al.](https://link.springer.com/chapter/10.1007/978-3-319-62932-2_20)    | 2017     | MPI/MP        | No       | -        |
| [abhi4578](https://github.com/abhi4578/Parallelization-of-PSO)        | 2019     | MPI/MP,CUDA   | Yes      | 1        |
| [LaSEEB](https://github.com/abhi4578/openpso)          | 2020     | OpenMP        | Yes      | 2        |
| [pg443](https://github.com/pg443/Particle-Swarm-Optimization-OpenMP)           | 2021     | Serial,OpenMP | Yes      | 1        |


The indexes in the notes refer to:

1. provides only global neighborhood implementation. Thus, the comparison would be untruthful as those implementations have a clear advantage in the execution time due to a favorable topology;
2. provides PSO with different neighborhood versions but without a distance based approach. Hence, the implication are the same as for the point 1.

## Main Step Towards Parallelization

This project focused on achieving parallelization using a hybrid OpenMP-MPI approach. It introduced multiprocessing and efficient communication strategies to enhance PSO performance.

### Serial Version of the Algorithm

The PSO algorithm's core steps include particle initialization, position exchange among the swarm, particle sorting based on distance, and position and velocity updates. Initial attempts to parallelize with OpenMP revealed significant overhead for small problems, leading to slower execution times compared to the single-threaded model.

### Parallel Version of the Algorithm

The workload was distributed among multiple processes using the MPI library, and multiprocessing was utilized through OpenMP for various shared-memory tasks.

#### Architecture

A parallel computational pattern, the "all-to-all" model, was implemented using MPI\_Allgather to exchange individual messages among all processes.

![Communication schema](https://raw.githubusercontent.com/samuelebortolotti/ParticleSwarmOptimization-OpenMPI/master/report/images/communication_schema.png){: width="100%"}

#### Message

To facilitate inter-process communication, a custom MPI data type named "broadcastMessage\_t" was introduced, containing information such as timestamps, iteration numbers, particle identifiers, sender ranks, and solution data.

### Communication Pattern

Communication between processes was synchronous. Each process handled a portion of the particles, and particle information was exchanged using MPI\_Allgather. The sorted particles enabled each process to identify the nearest neighbors for individual particles.

## Benchmarking

A comprehensive benchmarking analysis was conducted by varying the number of threads, processes, and PBS process allocation patterns. The primary configuration included a problem dimension of 50, 5000 particles, 500 iterations, and other relevant parameters.

Results revealed that for thread parallelization, the overhead introduced by OpenMP often outweighed the performance benefits. Thread parallelization was found to be unsuitable for all problems due to the varying behavior of different systems.

Benchmarking mainly focused on the multi-process solution. Results showed that as the number of processes increased, the time required for communication also increased. The optimal scenario was observed when using a limited number of processes, as the overhead associated with MPI communication became significant with larger process counts.

## Final Discussion

The project successfully developed a hybrid OpenMP-MPI algorithm for complex continuous optimization problems, equipped with a robust DevOps pipeline.

Thread parallelization was found to be ineffective for PSO, often leading to performance degradation due to excessive overhead. Benchmarking

## Contributors
- Samuele Bortolotti
- [Federico Izzo](https://github.com/fedeizzo)
---
layout: post
lang: en
title: File Analyzer
description: An efficient multithread and multiprocess program in C to analyze recursively the files contained inside a folder and produce statistics about them.
date: 2020-04-28
permalink: projects/file-analyzer.html
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

## General Information
Group project for the Operative System (OS) course of the Bachelor's Degree in Computer Science at University of Trento.

## Description & Objectives
The main focus of this project is to count the occurrences of ASCII characters inside one or more files.

To make all as extensible and modular as possible, we have developed several components, each of them having specific tasks. In particular:

- **Counter** spawns the reporter and the analyzer.
- **Reporter** creates the terminal user interface **Tui** and communicates with the analyzer.
- **Analyzer** takes all inputs from the user and finds all files given a directory. Then, while files are being discovered, analyzer sends founded ones to managers.
- **Manager** takes files and split them in several works. A work starts from a specific point of the file and ends in another. When works are ready they are sent to workers.
- **Worker** takes the file, the start point and the end point. After that he reads the portion of the file

The program structure is depicted in here:

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png?raw=truehttps://github.com/fedeizzo/file-analyzer/blob/master/img/structure.png" alt="Program Structure" width="100%">

## Results
- We have developed an efficient *multithread* and *multiprocess* program in *C* to analyze recursively the files contained inside a folder and produce statistics about them — *average of 51 files/seconds*.
- User interaction is supported through a *Terminal User Interface* (TUI) to handle which files to consider, the number of processes to be spawned, the statistics to be shown, and to traverse the local file system.

A glance of the program execution is shown here: 

<img src="https://github.com/fedeizzo/file-analyzer/blob/master/GIFME.gif?raw=true" alt="System at Work" width="100%">

## Contributors
- Samuele Bortolotti
- [Federico Izzo](https://github.com/fedeizzo)
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Emanuele Beozzo](https://github.com/emanuelebeozzo)

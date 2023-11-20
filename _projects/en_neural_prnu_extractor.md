---
layout: post
title: Neural PRNU Extractor
lang: en
date: 2022-11-22
mathjax: true
permalink: projects/neural-prnu-extractor.html
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
description: Neural-PRNU-Extractor is a PyTorch-based project that extends FFDNet, originally designed for image denoising. It has been adapted to extract cameras' PRNU patterns. This project has been developed for the Signal, Image, and Video course within master's degree program in Artificial Intelligence Systems and Computer Science at the University of Trento.
---

# Neural-PRNU-Extractor

## Project Overview

Neural-PRNU-Extractor is a modified PyTorch implementation of the [FFDNet](https://arxiv.org/abs/1710.04026) image denoising technique. Originally developed as part of the Signal, Image, and Video course for the master's degree program in Artificial Intelligence Systems and Computer Science at the University of Trento, this project extends the capabilities of FFDNet.

## Key Features

- **PRNU Extraction:** Unlike the original FFDNet, this modified version focuses on the extraction of cameras' [PRNU (Photo Response Non-Uniformity)](https://en.wikipedia.org/wiki/Photo_response_non-uniformity).

- **Training Options:** Neural-PRNU-Extractor provides the flexibility to train the network using the Wiener filter as a noise extraction strategy, in addition to the method outlined in the FFDNet paper.

## Project Objective

{::nomarkdown}
The primary goal of Neural-PRNU-Extractor is noise reduction in images. It aims to predict and remove noise from images captured by digital and film cameras, enhancing their suitability for various applications in computer vision. The project can effectively predict noise levels (\(\sigma \in [0, 75]\)) in images.
{:/}

Additionally, Neural-PRNU-Extractor can compute and evaluate PRNU patterns based on a dataset of flat images, allowing for the identification of the specific device that generated an image. PRNU, or Photo Response Non-Uniformity, is a crucial factor in digital image sensors, commonly found in cameras and optical instruments, making it a valuable tool for device identification and verification.

The PRNU extraction pipeline can be seen here: <a href="https://github.com/samuelebortolotti/neural-prnu-extractor/blob/master/presentation/imgs/prnu_extraction_pipeline.pdf?raw=true">Download PDF</a>

## Contributors
- Samuele Bortolotti
- [Simone Alghisi](https://github.com/Simone-Alghisi)
- [Massimo Rizzoli](https://github.com/massimo-rizzoli)
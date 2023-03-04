#!/bin/bash

mkdir output/bam

samtools view -Sb output/samfiles/sam1.sam -o output/bam/bam1.bam -@ 32
samtools view -Sb output/samfiles/sam2.sam -o output/bam/bam2.bam -@ 32


samtools sort output/bam/bam1.bam -o output/bam/sam1.sorted.bam -@ 32
samtools sort output/bam/bam1.bam -o output/bam/sam2.sorted.bam -@ 32





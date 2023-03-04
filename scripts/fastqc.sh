#!/bin/bash

fastqc data/sample1_forward.fastq.gz -outdir output/fastqc -t 32 &
fastqc data/sample1_reverse.fastq.gz -outdir output/fastqc -t 32 &
fastqc data/sample2_forward.fastq.gz -outdir output/fastqc -t 32 &
fastqc data/sample2_reverse.fastq.gz -outdir output/fastqc -t 32 &

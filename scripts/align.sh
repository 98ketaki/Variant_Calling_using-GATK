#!/bin/bash

mkdir output/samfiles

bwa mem -M -t 32 -R "@RG\tID:id\tSM:sample\tLB:lib" reference/ref.fa data/sample1_forward.fastq.gz data/sample1_reverse.fastq.gz  > output/samfiles/sam1.sam

bwa mem -M -t 32 -R "@RG\tID:id\tSM:sample\tLB:lib" reference/ref.fa data/sample2_forward.gz data/sample2_reverse.fastq.gz  > output/samfiles/sam2.sam


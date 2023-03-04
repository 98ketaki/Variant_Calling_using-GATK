#!/bin/bash

mkdir output/samfiles

bwa mem -M -t 32 -R "@RG\tID:id\tSM:sample\tLB:lib" reference/ref.fa data/sample1_forward.fastq.gz data/sam1_reverse.fastq.gz  > output/samfiles/sam1.sam

bwa mem -M -t 32 -R "@RG\tID:id\tSM:sample\tLB:lib" reference/ref.fa data/sam2__forward.gz data/sam2_reverse.fastq.gz  > output/samfiles/sam2.sam


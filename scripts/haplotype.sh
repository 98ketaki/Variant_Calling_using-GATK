#!/bin/bash

mkdir vcf/output/gatk

gatk --java-options "-Xmx30g -XX:ParallelGCThreads=1" HaplotypeCaller --native-pair-hmm-threads 32  -R vcf/reference/ref.fa -I vcf/output/bam/sam1.final.bam -O vcf/output/gatk/sam1.gvcfMode.vcf -ERC GVCF &
gatk --java-options "-Xmx30g -XX:ParallelGCThreads=1" HaplotypeCaller --native-pair-hmm-threads 32  -R vcf/reference/ref.fa -I vcf/output/bam/sam2.final.bam -O vcf/output/gatk/sam2.gvcfMode.vcf -ERC GVCF 

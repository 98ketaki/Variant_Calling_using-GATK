#!/bin/bash

gatk --java-options "-Xmx100g" CombineGVCFs -R vcf/reference/ref.fa -V vcf/output/gatk/sam1.gvcfMode.vcf -V vcf/output/gatk/sam2.gvcfMode.vcf -O vcf/output/gatk/sam_all.gvcfMode.vcf

gatk --java-options "-Xmx100g" GenotypeGVCFs -R vcf/reference/ref.fa -V vcf/output/gatk/sam_all.gvcfMode.vcf -O vcf/output/gatk/output.vcf

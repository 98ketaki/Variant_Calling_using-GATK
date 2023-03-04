#!/bin/bash

bcftools view output/SNP/only_SNPs_Final.vcf |
bgzip -c > output/SNP/snp_subset.vcf.gz
tabix -p vcf output/SNP/snp_subset.vcf.gz


#!/bin/bash

mkdir vcf/output/SNP

gatk SelectVariants --variant vcf/output/output.vcf --output vcf/output/SNP/only_SNPs.vcf --reference vcf/reference/ref.fa --select-type-to-include SNP --restrict-alleles-to BIALLELIC

gatk VariantFiltration --reference vcf/ref_chr2/ref.fa --variant vcf/output/SNP/only_SNPs.vcf -filter "QD < 2.0" --filter-name "QD2" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "SOR > 3.0" --filter-name "SOR3"  -filter "FS > 60.0" --filter-name "FS60" -filter "MQ < 40.0" --filter-name "MQ40" -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" --genotype-filter-expression "isHet == 1" --genotype-filter-name "isHetFilter" -O vcf/output/SNP/only_SNPs_filters_added.vcf 

gatk SelectVariants -variant vcf/output/SNP/only_SNPs_filters_added.vcf --reference vcf/reference/ref.fa --output vcf/output/SNP/snps_withoutHTs.vcf --set-filtered-gt-to-nocall 
 
gatk SelectVariants -variant vcf/output/SNP/snps_withoutHTs.vcf --reference vcf/reference/ref.fa --output vcf/output/SNP/only_SNPs_Final.vcf --exclude-filtered true --exclude-non-variants true

gatk VariantsToTable -R vcf/reference/ref.fa -V vcf/output/SNP/only_SNPs_Final.vcf -F CHROM -F POS -F FILTER -F TYPE -GF AD -GF DP --show-filtered -O vcf/output/SNP/snp_table.tsv

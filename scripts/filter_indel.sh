#!/bin/bash

mkdir vcf/output/indel

gatk SelectVariants --variant vcf/output/output.vcf --output vcf/output/indel/only_INDELs.vcf --reference vcf/reference/ref.fa --select-type-to-include INDEL --restrict-alleles-to BIALLELIC 

gatk VariantFiltration -V vcf/output/indel/only_INDELs.vcf -filter "QD < 2.0" --filter-name "QD2" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "FS > 200.0" --filter-name "FS200" -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" --genotype-filter-expression "isHet == 1" --genotype-filter-name "isHetFilter" -O vcf/output/indel/only_INDELs_filters_added.vcf 

gatk SelectVariants -variant vcf/output/indel/only_INDELs_filters_added.vcf --reference vcf/reference/ref.fa --output vcf/output/indel/indels_withoutHTs.vcf --set-filtered-gt-to-nocall

gatk SelectVariants -variant vcf/output/indel/indels_withoutHTs.vcf --reference vcf/reference/ref.fa --output vcf/output/indel/only_INDELs_Final.vcf --exclude-filtered true --exclude-non-variants true

gatk VariantsToTable -R vcf/reference/ref.fa -V vcf/output/indel/only_INDELs_Final.vcf -F CHROM -F POS -F FILTER -F TYPE -GF AD -GF DP --show-filtered -O vcf/output/indel/indel_table.tsv

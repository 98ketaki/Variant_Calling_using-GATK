#!/bin/bash

bcftools view output/indel/only_INDELs_Final.vcf |
bgzip -c > output/indel/indel_subset.vcf.gz
tabix -p vcf output/indel/indel_subset.vcf.gz

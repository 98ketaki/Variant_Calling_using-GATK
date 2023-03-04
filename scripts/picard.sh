#!/bin/bash

picard MarkDuplicates I=output/bam/sam1.sorted.bam O=output/bam/sam1.marked_duplicates.bam M=output/bam/sam1.marked_dup_metrics.txt &
picard MarkDuplicates I=output/bam/sam2.sorted.bam O=output/bam/sam2.marked_duplicates.bam M=output/bam/sam2.marked_dup_metrics.txt 


picard SortSam I=output/bam/sam1.marked_duplicates.bam O=output/bam/sam1.final.bam SORT_ORDER=coordinate &
picard SortSam I=output/bam/sam2.marked_duplicates.bam O=output/bam/sam2.final.bam SORT_ORDER=coordinate 

samtools index output/bam/sam1.final.bam -@ 8 &
samtools index output/bam/sam2.final.bam -@ 8 

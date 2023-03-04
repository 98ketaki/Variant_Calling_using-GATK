# Variant Calling using GATK

To Determine the SNPs and indels in two paired end samples  


## Setting up the environment and data preparation
I setup an AWS EC2 instance and created a conda environment to install all the required tools to build the pipeline.

```
conda create --name var_call
conda activate var_call
conda install -c bioconda fastqc
conda install -c bioconda bwa
conda install -c bioconda samtools openssl=1.0
conda install -c bioconda picard
conda install -c bioconda bcftools
conda install -c bioconda tabix
```

I used "Filezilla" to transfer the files from my local repository to AWS. I setup the directories as follows:

```
mkdir data
mkdir output
mkdir scripts
mkdir reference
```
The two paired end raw sequences data were placed in the directory "data" and the reference genome was placed in the directory "reference" as ref.fa.gz.


## Quality Check of the raw fastq data using fastqc
I did a quality check of all the raw sequencing data using [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/). The results showed that all the sequences were of good quality therefore I did not process it further (scripts/fastqc.sh)

## Aligning the reads to reference genome and preparing files for analysis
I created the index file for the reference genome using [bwa](https://bio-bwa.sourceforge.net/) 

```
bwa index ref.fasta.gz
```

I mapped the paired end raw sequence data to the reference genome using [bwa](https://bio-bwa.sourceforge.net/). The output after performing the alignment are samfiles (./scripts/align.sh)


I used [samtools](http://www.htslib.org/doc/samtools.html) to convert the obtained samfiles into bamfiles and then sorting the bamfiles (./scripts/sort.sh)



The next step is to locate and tag duplicate reads in the BAM file and sort them using [Picard](https://broadinstitute.github.io/picard/). I indexed the final bam file using [samtools](http://www.htslib.org/doc/samtools.html) (./scripts/picard.sh)



## Variant Calling Using gatk
The next step is Variant Calling using [gatk](https://gatk.broadinstitute.org/hc/en-us). This tool has specific requirements for the reference file - it needs to be indexed and need a sequence dictionary.

```
samtools faidx ref.fasta
picard CreateSequenceDictionary R=ref.fasta O=ref.dict
```
Once the reference genome is ready, I used a gatk docker container (./scripts/docker.sh) to run the gatk tool. I used gatk HaplotypeCaller to call the snps and variants (./scripts/haplotype.sh)


I combined all the vcf files obtained from variant calling to create a merged vcf file (./scripts/merge.sh)


## Filtering the variants to obtain the SNPs and Indels
For filtering the variants, I first separated the SNPs and Indels followed by hard filtering steps. The final SNPs and indels are then extracted to form a table which can be used for further analysis (./scripts/filter_snp.sh and ./scripts/filter_indel.sh). The SNP table can be found under output/SNP/snp_table.tsv and the indels table can be found under output/indel/indel_table.tsv

## Visualization of the variants
The variants can be visualized using common tools like the IGV. The next step is to prepare the vcf files to for visualization using [bcftools](https://samtools.github.io/bcftools/) and [tabix](http://www.htslib.org/doc/tabix.html) (./scripts/view_snp.sh and ./scripts/view_indel.sh)

Once these files are ready, we can visualize the files using IGV software as follows by choosing the appropriate reference file and uploading the vcf file.

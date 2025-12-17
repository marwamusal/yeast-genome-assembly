#!/bin/bash
#SBATCH --job-name=sy14_bwa_mem
#SBATCH --output=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_bwa_mem_%j.out
#SBATCH --error=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_bwa_mem_%j.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --partition=msc_appbio

module load bwa/0.7.17-gcc-13.2.0
module load samtools/1.19

ASSEMBLY=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly/SY14/SY14.contigs.fasta
READDIR=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/data/SY14/illumina

bwa mem -t 8 $ASSEMBLY \
    $READDIR/SY14_R1.fastq.gz \
    $READDIR/SY14_R2.fastq.gz \
  | samtools sort -o SY14.bam

samtools index SY14.bam

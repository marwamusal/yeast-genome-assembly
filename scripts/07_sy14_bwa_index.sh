#!/bin/bash
#SBATCH --job-name=sy14_bwa_index
#SBATCH --output=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_bwa_index_%j.out
#SBATCH --error=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_bwa_index_%j.err
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=02:00:00
#SBATCH --partition=msc_appbio

module load bwa/0.7.17-gcc-13.2.0

cd /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly/SY14

bwa index SY14.contigs.fasta

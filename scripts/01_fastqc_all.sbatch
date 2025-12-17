#!/bin/bash
#SBATCH --job-name=fastqc_all
#SBATCH --partition=msc_appbio
#SBATCH --cpus-per-task=4
#SBATCH --mem=12G
#SBATCH --time=02:00:00
#SBATCH --output=fastqc_all_%j.out

# Load FastQC module
module load fastqc

# Base directories
BASE_DIR=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling
DATA_DIR=${BASE_DIR}/data
QC_DIR=${BASE_DIR}/qc_reports

# Make sure output directories exist
mkdir -p ${QC_DIR}/BY4742_fastqc
mkdir -p ${QC_DIR}/SY14_fastqc

# Run FastQC for BY4742
fastqc ${DATA_DIR}/BY4742/illumina/*.fastq.gz \
    -o ${QC_DIR}/BY4742_fastqc \
    -t 4

# Run FastQC for SY14
fastqc ${DATA_DIR}/SY14/illumina/*.fastq.gz \
    -o ${QC_DIR}/SY14_fastqc \
    -t 4

echo "FastQC analysis completed for both strains!"

#!/bin/bash
#SBATCH --job-name=sy14_canu_assemble
#SBATCH --output=/scratch/%u/sy14_project/logs/canu_SY14_%j.out
#SBATCH --error=/scratch/%u/sy14_project/logs/canu_SY14_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=120G
#SBATCH --time=8:00:00
#SBATCH --partition=msc_appbio

# Load conda environment
module load anaconda3/2022.10-gcc-13.2.0
source activate canu_env

# Go to assembly folder
cd /scratch/$USER/sy14_project/assembly

# Run Canu on corrected reads
canu \
  -p SY14 \
  -d SY14 \
  genomeSize=12m \
  -pacbio-corrected SY14.correctedReads.fasta.gz \
  maxThreads=4 \
  maxMemory=120

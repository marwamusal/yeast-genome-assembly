#!/bin/bash
#SBATCH --job-name=sy14_assemblyrun2_recovered
#SBATCH --output=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/canu_%j.out
#SBATCH --error=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/canu_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=120G
#SBATCH --time=8:00:00
#SBATCH --partition=msc_appbio

# Load conda environment with Canu installed
module load anaconda3/2022.10-gcc-13.2.0
source activate canu_env

# Run Canu
canu \
  -p SY14 \
  -d /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly/SY14 \
  genomeSize=12m \
  -pacbio-raw /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/data/SY14/pacbio/*.fastq.gz \
  maxThreads=4 \
  maxMemory=120G

#!/bin/bash
#SBATCH --job-name=BY4742_SRR6823437_assembly
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
  -p BY4742_SRR6823437 \
  -d /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly/BY4742/SRR6823437 \
  genomeSize=12m \
  -pacbio-raw /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/data/BY4742/pacbio/SRR6823437_1.fastq.gz \
  maxThreads=4 \
  maxMemory=120

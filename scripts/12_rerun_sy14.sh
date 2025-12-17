#!/bin/bash
#SBATCH --job-name=sy14_final
#SBATCH --output=logs/sy14_final_%j.out
#SBATCH --error=logs/sy14_final_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --partition=msc_appbio

module load anaconda3
conda activate canu_env

cd /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly

canu \
  -p SY14 \
  -d SY14 \
  genomeSize=12m \
  -pacbio /cephfs/volumes/hpc_data_grp/msc_appbio/70e465a3-ea70-4bd6-b919-9da7af124271/Group2_ABCC/Gene_Assembling/data/SY14/pacbio/SRR6823435_1.fastq.gz \
  maxThreads=4 \
  maxMemory=8

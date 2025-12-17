#!/bin/bash
#SBATCH --job-name=yeast_download
#SBATCH --output=yeast_download.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=6:00:00
#SBATCH --mem=8G
#SBATCH --partition=msc_appbio

module load sra-tools/3.0.3-gcc-13.2.0

# Script to download yeast SRR datasets into organized directories

echo "Starting downloads at $(date)"

# SY14 PacBio
echo "Downloading SY14 PacBio (SRR6823435)"
cd SY14/pacbio
prefetch SRR6823435
fastq-dump --split-files SRR6823435
gzip *.fastq
cd ../..

# SY14 Illumina
echo "Downloading SY14 Illumina (SRR6825081)"
cd SY14/illumina
prefetch SRR6825081
fasterq-dump --split-files SRR6825081
gzip *.fastq
cd ../..

# BY4742 PacBio 1
echo "Downloading BY4742 PacBio cell 1 (SRR6823437)"
cd BY4742/pacbio
prefetch SRR6823437
fastq-dump --split-files SRR6823437
gzip *.fastq

# BY4742 PacBio 2
echo "Downloading BY4742 PacBio cell 2 (SRR6823436)"
prefetch SRR6823436
fastq-dump --split-files SRR6823436
gzip *.fastq
cd ../..

# BY4742 Illumina
echo "Downloading BY4742 Illumina (SRR6825082)"
cd BY4742/illumina
prefetch SRR6825082
fasterq-dump --split-files SRR6825082
gzip *.fastq
cd ../..

echo "All downloads completed at $(date)"

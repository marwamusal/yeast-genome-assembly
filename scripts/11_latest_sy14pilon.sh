#!/bin/bash
#SBATCH --job-name=sy14_pilon
#SBATCH --output=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_pilon_%j.out
#SBATCH --error=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_pilon_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=120G
#SBATCH --time=12:00:00
#SBATCH --partition=cpu

# 1. Purge modules
module purge


# 2. Load anaconda and activate pilon environment
module load anaconda3/2022.10-gcc-13.2.0
source activate /scratch/grp/msc_appbio/Group2_ABCC/conda_envs/pilon_env


# 3. Set Java heap memory 
export _JAVA_OPTIONS="-Xmx55G"


# 4. Go to assembly directory
cd /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly/SY14


# 5. Remove old Pilon logs to avoid clutter
rm -f SY14_pilon*  # remove old outputs if any


# 6. Run Pilon 
pilon \
  --genome SY14.contigs.fasta \
  --frags SY14_illumina_mapped.bam \
  --output SY14_pilon \
  --changes


echo "Pilon polishing completed at $(date)"


# Verification

echo "Number of contigs in polished assembly:"
grep -c ">" SY14_pilon.fasta

echo "Assembly size:"
grep -v ">" SY14_pilon.fasta | tr -d '\n' | wc -c

echo "Number of corrections made:"
wc -l SY14_pilon.changes

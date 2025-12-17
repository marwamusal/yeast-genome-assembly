#!/bin/bash
#SBATCH --job-name=sy14_pilon
#SBATCH --output=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_pilon_%j.out
#SBATCH --error=/scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/logs/sy14_pilon_%j.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=64G
#SBATCH --time=12:00:00
#SBATCH --partition=cpu

# -------------------------
# 1. Purge modules
# -------------------------
module purge

# -------------------------
# 2. Go to assembly directory
# -------------------------
cd /scratch/grp/msc_appbio/Group2_ABCC/Gene_Assembling/assembly/SY14

# -------------------------
# 3. Add Pilon environment to PATH
#    (so Pilon and Java can be found)
# -------------------------
export PATH=/scratch/grp/msc_appbio/Group2_ABCC/conda_envs/pilon_env/bin:$PATH

# -------------------------
# 4. Optional: remove old Pilon logs to avoid clutter
# -------------------------
rm -f SY14_pilon*  # remove old outputs if any

# -------------------------
# 5. Run Pilon
# -------------------------
pilon \
  --genome SY14.contigs.fasta \
  --frags SY14.contigs.bam \
  --output SY14_pilon \
  --threads 4
 --Xmx55G
# -------------------------
# Done!
# -------------------------
echo "Pilon polishing completed at $(date)"

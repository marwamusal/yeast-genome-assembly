# Long-read genome assembly of *Saccharomyces cerevisiae* BY4742 and SY14

A SLURM pipeline for *de novo* long-read assembly and short-read polishing of two
*S. cerevisiae* strains: the sixteen-chromosome wild type BY4742, and SY14, in which
all sixteen chromosomes have been fused into one.

Built on King's College London's CREATE HPC as part of an MSc Applied Bioinformatics
group project (see [Provenance](#provenance)).

---

## Background

Shao et al. (2018) engineered a *S. cerevisiae* strain, SY14, carrying its entire
genome on a single chromosome. Assembling both SY14 and its sixteen-chromosome parent
BY4742 from PacBio long reads gives a direct view of that difference in contig
structure — the assembly itself is the result.

## Results

| Strain | Contigs | Assembly size | N50 |
|---|---|---|---|
| BY4742 (16 chromosomes) | 16 | 12.04 Mb | 924 kb |
| SY14 (single chromosome) | 7 | 11.78 Mb | 11.8 Mb |

The N50 is the point. BY4742 assembles into sixteen contigs with an N50 under a
megabase, matching its sixteen chromosomes. SY14 collapses to seven contigs with an
N50 of 11.8 Mb — a single contig spanning almost the whole genome, which is what
chromosome fusion should produce.

## Pipeline

| # | Script | Step |
|---|---|---|
| 01 | `01_yeast_download.sh` | Retrieve PacBio and Illumina reads from ENA |
| 02 | `02_fastqc_all.sbatch` | Read quality control (FastQC) |
| 03 | `03_BY4742_SRR6823436_assembly.sh` | Canu assembly, BY4742 dataset 1 |
| 04 | `04_BY4742_SRR6823437_assembly.sh` | Canu assembly, BY4742 dataset 2 |
| 05 | `05_sy14_canu.sh` | Canu assembly, SY14 — initial run |
| 06 | `06_sy14_assemblyrun2_recovered.sh` | Canu assembly, SY14 — recovered run |
| 07 | `07_sy14_bwa_index.sh` | Index the SY14 assembly (BWA) |
| 08 | `08_sy14_bwa_mem.sh` | Align Illumina reads to the assembly (BWA-MEM) |
| 09 | `09_sy14_pilon1.sh` | Polishing, round 1 (Pilon) |
| 10 | `10_sy14_pilon2.sh` | Polishing, round 2 (Pilon) |

Data: PacBio and Illumina reads for both strains, from the ENA accessions in
`01_yeast_download.sh`. Reads and assemblies are not committed to this repository.

## Debugging the SY14 assembly

Scripts 05 and 06 are the same assembly, before and after diagnosis. The diff between
them is the useful part of this repository:

| | 05 (failed) | 06 (recovered) |
|---|---|---|
| Memory | 8 GB | 120 GB |
| Walltime | 1 hour | 8 hours |
| Canu input flag | `-pacbio` | `-pacbio-raw` |

The initial run was requesting resources appropriate for a much smaller job and
passing the wrong input flag for raw, uncorrected PacBio reads. Canu writes
checkpoints as it progresses, so the corrected run resumed from the existing
assembly directory rather than restarting from scratch.

## Running it

The scripts target a SLURM cluster with Conda-managed environments. Set the project
root and submit in order:

```bash
export BASE_DIR=/path/to/project
mkdir -p "$BASE_DIR"/{data,assembly,logs,qc_reports}

sbatch 01_yeast_download.sh
sbatch 02_fastqc_all.sbatch
# ... and so on through 10
```

Each script defaults `BASE_DIR` to the current directory if it isn't set. The
`--partition=msc_appbio` directive is specific to KCL CREATE and will need changing
for any other cluster.

**Tools:** Canu, BWA, Pilon, FastQC, SRA Toolkit, managed with Conda.

## Repository structure

```
.
├── README.md
├── .gitignore
└── scripts/
    ├── 01_yeast_download.sh
    ├── 02_fastqc_all.sbatch
    ├── 03_BY4742_SRR6823436_assembly.sh
    ├── 04_BY4742_SRR6823437_assembly.sh
    ├── 05_sy14_canu.sh
    ├── 06_sy14_assemblyrun2_recovered.sh
    ├── 07_sy14_bwa_index.sh
    ├── 08_sy14_bwa_mem.sh
    ├── 09_sy14_pilon1.sh
    └── 10_sy14_pilon2.sh
```

## Provenance

These scripts are the genome assembly workstream of a three-person MSc group project
at King's College London (Oct–Dec 2025). The original repository, which also contains
the RNA-seq and Hi-C workstreams contributed by the other team members, is at
[valfragalauk/ABCloudComputingYeast](https://github.com/valfragalauk/ABCloudComputingYeast).

This repository was extracted from it with `git filter-repo`, so the commit history is
the original one. Absolute HPC paths have since been replaced with a configurable
`BASE_DIR`.

## Future work

The pipeline is a set of ordered SLURM submissions with manual dependencies between
steps. Reimplementing it as a Nextflow workflow with a container definition would make
it portable off CREATE and reproducible without hand-editing paths.

## Reference

Shao Y, Lu N, Wu Z, et al. Creating a functional single-chromosome yeast.
*Nature* 560, 331–335 (2018).


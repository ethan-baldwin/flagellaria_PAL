#!/bin/bash
#SBATCH --job-name=bz2gz
#SBATCH --partition=batch
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=24gb
#SBATCH --time=24:00:00 
#SBATCH --output=/scratch/eab77806/logs/%x_%j.out
#SBATCH --error=/scratch/eab77806/logs/%x_%j.err

#create output directory
OUTDIR="/scratch/eab77806/jim_projects/flagellaria/blast"
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
cd $OUTDIR

ml BLAST+/2.16.0-gompi-2023b

makeblastdb -in LBUP.hipmer.final_assembly.fasta -dbtype nucl

tblastn -db LBUP.hipmer.final_assembly.fasta -query Flagellaria_indica_PALs.faa -num_threads $SLURM_CPUS_PER_TASK -outfmt 6 > blast_out.txt
#!/bin/bash
#SBATCH --job-name=hybpiper
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=60gb
#SBATCH --time=48:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --output=/scratch/eab77806/logs/%x_%j.out
#SBATCH --error=/scratch/eab77806/logs/%x_%j.err

OUTDIR="/scratch/eab77806/jim_projects/flagellaria/hybpiper"
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
cd $OUTDIR

ml Hybpiper/2.1.6-foss-2022b

hybpiper assemble -t_aa ../target/Flagellaria_indica_PALs.faa -r ../reads/LBUP.cleaned.fastq.gz
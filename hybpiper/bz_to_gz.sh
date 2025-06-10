#!/bin/bash
#SBATCH --job-name=bz2gz
#SBATCH --partition=batch
#SBATCH --mail-type=END,FAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=24gb
#SBATCH --time=100:00:00 
#SBATCH --output=/scratch/eab77806/logs/%x_%j.out
#SBATCH --error=/scratch/eab77806/logs/%x_%j.err

#create output directory
OUTDIR="/scratch/eab77806/jim_projects/flagellaria/"
if [ ! -d $OUTDIR ]
then
    mkdir -p $OUTDIR
fi
cd $OUTDIR

ml pigz

bzcat LBUP.cleaned.fastq.bz2 | pigz -c > LBUP.cleaned.fastq.gz
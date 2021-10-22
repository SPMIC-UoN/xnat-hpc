#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH -e error_%A_%a.log
#SBATCH -o output_%A_%a.log
#SBATCH --job-name=mriqc
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

SIMG=/software/imaging/singularity_images/poldracklab_mriqc-2021-01-30-767af1135fae.simg
WORKDIR=$1
PROJ=$2
INDIR=$WORKDIR/$PROJ
OUTDIR=$WORKDIR/mriqc_out

module load singularity
singularity run --cleanenv $SIMG $INDIR $OUTDIR participant


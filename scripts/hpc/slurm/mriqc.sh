#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH --job-name=mriqc
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

SIMG=/software/imaging/singularity_images/poldracklab_mriqc-2021-01-30-767af1135fae.simg
INDIR=$1
WORKDIR=$2
OUT_SUBDIR=$3

module load singularity
singularity run --cleanenv $SIMG $INDIR $WORKDIR/$OUT_SUBDIR participant --no-sub >>$WORKDIR/out.log 2>>$WORKDIR/err.log


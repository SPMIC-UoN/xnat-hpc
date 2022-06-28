#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH --job-name=mriqc
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

WORKDIR=$1
CODEDIR=$2

INDIR=$WORKDIR/bids
OUTDIR=$WORKDIR/mriqc_out
SINGULARITY_IMAGE=/software/imaging/singularity_images/poldracklab_mriqc-2021-01-30-767af1135fae.simg

module load singularity
singularity run --cleanenv $SINGULARITY_IMAGE $INDIR $OUTDIR participant --no-sub >>$WORKDIR/out.log 2>>$WORKDIR/err.log
$CODEDIR/mriqc/create_assessor $WORKDIR

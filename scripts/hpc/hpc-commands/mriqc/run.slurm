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
SCRIPTDIR=`dirname "$0"`
WORKDIR=$1
INDIR=$WORKDIR/bids
OUTDIR=$WORKDIR/mriqc_out

module load singularity
singularity run --cleanenv $SIMG $INDIR $OUTDIR participant --no-sub >>$WORKDIR/out.log 2>>$WORKDIR/err.log
$SCRIPTDIR/create_assessor $WORKDIR

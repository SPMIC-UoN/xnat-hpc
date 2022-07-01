#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH --job-name=brc
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

WORKDIR=$1
CODEDIR=$2

module load brc-pipelines-img

CLUSTER_MODE=NO $CODEDIR/brc-pipeline/run_pipeline $WORKDIR/bids/* $WORKDIR/brc_out >>$WORKDIR/out.log 2>>$WORKDIR/err.log
#$CODEDIR/brc-pipeline/create_assessor $WORKDIR  >>$WORKDIR/out.log 2>>$WORKDIR/err.log


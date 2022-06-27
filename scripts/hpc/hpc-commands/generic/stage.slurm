#!/bin/sh
# Get session scans into a temp dir in BIDS format

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --memory=2gb
#SBATCH --time=01:00:00
#SBATCH --job-name=stage_bids
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

HOST=$1
PROJ=$2
SUB=$3
EXP=$4
USER=$5
PASSWORD=$6
WORKDIR=$7

module load conda-img
source activate xnat

BIDSDIR=$WORKDIR/bids
xnatc --xnat=$HOST --project=$PROJ --subject=$SUB --experiment=$EXP --user=$USER --password=$PASSWORD --download=$BIDSDIR --download-format=bids >>$WORKDIR/out.log 2>>$WORKDIR/err.log
BIDS_DATASETDIR=$BIDSDIR/*
echo $BIDS_DATASETDIR

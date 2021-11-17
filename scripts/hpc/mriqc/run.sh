#!/bin/bash -x
#
# XNAT remote command to run MRIQC

# Arguments passed by XNAT pipeline script
HOST=$1
JSESSION=$2
PROJ=$3
SUB=$4
EXP=$5
ARGS=$6

# Basic info FIXME tempdir is not ideal
SCRIPTNAME=`basename "$0"`
CODEDIR=`dirname "$0"`/..
TEMPDIR=$HOME/tmp

# Create working directory
WORKDIR=`mktemp -d -p $TEMPDIR $SCRIPTNAME_XXXXXX`

# Braces to send stdout/stderr to logfiles in working dir
{
echo $@
echo "Working directory: $WORKDIR"

module load conda-img
source activate xnat

# Convert session ID into a user alias token for subsequent upload authentication
CREDENTIALS=`$CODEDIR/generic/get_user_alias $HOST $JSESSION`
CREDENTIALS=($CREDENTIALS)
echo "Obtained user alias token - alias: ${CREDENTIALS[0]}"

# Get session scans into a temp dir in BIDS format as required for mriqc
BIDSDIR=$WORKDIR/bids
xnatc --xnat=$HOST --project=$PROJ --subject=$SUB --experiment=$EXP --user=${CREDENTIALS[0]} --password=${CREDENTIALS[1]} --download=$BIDSDIR --download-format=bids
BIDS_DATASETDIR=$BIDSDIR/*
echo "Downloaded BIDS data to: $BIDS_DATASETDIR"

# Run MRIQC as a batch job
MRIQC_OUTDIR=$WORKDIR/mriqc_out
JOB_ID=`sbatch --parsable $CODEDIR/mriqc/mriqc.slurm $BIDS_DATASETDIR $MRIQC_OUTDIR`
echo "MRIQC job ID: $JOB_ID"

# Run dependent job to do upload
UPLOAD_JOB_ID=`sbatch --parsable --dependency=afterok:$JOB_ID $CODEDIR/mriqc/upload.slurm $HOST $PROJ $SUB $EXP MRIQC $MRIQC_OUTDIR ${CREDENTIALS[0]} ${CREDENTIALS[1]}`
echo "MRIQC upload job ID: $UPLOAD_JOB_ID"

} >$WORKDIR/out.log 2>$WORKDIR/err.log

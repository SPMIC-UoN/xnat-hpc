#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:10:00
#SBATCH --job-name=ukb_upload
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

module load conda-img
source activate xnat

HOST=$1
PROJ=$2
SUB=$3
EXP=$4
NAME=$5
WORKDIR=$6
UKBOUT=$7
USER=$8
PASSWORD=$9

$HOME/code/ukb/upload $HOST $PROJ $SUB $EXP $WORKDIR/$MRIQC_OUT $NAME $USER $PASSWORD >>$WORKDIR/out.log 2>>$WORKDIR/err.log

#rm -rf $WORKDIR


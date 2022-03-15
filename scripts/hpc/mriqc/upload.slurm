#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=01:00:00
#SBATCH --job-name=mriqc_upload
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
MRIQC_OUT=$7
USER=$8
PASSWORD=$9

$HOME/code/mriqc/upload.sh $HOST $PROJ $SUB $EXP $WORKDIR/$MRIQC_OUT $NAME $USER $PASSWORD >>$WORKDIR/out.log 2>>$WORKDIR/err.log

#rm -rf $WORKDIR


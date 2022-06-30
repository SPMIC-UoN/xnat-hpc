#!/bin/sh
# Upload data/assessors/logs

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=00:20:00
#SBATCH --job-name=upload
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

HOST=$1
PROJ=$2
SUB=$3
EXP=$4
USER=$5
PASSWORD=$6
WORKDIR=$7
CODEDIR=$8
CMD=$9

module load xnatc-img

$CODEDIR/generic/upload $HOST $PROJ $SUB $EXP $USER $PASSWORD $WORKDIR $CMD >>$WORKDIR/out.log 2>>$WORKDIR/err.log


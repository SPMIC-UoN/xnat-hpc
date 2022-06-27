#!/bin/sh
# Perform processing

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10
#SBATCH --time=00:05:00
#SBATCH --job-name=test
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

WORKDIR=$1

echo "TEST PROCESSING" >>$WORKDIR/out.log 2>>$WORKDIR/err.log

#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=00:10:00
#SBATCH --job-name=create_assessor
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

WORKDIR=$1

$CODEDIR/brc-pipelin/create_assessor $WORKDIR


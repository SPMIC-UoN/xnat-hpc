#!/bin/sh
# Clean up working directory

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --job-name=cleanup
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

WORKDIR=$1

rm -rf $WORKDIR


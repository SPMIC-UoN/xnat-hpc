#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=04:00:00
#SBATCH --job-name=mriqc
#SBATCH --partition=imgcomputeq
#SBATCH --qos=img

INDIR=$1
OUTDIR=$2

module load ukbiobank-img/2.0

ukb_pipeline --dicom-indir=$INDIR --subjdir=$OUTDIR --acquired-sbref

#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32gb
#SBATCH --time=01:00:00
#SBATCH -e error_%A_%a.log
#SBATCH -o output_%A_%a.log
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
USER=$7
PASSWORD=$8

$HOME/code/mriqc/upload_mriqc $HOST $PROJ $SUB $EXP $WORKDIR TestPipelineData $NAME $USER $PASSWORD


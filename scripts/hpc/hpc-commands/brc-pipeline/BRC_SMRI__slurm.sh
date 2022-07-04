#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --job-name=BRC_SMRI_
#SBATCH --partition=imgcomputeq,imghmemq
#SBATCH --ntasks=1
#SBATCH --mem=100g
#SBATCH --qos=img

cd $SLURM_SUBMIT_DIR
export OMP_NUM_THREADS=1

CMD="/gpfs01/software/imaging/BRC_Pipeline/BRC_structural_pipeline/scripts/struc_preproc_part_1.sh --tempt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/temp --rawt1folder=work//brc_out/CMO999009_CMO999009/raw/anatMRI/T1 --dosubseg=no --dotissueseg=yes --docrop=yes --dodefacing=yes --fastt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/temp/FAST --firstt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/processed/seg/sub/shape --sienaxt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/preproc/SIENAX --biancatempfolder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/temp/lesions --biancat2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/preproc/lesions --regtempt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/temp/reg --t2=yes --tempt2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/temp --rawt2folder=work//brc_out/CMO999009_CMO999009/raw/anatMRI/T2 --regtempt2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/temp/reg --t1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1 --t2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2 --biast1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/preproc/bias --sienaxtempfolder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/temp/SIENAX --datat1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/processed/data --data2stdt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/processed/data2std --segt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/processed/seg --regt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/preproc/reg --datat2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/processed/data --data2stdt2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/processed/data2std --regt2folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T2/preproc/reg --dofreesurfer=no --processedt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/processed --fsfoldername=FS --starttime=1656673610 --subid=CMO999009_CMO999009 --regtype=2 --t2lesionpath= --fbet=0.5 --logt1folder=work//brc_out/CMO999009_CMO999009/analysis/anatMRI/T1/log/log.txt"
$CMD


#!/bin/bash
#PBS -A RRFS-DEV
#PBS -q dev_transfer
#PBS -l select=1:ncpus=1:mem=8G
#PBS -l walltime=00:30:00
#PBS -N RAVE_raw
#PBS -oe -o out.t06z
#PBS -V

module purge
module load prod_envir/2.0.6
module load prod_util/2.0.13

set -ax

WORKDIR=/lfs/h2/emc/lam/noscrub/emc.lam/RAVE_rawdata/RAVE_NA
cd $WORKDIR

std=`date +%Y%m%d%H`


for i in 3 4 5 6 7 8 9 10 11 12 13 14
do
download_time=`$NDATE -${i} ${std}`

wget ftp://ftp.star.nesdis.noaa.gov/pub/smcd/spb/shobha/xu/RAVE3kmFireEmissions_NA/Hourly_Emissions_3km_${download_time}00_${download_time}00.nc
done

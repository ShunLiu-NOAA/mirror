#!/bin/bash

module purge
module load envvar/1.0
module load prod_util/2.0.10
set -x

# mirror  RRFSUPP files from prod to dev
#PDY=20230308
#cyc=02

NDATE

exit

CURRENTDATE=$PDY

mysite=$(cat /etc/cluster_name)
primary=$(head -1 /lfs/h1/ops/prod/config/prodmachinefile | cut -d ":" -f2-)
backup=$(head -2 /lfs/h1/ops/prod/config/prodmachinefile | tail -1 | cut -d ":" -f2-)

sourcemachine=emc.lam@ddxfer.wcoss2.ncep.noaa.gov
desmachine=emc.lam@cdxfer.wcoss2.ncep.noaa.gov

for minsback  in 60 120 180 240 300 360 420
do
  YYYYMMDDHH=`date +"%Y%m%d%H" -d "${CURRENTDATE} ${minsback} minute ago"`
  currentdate=`date +"%Y%m%d %H"`

  PDY=`echo ${YYYYMMDDHH} | cut -c1-8`
  cyc=`echo ${YYYYMMDDHH} | cut -c9-10`

  proddir=/lfs/h2/emc/ptmp/emc.lam/rrfs/conus/prod/rrfs_a.${PDY}/${cyc}
  proddir1=/lfs/h2/emc/ptmp/emc.lam/rrfs/conus/prod/rrfs_a.${PDY}
  destination=/lfs/h2/emc/ptmp/emc.lam/rrfs/v0.3.8_dogwood/prod/rrfs_a.${PDY}
  destination1=/lfs/h2/emc/ptmp/emc.lam/rrfs/v0.3.8_dogwood/prod
  touch $proddir1/dummy
  rsync -aq $proddir1/dummy $desmachine:$destination/
  rsync -arv $proddir $desmachine:$destination
done

exit

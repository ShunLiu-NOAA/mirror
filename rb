#!/bin/bash
module purge
module use /apps/ops/test/nco/modulefiles
module load craype-x86-rome 
module load libfabric/1.11.0.0. 
module load craype-network-ofi 
module load envvar/1.0
module load core/rocoto/1.3.5

cyctime=202303171900
#rocotostat -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c all

test=16

case $test in
11)
taskname=mirror_spinup
;;
12)
taskname=mirror_prod
;;
13)
taskname=mirror_enfcst
;;
14)
taskname=mirror_get_rave
;;
15)
taskname=mirror_log
;;
16)
taskname=mirror_nwges
;;
esac

echo $taskname


rocotocheck -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -t $taskname
rocotorewind -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -t $taskname
rocotoboot -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -t $taskname
#rocotoboot -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -m $taskname


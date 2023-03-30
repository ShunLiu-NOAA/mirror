#!/bin/bash

#set -x
module use /apps/ops/test/nco/modulefiles
module load craype-x86-rome 
module load libfabric/1.11.0.0. 
#module load craype-network-ofi 
module load envvar/1.0
module load core/rocoto/1.3.5

#module list

rocotostat -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c all > zzz
#rocotostat -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -s > sum
#rocotocomplete -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c 202210010100


exit
#rocotostat -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c all | more

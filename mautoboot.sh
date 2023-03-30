#!/bin/bash

module purge
module use /apps/ops/test/nco/modulefiles
module load craype-x86-rome
module load libfabric/1.11.0.0.
module load craype-network-ofi
module load envvar/1.0
module load core/rocoto/1.3.5




#rocotostat -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c all > zzz

set +x

echo `pwd`
cd /lfs/h2/emc/lam/noscrub/emc.lam/rrfs/v0.3.8/mirror

thistime=`date "+%Y%m%d%H%M"`
for ((i=12;i>=1;i--));
do
  mydate=`date "+%Y%m%d%H" --date="$i hour ago"`
  echo $mydate

  nline="0"
  nline=`grep DEAD zzz | grep $mydate | wc -l`
  echo "nline:" $nline
  
  if [ "$nline" -ge "1" ]; then
    for ((j=1;j<=$nline;j++))
    do 
    echo $mydate : $nline
    echo "inloop:", $j
    topline=`grep DEAD zzz | grep $mydate | head -n${j} | tail -n1`
#   topline=`grep DEAD zzz | grep $mydate | head -n2 | tail -n2`
    echo $topline

    if [[ ${topline} =~ "DEAD" ]]; then
      echo ${thistime} ":" $topline >> deadjob.log
      cyctime=`echo $topline | awk '{print $1}'`
      taskname=`echo $topline | awk '{print $2}'`
      echo $cyctime,$taskname
      #rocotocheck -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -t $taskname
      rocotorewind -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -t $taskname
      rocotoboot -w FV3LAM_wflow.xml -d FV3LAM_wflow.db -c $cyctime -t $taskname
    fi

  done
  fi
done

#touch /lfs/h2/emc/ptmp/emc.lam/rrfs/na
#touch /lfs/h2/emc/ptmp/emc.lam/rrfs/conus


#if [ $taskname == 

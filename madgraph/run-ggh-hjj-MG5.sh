#!/bin/bash

# make a new folder for generated stuff, in case it doesnt exist
mkdir -p ggh-hjj-run

# setup path
patrentmgpath="/global/homes/f/frankfu/scratch/software/MG5_aMC_v2_6_7"

# generate a new seed.
seed=$RANDOM

# generate script and log file names
scriptname=$PWD$"/ggh-hjj-run/mg-script-ggh-hjj-"$seed$".txt"
logname=$PWD$"/ggh-hjj-run/mg-script-ggh-hjj-"$seed$".log"
mgname=$PWD$"/ggh-hjj-run/mg-"$seed

#see if the files exist, if so, generate a new set

while [ -f $scriptname ]
do
   seed=$RANDOM
   scriptname=$PWD$"/ggh-hjj-run/mg-script-ggh-hjj-"$seed$".txt"
   logname=$PWD$"/ggh-hjj-run/mg-script-ggh-hjj-"$seed$".log"
   mgname=$PWD$"/ggh-hjj-run/mg-"$seed
done

# create a script file containing unique seed
echo -e "launch ~/scratch/higgs-classifier/MG5/ggh-hjj" >> $scriptname
echo -e $"set iseed "$seed >> $scriptname

# create a new copy of madgraph executables
cp -r $patrentmgpath $mgname

# setup modules
module unload PrgEnv-intel
module load PrgEnv-gnu

# launch madgraph processes
echo -e $"Start time: "$date >> $logname

$mgname$"/bin/mg5_aMC" $scriptname >> $logname

echo -e $"End time: "$date >> $logname

rm -r $mgname
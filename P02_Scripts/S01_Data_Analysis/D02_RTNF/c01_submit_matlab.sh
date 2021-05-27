#!/bin/bash -l
#PBS -N RTNF_submit_matlab
#PBS -q default
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:40:00
#PBS -m bea


cd $PBS_O_WORKDIR

module load matlab

SUB=${1}
echo "Running ${SUB}"
cd /dartfs-hpc/rc/home/j/f0042vj/RTNF/P04_script_all_trial
matlab -nodesktop -r 'S03_distribute_imaging_file_func2('"'${SUB}'"')';exit;
echo "Running ${SUB}"

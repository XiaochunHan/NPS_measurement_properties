#!/bin/bash -l
#PBS -N RTNF_submit_glm
#PBS -q default
#PBS -l nodes=1:ppn=1
#PBS -l walltime=00:30:00
#PBS -m bea


cd $PBS_O_WORKDIR

module load matlab

#SUB="'sub-8'"
SUB=${1}
echo "Running ${SUB}"
cd /dartfs-hpc/rc/home/j/f0042vj/RTNF/P04_script_all_trial
matlab -nodesktop -r 'S05_run_subject_level_glm('"'${SUB}'"')';exit;

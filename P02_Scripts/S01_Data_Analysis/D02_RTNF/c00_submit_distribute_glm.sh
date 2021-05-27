
subject=("sub-16" "sub-17" "sub-18" "sub-21" "sub-23" "sub-24" "sub-25" "sub-26" "sub-28" "sub-29" "sub-31" \
"sub-33" "sub-34" "sub-35" "sub-37" "sub-38" "sub-39" "sub-41" "sub-43" "sub-48" "sub-49" \
"sub-50" "sub-6" "sub-7" "sub-8")


for SUB in ${subject[*]}; do

mksub -F "${SUB}" /dartfs-hpc/rc/home/j/f0042vj/RTNF/P04_script_all_trial/c02_submit_glm.sh
echo "Running ${SUB}"
done

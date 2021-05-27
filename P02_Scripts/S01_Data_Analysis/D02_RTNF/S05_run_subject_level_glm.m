function S05_run_subject_level_glm(subID)
addpath(genpath('/dartfs-hpc/rc/home/j/f0042vj/matlab'));
addpath(genpath('/dartfs-hpc/rc/home/j/f0042vj/RTNF/P04_script_all_trial'));
glmdir = '/dartfs-hpc/scratch/f0042vj/RTNF/';
%cd(glmdir);
%sublst = dir('sub-*')
%for s = 2:length(sublst)
 %   subID = sublst(s).name;
    cd(fullfile(glmdir,subID));
    seslst = dir('ses-*');
    for k = 1:length(seslst)
        sesID = seslst(k).name;
        DSGN = S04_get_single_trial_dsgn_obj(subID,sesID);
        fprintf('Running on %s-%s\n',subID,sesID);
        canlab_glm_subject_levels(DSGN,'subjects',DSGN.subjects);
    end
%end
end


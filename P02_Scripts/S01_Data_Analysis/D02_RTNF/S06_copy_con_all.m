clear;clc;
SrcPath = '/dartfs-hpc/scratch/f0042vj/RTNF';
DesPath = '/dartfs-hpc/rc/lab/C/CANlab/labdata/data/RTNF/Imaging/preprocessed/P06_con_all_all_trials';
%%
cd(SrcPath);
Subject = dir('sub-*');
Session = {'ses-1','ses-2','ses-3'};
for sub = 1:length(Subject)
    for ses = 1:length(Session)
        copyfile(fullfile(SrcPath,Subject(sub).name,Session{ses},'con_0001.nii'), fullfile(DesPath,[Subject(sub).name,'-',Session{ses},'-con_0001.nii']));;
    end
end

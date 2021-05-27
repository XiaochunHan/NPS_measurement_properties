function S03_distribute_imaging_file(subID)
addpath(genpath('/dartfs-hpc/rc/home/j/f0042vj/matlab/CanlabCore'));
addpath(genpath('/dartfs-hpc/rc/home/j/f0042vj/matlab/spm12'));   
datadir = '/dartfs-hpc/rc/lab/C/CANlab/labdata/data/RTNF/Imaging/preprocessed/fmriprep';
savedir = '/dartfs-hpc/scratch/f0042vj/RTNF';
cd(fullfile(savedir,subID));
seslst = dir('ses-*');
for k = 1:length(seslst)
   sesID = seslst(k).name;
   cd(fullfile(datadir,subID,sesID,'func'));
   runlst = dir('*_desc-preproc_bold.nii.gz');
   for r = 1:length(runlst)
       runID = ['run-',num2str(r)];
       fprintf('%s-%s-%s\n',subID,sesID,runID);
       source = runlst(r).name;
       aim = [subID,'_',sesID,'_',runID,'_desc-preproc_bold.nii.gz'];
       nii = [subID,'_',sesID,'_',runID,'_desc-preproc_bold.nii'];
       fname = ['smooth_',nii];
       if exist(fullfile(savedir,subID,sesID,runID,fname),'file')
	  continue;
       else
	  copyfile(source,fullfile(savedir,subID,sesID,runID,aim));
	  gunzip(fullfile(savedir,subID,sesID,runID,aim));
	  delete(fullfile(savedir,subID,sesID,runID,aim));
	  dat = fmri_data(fullfile(savedir,subID,sesID,runID,nii));
	  dat = preprocess(dat, 'smooth', 6);
	  dat.fullpath = fullfile(savedir,subID,sesID,runID,fname);
	  write(dat)
	  delete(fullfile(savedir,subID,sesID,runID,nii));
       end
    end
end
fprintf('Done!');
end

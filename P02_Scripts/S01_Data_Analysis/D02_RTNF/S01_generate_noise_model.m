clear;clc;
addpath(genpath('/dartfs-hpc/rc/home/j/f0042vj/matlab/CanlabScripts'));
datadir = '/dartfs-hpc/rc/lab/C/CANlab/labdata/data/RTNF/Imaging/preprocessed/fmriprep';
savedir = '/dartfs-hpc/scratch/f0042vj/RTNF';
sublst = {'sub-6','sub-7','sub-8','sub-10','sub-11',...
         'sub-12','sub-14','sub-15','sub-16','sub-17',...
         'sub-18','sub-21','sub-23','sub-24', 'sub-25','sub-26',...
         'sub-28','sub-29','sub-31','sub-33','sub-34',...
         'sub-35','sub-37','sub-38','sub-39','sub-41',...
         'sub-43','sub-48','sub-49','sub-50'};
%%
for s = 1:length(sublst)
    fprintf('%s\n',sublst{s});
    cd(fullfile(datadir,sublst{s}));
    seslst = {};
    seslst = dir('ses-*');
    if length(seslst) > 3
       error(['please check:',sublst{s}]);
    end
    for k = 1:length(seslst)
        fprintf('%s\n',seslst(k).name);
        cd(fullfile(datadir,sublst{s},seslst(k).name,'func'));
        runlst = {};
        runlst = dir('*_desc-confounds_regressors.tsv');
        if length(runlst) > 5
           error(['please check:',sublst{s},seslst(k).name]);
        end
        for r = 1:length(runlst)
            cd(fullfile(datadir,sublst{s},seslst(k).name,'func'));
            fprintf('%s\n',runlst(r).name);
            ftemp = runlst(r).name;
            R = make_nuisance_covs_from_fmriprep_output3(ftemp,0.46,2,0);
            cd(savedir);
            if ~exist(fullfile(sublst{s}, seslst(k).name,['run-',num2str(r)],'modeling_files'),'dir')
               mkdir(fullfile(sublst{s}, seslst(k).name,['run-',num2str(r)],'modeling_files'));
            end
            cd(fullfile(sublst{s}, seslst(k).name,['run-',num2str(r)],'modeling_files'));
            savefile = 'noise_model.mat';
            save(savefile,'R');
            clear ftemp, R;
        end
    end
end

clear;clc;
datadir = '/dartfs-hpc/rc/home/j/f0042vj/RTNF/P01_Behavior_Raw/fMRI_behavioral';
savedir = '/dartfs-hpc/scratch/f0042vj/RTNF';
cd(savedir);
sublst = dir('sub-*');
event = {'heat','rating','buttonPress'};
%%
for s = 1:length(sublst)
    subID = sublst(s).name;
    cd(fullfile(savedir,subID));
    seslst = dir('ses-*');
    for k = 1:length(seslst)
        sesID = seslst(k).name;
        cd(fullfile(savedir,subID,sesID));
        runlst = dir('run-*');
        for r = 1:length(runlst)
            runID = runlst(r).name;
            fprintf('%s-%s-%s\n',subID,sesID,runID);
            cd(datadir);
            behFile = ['behav_sub',extractAfter(subID,"sub-"),num2str((str2num(extractAfter(sesID,"ses-"))+1),'%.2d'),'_run',extractAfter(runID,"run-"),'.mat'];
            if exist(behFile,'file')
               load(behFile,'timing');
               for e = 1:length(event)
                   if e == 1
                      name{1} = event{e};
                      duration{1} = 12;
                      onset{1} = timing.onsets(1,1:6) - timing.ttl;
                      cd(savedir);
                      if ~exist(fullfile(subID,sesID,runID,'modeling_files'),'dir')
                         mkdir(fullfile(subID,sesID,runID),'modeling_files');
                      end
                      cd(fullfile(subID,sesID,runID,'modeling_files'));
                      savefile = [name{1},'.mat'];
                      save(savefile,'name','onset','duration');
                   elseif e == 2
                      name{1} = event{e};
                      duration{1} = 8;
                      onset{1} = timing.rating_start - timing.ttl;
                      cd(savedir);
                      cd(fullfile(subID,sesID,runID,'modeling_files'));
                      savefile = [name{1},'.mat'];
                      save(savefile,'name','onset','duration'); 
                   elseif e == 3
                      name{1} = event{e};
                      duration{1} = 0;
                      if isfield(timing,'response')
                         onset{1} = timing.response(timing.response ~=0) - timing.ttl;
                         cd(savedir);
                         cd(fullfile(subID,sesID,runID,'modeling_files'));
                         savefile = [name{1},'.mat'];
                         save(savefile,'name','onset','duration');  
                      end
                   end
               end
           else
               continue;
           end
       end
    end
end

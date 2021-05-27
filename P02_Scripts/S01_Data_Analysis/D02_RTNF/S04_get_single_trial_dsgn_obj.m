function DSGN = get_single_trial_dsgn_obj(subID,sesID)
%% INPUT
DSGN.modeldir = ['/dartfs-hpc/scratch/f0042vj/RTNF/',subID];
DSGN.subjects = {sesID};
runlst = dir([DSGN.modeldir,'/',DSGN.subjects{1},'/run-*']);
runNum = length(runlst);
e = 0;
for r = 1:runNum
    runID = runlst(r).name;
    rundir = fullfile(DSGN.modeldir,DSGN.subjects{1},runID,'modeling_files');
    if exist(fullfile(rundir,'heat.mat'),'file') && exist(fullfile(rundir,'rating.mat'),'file') && exist(fullfile(rundir,'buttonPress.mat'),'file')
       e = e + 1;
       DSGN.funcnames{e} = [runID,'/*preproc_bold.nii'];
    end
end
DSGN.allowmissingfunc = false;
DSGN.concatenation = {[1:e]};


%% PARAMETERS
DSGN.tr = 0.46;
DSGN.hpf = 180;
DSGN.fmri_t0 = 8;


%% MODELING (task conditions, noise regressors, etc)
DSGN.modelingfilesdir = 'modeling_files';

% (the use of c is merely to facilitate editing: allows easy deletion/addition, 
% creation of accompanying sparse arrays, etc)
c=0;
c=c+1; DSGN.conditions{1}{c} = 'heat';
c=c+1; DSGN.conditions{1}{c} = 'rating';
c=c+1; DSGN.conditions{1}{c} = 'buttonPress';

DSGN.allowemptycond = true;
DSGN.notimemod = true;

DSGN.multireg = 'noise_model';

%% SINGLE TRIAL
%DSGN.singletrials{1}={1 0 0};
%% this specifies which conditions will be modeled as single trials, in the order that you listed your conditions

%% CONTRASTS
DSGN.noscale = false;
DSGN.regmatching = 'regexp';
DSGN.defaultsuffix = ' \*bf\(1\)$';

c=0;
c=c+1; DSGN.contrasts{c} = {{'heat'}};

%% SAVE
%save model1 DSGN
end

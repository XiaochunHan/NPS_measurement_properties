clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS1D_NPS_between_r_pain_rating';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');

nps_mean = cat(1,NPS.subject_means_by_study_rescale{:});
pain_mean = cat(1,PAIN.subject_means_by_study_rescale{:});

for s = 1:length(NPS.studynames)
    names{s}((1:length(NPS.subject_means_by_study_rescale{s})),1) = deal(NPS.studynames(s,1));
end
names = cat(1,names{:});

mean_data = table(names,nps_mean,pain_mean, 'VariableNames',{'study','nps','pain'}); 

cd(savedir);
writetable(mean_data, 'NPS_between_r_pain.csv');

fprintf('Done!\n');
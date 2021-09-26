clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS1A_NPS_mean_response';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
for s = 1:length(NPS.studynames)
    names{s}((1:length(NPS.subject_means_by_study_rescale{s})),1) = deal(NPS.studynames(s,1));
end
names = cat(1,names{:});
rescale = cat(1,NPS.subject_means_by_study_rescale{:});
mean_data = table(names,rescale, 'VariableNames',{'study','rescale_mean'}); 
cd(savedir)
writetable(mean_data, 'NPS_mean_response.csv');

fprintf('Done!\n');
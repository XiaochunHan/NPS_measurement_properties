clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS1C_NPS_within_r_pain_rating';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');

X = PAIN;
Y = NPS;
xname = 'Pain';
yname = 'NPS';
figname = 'Pain by NPS by study within subject';

[~, ~, within_r] = plugin_regress_within_subject(X, Y, figname);
within_r_pain = cat(1,within_r{:});

for s = 1:length(NPS.studynames)
    names{s}((1:length(NPS.subject_means_by_study_rescale{s})),1) = deal(NPS.studynames(s,1));
end
names = cat(1,names{:});
mean_data = table(names,within_r_pain, 'VariableNames',{'study','within_r_pain'}); 

cd(savedir)
writetable(mean_data, 'NPS_within_r_pain.csv');

fprintf('Done!\n');

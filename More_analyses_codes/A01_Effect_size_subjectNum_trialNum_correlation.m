clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
esFile = './Figure1B_NPS_four_effect_size/Four_effect_size.csv';
raw_data = readtable(dataFile);
es_data = readtable(esFile);
%% Extract subjectNum and trialNum per study
[uniq_study_id, ~, study_id] = unique(raw_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
subjNum = [];
trialNum_mean = [];
for i = 1:nstudies
    this_dat = raw_data(i == study_id,:);
    [uniq_subj_id, ~, subj_id] = unique(this_dat.subject_id,'rows','stable');
    subjNum = [subjNum;size(uniq_subj_id,1)];
    nsubj = length(uniq_subj_id);
    trialNum = [];
    for s = 1:nsubj
        this_subj = this_dat(s == subj_id,:);
        trialNum = [trialNum;size(this_subj,1)];
    end
    trialNum_mean = [trialNum_mean; mean(trialNum)];
end

%% Correlation between effect size and subjNum, and trialNum
all_data = [es_data.betweenSub_corr_pain,subjNum,trialNum_mean];
[r,p] = corr(all_data);
fprintf('Correlation with subjNum\n r = %.2f; p = %.2f\n', r(1,2), p(1,2));
fprintf('Correlation with trialNum\n r = %.2f; p = %.2f\n', r(1,3), p(1,3));

%% Correlation between positive effect size and subjNum, and trialNum
all_data = [es_data.betweenSub_corr_pain,subjNum,trialNum_mean];
[r,p] = corr(all_data(2:8,:));
fprintf('Correlation with subjNum\n r = %.2f; p = %.2f\n', r(1,2), p(1,2));
fprintf('Correlation with trialNum\n r = %.2f; p = %.2f\n', r(1,3), p(1,3));

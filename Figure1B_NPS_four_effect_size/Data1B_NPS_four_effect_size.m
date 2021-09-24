clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './Figure1B_NPS_four_effect_size';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
TEMP = single_trial_retrieve_data_all_studies(all_data, 'T');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
%% Mean response
dfun = @(x) mean(x) ./ std(x);
d_mean = cellfun(dfun, NPS.subject_means_by_study, 'UniformOutput', false);
d_mean = cat(1, d_mean{:});
%% Within correlation with temperature
X = TEMP; 
Y = NPS;
figname = 'Temperature by NPS by study within subject';
[~, ~, within_r_nps_temp] = plugin_regress_within_subject(X, Y, figname);
d_temp_within = cellfun(dfun, within_r_nps_temp, 'UniformOutput', false);
d_temp_within = cat(1, d_temp_within{:});
%% Within correlation with pain
X = PAIN;
Y = NPS;
figname = 'Pain by NPS by study within subject';
[~, ~, within_r_nps_pain] = plugin_regress_within_subject(X, Y, figname);
d_pain_within = cellfun(dfun, within_r_nps_pain, 'UniformOutput', false);
d_pain_within = cat(1, d_pain_within{:});
%% Between correlation with pain
X = PAIN;
Y = NPS;
figname = 'Pain by NPS by study between subject';
[stats_table_nps, ~, ~] = plugin_regress_within_subject(X, Y, figname);

r2d = @(r) 2*r ./ (1 - r.^2).^.5;
d_pain_between = arrayfun(r2d, stats_table_nps.between_person_r(1:8,1));
%% Save Extracted effect sizes
d_all = [d_mean,d_temp_within,d_pain_within,d_pain_between];
d = array2table(d_all,'VariableNames',{'mean_response','withinSub_corr_temp','withinSub_corr_pain','betweenSub_corr_pain'});
cd(savedir)
writetable(d, 'Four_effect_size.csv');
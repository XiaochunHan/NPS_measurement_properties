clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS2A_Effect_size_NPS_local_mean_response';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
single_trial_get_d_all_local_NPS_regions;
variableNames = {'nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                      'neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_all = [cat(1,NPS_d_by_study{:}),cat(2,nps_d_by_study_region_pos{:}),cat(2,nps_d_by_study_region_neg{:})];
table_all = array2table(d_all, 'VariableNames', variableNames);

cd(savedir)
writetable(table_all, 'NPS_local_mean_response_effect_size.csv');

fprintf('Done!\n');
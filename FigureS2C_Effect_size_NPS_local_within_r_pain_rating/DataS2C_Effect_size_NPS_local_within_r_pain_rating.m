clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS2C_Effect_size_NPS_local_within_r_pain_rating';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
single_trial_get_d_all_local_NPS_regions;

figname = 'NPS local regions correlation with Pain';
X = PAIN;
d_pos_all = [];
d_neg_all = [];
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    [~,~,within_r_pos] = plugin_regress_within_subject(X, Y, figname);
    d_pos = cellfun(dfun, within_r_pos, 'UniformOutput', false);
    d_pos = cat(1, d_pos{:});
    d_pos_all = [d_pos_all,d_pos];
end
for n = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{n};
    [~,~,within_r_neg] = plugin_regress_within_subject(X, Y, figname);
    d_neg = cellfun(dfun, within_r_neg, 'UniformOutput', false);
    d_neg = cat(1, d_neg{:});
    d_neg_all = [d_neg_all,d_neg];
end

Y = NPS;
[~,~,within_r] = plugin_regress_within_subject(X, Y, figname);
d_nps = cellfun(dfun, within_r, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});

variableNames = {'nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                       'neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_pain_all = [d_nps, d_pos_all, d_neg_all];
table_all = array2table(d_pain_all, 'VariableNames', variableNames);
cd(savedir);
writetable(table_all, 'NPS_local_within_pain_effect_size.csv');

fprintf('Done!\n');
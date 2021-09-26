clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS2D_Effect_size_NPS_local_between_r_pain_rating';
all_data = readtable(dataFile);
%%
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
single_trial_get_d_all_local_NPS_regions;

figname = 'NPS local regions correlation with PAIN between subjects';
r2d = @(r) 2*r ./ (1 - r.^2).^.5;
X = PAIN;
d_pos_all = [];
d_neg_all = [];
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    stats_table_npspos = plugin_regress_within_subject(X, Y, figname);
    d_npspos = r2d(stats_table_npspos.between_person_r(1:8));
    d_pos_all = [d_pos_all,d_npspos];
end
for p = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{p};
    stats_table_npsneg = plugin_regress_within_subject(X, Y, figname);
    d_npsneg = r2d(stats_table_npsneg.between_person_r(1:8));
    d_neg_all = [d_neg_all,d_npsneg];
end

Y = NPS;
stats_table_nps = plugin_regress_within_subject(X, Y, figname);
d_nps = r2d(stats_table_nps.between_person_r(1:8));

variableNames = {'nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                       'neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_pain_all = [d_nps, d_pos_all, d_neg_all];
table_all = array2table(d_pain_all, 'VariableNames', variableNames);

cd(savedir);
writetable(table_all, 'NPS_local_between_pain_effect_size.csv');

fprintf('Done!\n');
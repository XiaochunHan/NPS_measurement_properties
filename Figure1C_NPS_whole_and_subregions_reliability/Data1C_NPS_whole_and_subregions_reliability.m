clear;clc;
addpath(genpath('./MATLAB/CanlabCore'));
addpath(genpath('./Osf_data'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './Figure1C_NPS_whole_and_subregions_reliability';
all_data = readtable(dataFile);

nps_pos_list = {'pos_nps_vermis','pos_nps_rIns','pos_nps_rV1','pos_nps_rThal','pos_nps_lIns','pos_nps_rdpIns','pos_nps_rS2_Op','pos_nps_dACC'};
nps_neg_list = {'neg_nps_rLOC','neg_nps_lLOC','neg_nps_rpLOC','neg_nps_pgACC','neg_nps_lSTS','neg_nps_rIPL','neg_nps_PCC'};

nps_pos = {'vermis','rIns','rV1','rThal','lIns','rdpIns','rS2','dACC'};
nps_neg = {'rLOC','lLOC','rpLOC','pgACC','lSTS','rIPL','PCC'};
%%
reliab_nps = icc_by_study(all_data,'nps');

reliab_pain = icc_by_study(all_data,'rating');

for p = 1:length(nps_pos_list)
    reliab_pos_region{p} = icc_by_study(all_data,nps_pos_list{p});
end
reliab_pos_region = cat(2, reliab_pos_region{:});

for n = 1:length(nps_neg_list)
    reliab_neg_region{n} = icc_by_study(all_data,nps_neg_list{n});
end
reliab_neg_region = cat(2, reliab_neg_region{:});

icc_all = [reliab_nps,reliab_pain,reliab_pos_region,reliab_neg_region];
ICC = array2table(icc_all,'VariableNames',['NPS','rating',nps_pos,nps_neg]);
cd(savedir)
writetable(ICC, 'ICC_all_and_regions.csv');
%%
function [icc,mean12,id] = icc_by_study(all_data, varname)
[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
for i = 1:nstudies
    
    this_dat = all_data(i == study_id,:);
    [uniq_subject_id, ~, subject_id] = unique(this_dat.subject_id,'rows','stable');
    
    for j = 1:length(uniq_subject_id)
        this_subj_dat = this_dat(j == subject_id,:);
        event_by_study{i}{j} = this_subj_dat{:,find(strcmpi(this_subj_dat.Properties.VariableNames,varname))};
        t = length(event_by_study{i}{j});
        wh1 = 1:floor(t/2);
        wh2 = floor(t/2):t;
        mean_by_study{i}(j,1) = nanmean(event_by_study{i}{j}(wh1));
        mean_by_study{i}(j,2) = nanmean(event_by_study{i}{j}(wh2));
        id{i}{j,1} = uniq_study_id{i};
        id{i}{j,2} = uniq_subject_id{j};
    end
    mean_by_study{i}(any(isnan(mean_by_study{i}), 2), :) = [];
    icc(i,1) = ICC(3, 'k', mean_by_study{i});
end
mean12 = cat(1, mean_by_study{:});
id = cat(1, id{:});
end
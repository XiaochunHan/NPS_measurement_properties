clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/canlab_single_trials_for_git_repo';
SavePath = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior';
cd(Path);
load('metadata_all_NPS_complete_exclude_nsf.mat');
% NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
% single_trial_get_d_all_local_NPS_regions;
nps_pos = {'npspos','vermis','rIns','rV1','rThal','lIns','rdpIns','rS2','dACC'};
nps_neg = {'npsneg','rLOC','lLOC','rpLOC','pgACC','lSTS','rIPL','PCC'};

nps_pos_list = {'npspos','pos_nps_vermis','pos_nps_rIns','pos_nps_rV1','pos_nps_rThal','pos_nps_lIns','pos_nps_rdpIns','pos_nps_rS2_Op','pos_nps_dACC'};
nps_neg_list = {'npsneg','neg_nps_rLOC','neg_nps_lLOC','neg_nps_rpLOC','neg_nps_pgACC','neg_nps_lSTS','neg_nps_rIPL','neg_nps_PCC'};

%%
[reliab_nps,mean12_nps,id] = icc_by_study(all_data,'nps');
[reliab_pain,mean12_pain] = icc_by_study(all_data,'rating');
mean12 = table(id(:,1),id(:,2),mean12_nps(:,1),mean12_nps(:,2),mean12_pain(:,1),mean12_pain(:,2));
mean12.Properties.VariableNames = {'studyName','subjName','nps1','nps2','pain1','pain2'};
cd('../behavior')
writetable(mean12, 'mean12_nps_rating_exclude_nsf.csv');
%%
for p = 1:length(nps_pos_list)
    reliab_pos_region{p} = icc_by_study(all_data,nps_pos_list{p});
end
reliab_pos_region = cat(2, reliab_pos_region{:});
%%
for n = 1:length(nps_neg_list)
    reliab_neg_region{n} = icc_by_study(all_data,nps_neg_list{n});
end
reliab_neg_region = cat(2, reliab_neg_region{:});
%[pos,neg,icc,icc_pos_neg, icc_pos,icc_neg] = internal_icc_by_study(local_NPS_all_events_by_region);

%%
icc_all = [reliab_nps,reliab_pain,reliab_pos_region,reliab_neg_region];
ICC = array2table(icc_all,'VariableNames',['NPS','rating',nps_pos,nps_neg]);
cd('../behavior')
writetable(ICC, 'ICC_all_and_regions_exclude_nsf.csv');
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
    icc(i,1) = ICC(3, 'k', mean_by_study{i});
end
mean12 = cat(1, mean_by_study{:});
id = cat(1, id{:});
end
%%
function [pos,neg,icc,icc_pos_neg,icc_pos,icc_neg] = internal_icc_by_study(local_NPS_all_events_by_region)
for p = 1:length(local_NPS_all_events_by_region.nps_posnames)
    for s = 1:length(local_NPS_all_events_by_region.nps_posnames{p}.event_by_study)
        for c = 1:length(local_NPS_all_events_by_region.nps_posnames{p}.event_by_study{s})
            pos{s}(c,p) = mean(local_NPS_all_events_by_region.nps_posnames{p}.event_by_study{s}{c});
        end
    end
end
for n = 1:length(local_NPS_all_events_by_region.nps_negnames)
    for s = 1:length(local_NPS_all_events_by_region.nps_negnames{n}.event_by_study)
        for c = 1:length(local_NPS_all_events_by_region.nps_negnames{n}.event_by_study{s})
            neg{s}(c,n) = mean(local_NPS_all_events_by_region.nps_negnames{n}.event_by_study{s}{c});
        end
    end
end
for s = 1:length(pos)
    all = [pos{s}, neg{s}.*(-1)];
    pos_neg = [mean(pos{s},2),mean(neg{s},2).*(-1)];
    icc(s,1) = ICC(3, 'k', all);
    icc_pos_neg(s,1) = ICC(3, 'k', pos_neg);
    icc_pos(s,1) = ICC(3, 'k', pos{s});
    icc_neg(s,1) = ICC(3, 'k', neg{s});
end
end
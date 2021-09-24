clear;clc;close all;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './Figure2A_Reliability_and_trial_number';
all_data = readtable(dataFile);
%%
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_nps,icc_mean,icc_se] = icc_by_study_by_trial(all_data, 'nps');
id_icc = [uniq_study_id;'mean';'se'];
icc = [icc_nps,icc_mean,icc_se];
NPS_ICC = array2table(icc,'VariableNames',id_icc);
cd(savedir);
writetable(NPS_ICC, 'NPS_ICC_by_Trial.csv');
%%
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_rating,icc_mean_rating,icc_se_rating] = icc_by_study_by_trial(all_data, 'rating');
id_icc = [uniq_study_id;'mean';'se'];
icc_all = [icc_rating,icc_mean_rating,icc_se_rating];
rating_ICC = array2table(icc_all,'VariableNames',id_icc);
writetable(rating_ICC, 'rating_ICC_by_Trial.csv');
%%
function [icc,icc_mean,icc_se, weight,id] = icc_by_study_by_trial(all_data, varname)
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
        for t = 1:length(wh1)
            mean_by_study{t,i}(j,1) = nanmean(event_by_study{i}{j}(wh1(1,1:t)));
            mean_by_study{t,i}(j,2) = nanmean(event_by_study{i}{j}(wh2(1,1:t)));
        end
        id{i}{j,1} = uniq_study_id{i};
        id{i}{j,2} = uniq_subject_id{j};
    end
    for tr = 1:size(mean_by_study,1)
        if ~isempty(mean_by_study{tr,i})
           mean_by_study{tr,i}(find(all(mean_by_study{tr,i} == 0,2)),:) = [];
           mean_by_study{tr,i}(find(any(isnan(mean_by_study{tr,i}),2)),:) = [];
        end
        if size(mean_by_study{tr,i},1)<10
           continue
        else
           icc(tr,i) = ICC(3, 'k', mean_by_study{tr,i});
        end
    end
end
id = cat(1, id{:});
weight = cellfun(@length,mean_by_study);
weight(weight<10) = 0;
icc_mean = nansum(icc(:,1:8).*sqrt(weight(:,1:8)),2)./sum(sqrt(weight(:,1:8)),2);
for i = 1:length(icc_mean)
    icc_se(i,1) = nanstd(icc(i,1:8),sqrt(weight(i,1:8)))/sqrt(sum(weight(i,1:8)~=0,2));
end
end



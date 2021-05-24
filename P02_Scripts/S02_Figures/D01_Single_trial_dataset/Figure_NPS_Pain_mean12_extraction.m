clear;clc;
addpath(genpath('/Users/spring/Documents/Research/Reliability_NPS/P02_Scripts'));
addpath(genpath('/Users/spring/Documents/MATLAB/CanlabCore'));
addpath(genpath('/Users/spring/Documents/MATLAB/Neuroimaging_Pattern_Masks'));
Path = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset';
savePath = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset';
cd(Path);
load('metadata_all_NPS_complete_exclude_nsf.mat');
% NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
% single_trial_get_d_all_local_NPS_regions;

%%
[reliab_nps,mean12_nps,id] = icc_by_study(all_data,'nps');
[reliab_pain,mean12_pain] = icc_by_study(all_data,'rating');
mean12 = table(id(:,1),id(:,2),mean12_nps(:,1),mean12_nps(:,2),mean12_pain(:,1),mean12_pain(:,2));
mean12.Properties.VariableNames = {'studyName','subjName','nps1','nps2','pain1','pain2'};
cd(savePath)
writetable(mean12, 'scaled_mean12_nps_rating_exclude_nsf.csv');
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
    
    subject_means_by_study{i} = cellfun(@nanmean, event_by_study{i})';
    subject_means_by_study_rescale{i} = mean_by_study{i} ./ mad(subject_means_by_study{i});
    
    icc(i,1) = ICC(3, 'k', subject_means_by_study_rescale{i});
end
mean12 = cat(1, subject_means_by_study_rescale{:});
id = cat(1, id{:});
end

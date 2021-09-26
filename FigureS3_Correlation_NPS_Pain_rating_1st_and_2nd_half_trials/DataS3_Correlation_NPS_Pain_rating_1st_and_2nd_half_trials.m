clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
dFile = 
savedir = './FigureS3_Correlation_NPS_Pain_rating_1st_and_2nd_half_trials';
all_data = readtable(dataFile);
%%
[~,mean12_nps,id] = icc_by_study(all_data,'nps');
[~,mean12_pain] = icc_by_study(all_data,'rating');
mean12 = table(id(:,1),id(:,2),mean12_nps(:,1),mean12_nps(:,2),mean12_pain(:,1),mean12_pain(:,2));
mean12.Properties.VariableNames = {'studyName','subjName','nps1','nps2','pain1','pain2'};
cd(savedir);
writetable(mean12, 'mean12_nps_rating.csv');
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

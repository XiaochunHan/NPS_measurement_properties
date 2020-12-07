clear;clc;close all;
Path = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/canlab_single_trials_for_git_repo';
figPath = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/Figure';
File = 'metadata_all_NPS_complete_exclude_nsf.mat';
cd(Path);
load(File);
%%
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_nps,id] = icc_by_study_by_temp(all_data, 'nps');
uniq_temp_id = unique(id);
temp = uniq_temp_id(uniq_temp_id~=0);
table_icc = zeros(length(temp),length(uniq_study_id));
for s = 1:length(uniq_study_id)
    for i = 1:size(icc_nps,1)
        for t = 1:length(temp)
            if id(i,s) == temp(t,1)
               table_icc(t,s) = icc_nps(i,s);
            end
        end
    end
end

temp(find(all(table_icc == 0,2)),:) = [];
table_icc(find(all(table_icc == 0,2)),:) = [];

NPS_ICC = array2table([temp,table_icc],'VariableNames',['temp';uniq_study_id]);
cd('../behavior')
writetable(NPS_ICC, 'NPS_ICC_temp_exclude_nsf.csv');

%%
clear uniq_study_id id uniq_temp_id table_icc temp;
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_rating,id] = icc_by_study_by_temp(all_data, 'rating');
uniq_temp_id = unique(id);
temp = uniq_temp_id(uniq_temp_id~=0);
table_rating = zeros(length(temp),length(uniq_study_id));
for s = 1:length(uniq_study_id)
    for i = 1:size(icc_rating,1)
        for t = 1:length(temp)
            if id(i,s) == temp(t,1)
               table_rating(t,s) = icc_rating(i,s);
            end
        end
    end
end

temp(find(all(table_rating == 0,2)),:) = [];
table_rating(find(all(table_rating == 0,2)),:) = [];

NPS_rating = array2table([temp,table_rating],'VariableNames',['temp';uniq_study_id]);
cd('../behavior')
writetable(NPS_rating, 'rating_ICC_temp_exclude_nsf.csv');

%%
function [icc,id] = icc_by_study_by_temp(all_data, varname)
[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
for i = 1:nstudies
    this_dat = all_data(i == study_id,:);
    [uniq_temp_id, ~, temp_id] = unique(this_dat.T,'rows');
    
    for j = 1:length(uniq_temp_id)
        this_temp_dat = this_dat(j == temp_id,:);
        [uniq_subj_id, ~, subj_id] = unique(this_temp_dat.subject_id,'rows','stable');
        
        for k = 1:length(uniq_subj_id)
            this_subj_dat = this_temp_dat(k == subj_id, :);
            
            event_by_study_by_temp{i}{j}{k} = this_subj_dat{:,find(strcmpi(this_subj_dat.Properties.VariableNames,varname))};
            t = length(event_by_study_by_temp{i}{j}{k});
            if t > 3
               wh1 = 1:floor(t/2);
               wh2 = floor(t/2):t;
               mean_by_study_by_temp{j,i}(k,1) = nanmean(event_by_study_by_temp{i}{j}{k}(wh1));
               mean_by_study_by_temp{j,i}(k,2) = nanmean(event_by_study_by_temp{i}{j}{k}(wh2));
               
            end
            
        end
        id(j,i) = uniq_temp_id(j);
    end
    for tmp = 1:size(mean_by_study_by_temp,1)
        if ~isempty(mean_by_study_by_temp{tmp,i})
           mean_by_study_by_temp{tmp,i}(find(all(mean_by_study_by_temp{tmp,i} == 0,2)),:) = [];
        end
        if size(mean_by_study_by_temp{tmp,i},1)<13
           continue
        else
           icc(tmp,i) = ICC(3, 'k', mean_by_study_by_temp{tmp,i});
        end
    end
end
% id = cat(1, id{:});
end



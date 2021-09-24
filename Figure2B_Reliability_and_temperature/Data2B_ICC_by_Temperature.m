clear;clc;close all;
addpath(genpath('./Osf_data'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './Figure2B_Reliability_and_temperature';
all_data = readtable(dataFile);
%%
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_nps,id] = icc_by_study_by_temp(all_data, 'nps');
uniq_temp_id = unique(id);
temp = uniq_temp_id(uniq_temp_id~=0);
table_nps = zeros(length(temp),length(uniq_study_id));
for s = 1:length(uniq_study_id)
    for i = 1:size(icc_nps,1)
        for t = 1:length(temp)
            if id(i,s) == temp(t,1)
               table_nps(t,s) = icc_nps(i,s);
            end
        end
    end
end

temp(find(all(table_nps == 0,2)),:) = [];
table_nps(find(all(table_nps == 0,2)),:) = [];

NPS_ICC = array2table([temp,table_nps],'VariableNames',['temp';uniq_study_id]);

cd(savedir)
writetable(NPS_ICC, 'NPS_ICC_by_temperature.csv');
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

rating_ICC = array2table([temp,table_rating],'VariableNames',['temp';uniq_study_id]);
writetable(rating_ICC, 'rating_ICC_by_temperature.csv');
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
           mean_by_study_by_temp{tmp,i}(find(any(isnan(mean_by_study_by_temp{tmp,i}),2)),:) = [];
        end
        if size(mean_by_study_by_temp{tmp,i},1)<13
           continue
        else
           icc(tmp,i) = ICC(3, 'k', mean_by_study_by_temp{tmp,i});
        end
    end
end
end



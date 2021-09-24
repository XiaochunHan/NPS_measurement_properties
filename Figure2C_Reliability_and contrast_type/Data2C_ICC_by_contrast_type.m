clear;clc;close all;
addpath(genpath('./Osf_data'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './Figure2C_Reliability_and contrast_type';
all_data = readtable(dataFile);
%%
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_baseline,icc_contrast,id] = icc_by_study_by_contrast(all_data, 'nps');
uniq_temp_id = unique(id(2:end,:));
temp = uniq_temp_id(uniq_temp_id~=0);
table_icc_baseline = zeros(length(temp),length(uniq_study_id));
table_icc_contrast = zeros(length(temp),length(uniq_study_id));
for s = 1:length(uniq_study_id)
    for i = 2:size(icc_baseline,1)
        for t = 1:length(temp)
            if id(i,s) == temp(t,1)
               table_icc_baseline(t,s) = icc_baseline(i,s);
               table_icc_contrast(t,s) = icc_contrast(i,s);
            end
        end
    end
end

NPS_ICC_single = array2table([temp,table_icc_baseline],'VariableNames',['temp';uniq_study_id]);
NPS_ICC_contrast = array2table([temp,table_icc_contrast],'VariableNames',['temp';uniq_study_id]);
cd(savedir)
writetable(NPS_ICC_single, 'NPS_ICC_baseline.csv');
writetable(NPS_ICC_contrast, 'NPS_ICC_contrast.csv');

%%
uniq_study_id = unique(all_data.study_id,'rows','stable');
[icc_baseline,icc_contrast,id] = icc_by_study_by_contrast(all_data, 'rating');
uniq_temp_id = unique(id(2:end,:));
temp = uniq_temp_id(uniq_temp_id~=0);
table_icc_baseline = zeros(length(temp),length(uniq_study_id));
table_icc_contrast = zeros(length(temp),length(uniq_study_id));
for s = 1:length(uniq_study_id)
    for i = 2:size(icc_baseline,1)
        for t = 1:length(temp)
            if id(i,s) == temp(t,1)
               table_icc_baseline(t,s) = icc_baseline(i,s);
               table_icc_contrast(t,s) = icc_contrast(i,s);
            end
        end
    end
end

rating_ICC_single = array2table([temp,table_icc_baseline],'VariableNames',['temp';uniq_study_id]);
rating_ICC_contrast = array2table([temp,table_icc_contrast],'VariableNames',['temp';uniq_study_id]);
writetable(rating_ICC_single, 'rating_ICC_baseline.csv');
writetable(rating_ICC_contrast, 'rating_ICC_contrast.csv');

%%
function [icc_baseline,icc_contrast,id_shrink] = icc_by_study_by_contrast(all_data, varname)
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
           mean_by_study_by_temp{tmp,i}(find(all(mean_by_study_by_temp{tmp,i} == 0,2)),:) = NaN;
           mean_by_study_by_temp{tmp,i}(find(any(isnan(mean_by_study_by_temp{tmp,i}),2)),:) = [];
           if size(mean_by_study_by_temp{tmp,i}(find(all(~isnan(mean_by_study_by_temp{tmp,i}),2)),:),1)<13
              mean_by_study_by_temp{tmp,i} = [];
           end
        end
%         
    end
    
    c=0;
    for con = 1:size(mean_by_study_by_temp,1)
        if ~isempty(mean_by_study_by_temp{con,i})
           c = c + 1;
           extract{c,i} = mean_by_study_by_temp{con,i};
           if c ~= 1
              extract_match{c,i} = extract{c,i}(1:length(extract{1,i}),:);
              contrast{c,i} = extract_match{c,i} - extract{1,i};
              extract_match{c,i}(find(all(isnan(contrast{c,i}),2)),:) = [];
              contrast{c,i}(find(all(isnan(contrast{c,i}),2)),:) = [];
              icc_baseline(c,i) = ICC(3, 'k', extract_match{c,i});
              icc_contrast(c,i) = ICC(3, 'k', contrast{c,i});
           end
        else
           id(con,i) = NaN;
        end
    end
end

for c = 1:size(id,2)
    i = 0;
    for r = 1:size(id,1)
        if ~isnan(id(r,c)) && (id(r,c) ~=0)
           i = i+1; 
           id_shrink(i,c) = id(r,c);
        end
    end
end
end



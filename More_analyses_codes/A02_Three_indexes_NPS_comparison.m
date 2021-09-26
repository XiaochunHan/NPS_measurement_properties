clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
all_data = readtable(dataFile);
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
NPScorr = single_trial_retrieve_data_all_studies(all_data, 'nps_corr');
NPScos = single_trial_retrieve_data_all_studies(all_data, 'nps_cosine');
TEMP = single_trial_retrieve_data_all_studies(all_data, 'T');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
%% Mean response
dfun = @(x) mean(x) ./ std(x);
d_mean = cellfun(dfun, NPS.subject_means_by_study, 'UniformOutput', false);
d_mean = cat(1, d_mean{:});
d_mean_corr = cellfun(dfun, NPScorr.subject_means_by_study, 'UniformOutput', false);
d_mean_corr = cat(1, d_mean_corr{:});
d_mean_cos = cellfun(dfun, NPScos.subject_means_by_study, 'UniformOutput', false);
d_mean_cos = cat(1, d_mean_cos{:});
%% Within correlation with temperature
X = TEMP;
Y = NPS;
figname = 'Temperature by NPS by study within subject';
[~, ~, within_r_nps_temp] = plugin_regress_within_subject(X, Y, figname);
d_temp_within = cellfun(dfun, within_r_nps_temp, 'UniformOutput', false);
d_temp_within = cat(1, d_temp_within{:});
Y = NPScorr;
figname = 'Temperature by NPScorr by study within subject';
[~, ~, within_r_nps_corr_temp] = plugin_regress_within_subject(X, Y, figname);
d_temp_within_corr = cellfun(dfun, within_r_nps_corr_temp, 'UniformOutput', false);
d_temp_within_corr = cat(1, d_temp_within_corr{:});
Y = NPScos;
figname = 'Temperature by NPScos by study within subject';
[~, ~, within_r_nps_cos_temp] = plugin_regress_within_subject(X, Y, figname);
d_temp_within_cos = cellfun(dfun, within_r_nps_cos_temp, 'UniformOutput', false);
d_temp_within_cos = cat(1, d_temp_within_cos{:});
%% Within correlation with pain
X = PAIN;
Y = NPS;
figname = 'Pain by NPS by study within subject';
[~, ~, within_r_nps_pain] = plugin_regress_within_subject(X, Y, figname);
d_pain_within = cellfun(dfun, within_r_nps_pain, 'UniformOutput', false);
d_pain_within = cat(1, d_pain_within{:});
Y = NPScorr;
figname = 'Pain by NPScorr by study within subject';
[~, ~, within_r_nps_corr_pain] = plugin_regress_within_subject(X, Y, figname);
d_pain_within_corr = cellfun(dfun, within_r_nps_corr_pain, 'UniformOutput', false);
d_pain_within_corr = cat(1, d_pain_within_corr{:});
Y = NPScos;
figname = 'Pain by NPScos by study within subject';
[~, ~, within_r_nps_cos_pain] = plugin_regress_within_subject(X, Y, figname);
d_pain_within_cos = cellfun(dfun, within_r_nps_cos_pain, 'UniformOutput', false);
d_pain_within_cos = cat(1, d_pain_within_cos{:});
%% Between correlation with pain
r2d = @(r) 2*r ./ (1 - r.^2).^.5;
X = PAIN;
Y = NPS;
figname = 'Pain by NPS by study between subject';
[stats_table_nps, ~, ~] = plugin_regress_within_subject(X, Y, figname);
d_pain_between = arrayfun(r2d, stats_table_nps.between_person_r(1:8,1));
Y = NPScorr;
figname = 'Pain by NPScorr by study between subject';
[stats_table_nps_corr, ~, ~] = plugin_regress_within_subject(X, Y, figname);
d_pain_between_corr = arrayfun(r2d, stats_table_nps_corr.between_person_r(1:8,1));
Y = NPScos;
figname = 'Pain by NPScos by study between subject';
[stats_table_nps_cos, ~, ~] = plugin_regress_within_subject(X, Y, figname);
d_pain_between_cos = arrayfun(r2d, stats_table_nps_cos.between_person_r(1:8,1));
%% Reliability
[reliab_nps,~,id] = icc_by_study(all_data,'nps');
reliab_nps_corr = icc_by_study(all_data,'nps_corr');
reliab_nps_cos = icc_by_study(all_data,'nps_cosine');
%% Combine effect sizes and reliability
d_mean_all = [d_mean;d_mean_corr;d_mean_cos];
d_temp_all = [d_temp_within;d_temp_within_corr;d_temp_within_cos];
d_pain_all = [d_pain_within;d_pain_within_corr;d_pain_within_cos];
d_pain_between_all = [d_pain_between;d_pain_between_corr;d_pain_between_cos];
reliab_all = [reliab_nps;reliab_nps_corr;reliab_nps_cos];
all = [d_mean_all,d_temp_all,d_pain_all,d_pain_between_all,reliab_all];
allT = array2table(all,'VariableNames',{'mean_response','withinSub_temp','withinSub_pain','betweenSub_pain','reliable_nps'});
allT.studyID = [id;id;id];
allT.index = [repmat({'dot'},8,1);repmat({'corr'},8,1);repmat({'cosine'},8,1)];
%% one-way ANOVA
[uniq_index_id, ~, index_id] = unique(allT.index,'rows','stable');
nindex = length(uniq_index_id);
for i = 1:nindex
    this_index = allT(i == index_id,:);
    for j = 1:5
        mean_index(i,j) = mean(this_index{:,j});
        se_index(i,j) = ste(this_index{:,j});
    end
end

p_d_mean = anova1(allT.mean_response,allT.index);
p_d_temp = anova1(allT.withinSub_temp,allT.index);
p_d_pain = anova1(allT.withinSub_pain,allT.index);
p_d_pain_between = anova1(allT.betweenSub_pain,allT.index);
p_reliab = anova1(allT.reliable_nps,allT.index);

p_all = [p_d_mean,p_d_temp,p_d_pain,p_d_pain_between,p_reliab];
p_table = array2table(p_all, 'VariableNames',{'mean_response','within_r_temp','within_r_pain','between_r_pain','reliability'}, 'RowNames',{'ANOVA_p'});
disp(p_table);
%%
function [icc,mean12,uniq_study_id] = icc_by_study(all_data, varname)
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
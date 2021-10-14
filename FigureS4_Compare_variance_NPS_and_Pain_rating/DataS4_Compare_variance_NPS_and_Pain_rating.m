clear;clc;
addpath(genpath('./MATLAB/CanlabCore'));
addpath(genpath('./Osf_data'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS_Compare_variance_NPS_and_Pain_rating';
all_data = readtable(dataFile);
%% variability of nps and pain across all temperatures
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');

for i = 1:8
    nps_std(i) = std(NPS.subject_means_by_study{i});
    pain_std(i) = std(PAIN.subject_means_by_study{i});
end

all_temp = cell2table(cell(16,3),'VariableNames',{'studynames','measure','sd'});
all_temp.studynames = repmat(NPS.studynames,2,1);
all_temp.measure = [repmat({'nps'},8,1);repmat({'pain'},8,1)];
all_temp.sd = [nps_std';pain_std'];
cd(savedir);
writetable(all_temp,'Variance_all.csv');

% two-sample t-test
[h,p,ci,stats] = ttest2(nps_std,pain_std);

summary = [mean(nps_std),std(nps_std),mean(pain_std),std(pain_std),stats.tstat,p];
disp(array2table(summary,'VariableNames',{'mean_nps','std_nps','mean_pain','std_pain','t','p'}));

%% variability_by_temperature of nps and pain
[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
event_by_temp = {};

for i = 1:nstudies
    
    this_dat = all_data(i == study_id,:);
    [uniq_temp_id, ~, temp_id] = unique(this_dat.T,'rows','stable');
    
    for j = 1:length(uniq_temp_id)
        this_temp_dat = this_dat(j == temp_id,:);
        event_by_temp_nps{i}{j} = this_temp_dat{:,find(strcmpi(this_temp_dat.Properties.VariableNames,'nps'))};
        event_by_temp_pain{i}{j} = this_temp_dat{:,find(strcmpi(this_temp_dat.Properties.VariableNames,'rating'))};
        
        if length(event_by_temp_nps{i}{j})>15
           OUT.temp_id{i}(j) = uniq_temp_id(j);
        end
    end
    OUT.temp_id{i} = sort(OUT.temp_id{i});
    
    for t = 1:length(OUT.temp_id{i})
        this_temp_dat = this_dat(this_dat.T == OUT.temp_id{i}(t),:);
        [uniq_subj_id, ~, subj_id] = unique(this_temp_dat.subject_id,'rows','stable');

        for k = 1:length(uniq_subj_id)
            this_subj_dat = this_temp_dat(k == subj_id, :);

            event_by_study_by_temp_nps{i}{t}{k} = this_subj_dat{:,find(strcmpi(this_subj_dat.Properties.VariableNames,'nps'))};
            event_by_study_by_temp_pain{i}{t}{k} = this_subj_dat{:,find(strcmpi(this_subj_dat.Properties.VariableNames,'rating'))};
            mean_event_by_study_by_temp_nps{i}{t}(k) = nanmean(event_by_study_by_temp_nps{i}{t}{k});
            mean_event_by_study_by_temp_pain{i}{t}(k) = nanmean(event_by_study_by_temp_pain{i}{t}{k});
        end
        OUT.std_by_study_by_temp_nps{i}(t) = nanstd(mean_event_by_study_by_temp_nps{i}{t});
        OUT.std_by_study_by_temp_pain{i}(t) = nanstd(mean_event_by_study_by_temp_pain{i}{t});
    end
    
end
temp_by_study = cell2table(cell(40,4),'VariableNames',{'studynames','measure','temperature','sd'});
temp_by_study.studynames = repmat([repmat({'study1'},length(OUT.temp_id{1}),1);...
                                   repmat({'study2'},length(OUT.temp_id{2}),1);...
                                   repmat({'study3'},length(OUT.temp_id{3}),1);...
                                   repmat({'study5'},length(OUT.temp_id{5}),1);...
                                   repmat({'study6'},length(OUT.temp_id{6}),1);...
                                   repmat({'study8'},length(OUT.temp_id{8}),1)],2,1);
temp_by_study.measure = [repmat({'nps'},20,1);repmat({'pain'},20,1)];      
temp_by_study.temperature = repmat(cat(2,OUT.temp_id{[1,2,3,5,6,8]})',2,1);
temp_by_study.sd = [cat(2,OUT.std_by_study_by_temp_nps{[1,2,3,5,6,8]})';...
                    cat(2,OUT.std_by_study_by_temp_pain{[1,2,3,5,6,8]})'];
              
writetable(temp_by_study,'Variance_temp_by_study.csv');
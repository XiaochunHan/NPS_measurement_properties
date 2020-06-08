clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
cd(Path);
load('metadata_all.mat');

[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
t = [];
for i = 1:nstudies
    
    this_dat = all_data(i == study_id,:);
    t = [t;size(this_dat,1)];
end

PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
TEMP = single_trial_retrieve_data_all_studies(all_data, 'T');

NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
NPScorr = single_trial_retrieve_data_all_studies(all_data, 'nps_corr');
NPScosine = single_trial_retrieve_data_all_studies(all_data, 'nps_cosine');

NPS_pos = single_trial_retrieve_data_all_studies(all_data, 'npspos');
NPScorr_pos = single_trial_retrieve_data_all_studies(all_data, 'npspos_corr');
NPScosine_pos = single_trial_retrieve_data_all_studies(all_data, 'npspos_cosine');

NPS_neg = single_trial_retrieve_data_all_studies(all_data, 'npsneg');
NPScorr_neg = single_trial_retrieve_data_all_studies(all_data, 'npsneg_corr');
NPScosine_neg = single_trial_retrieve_data_all_studies(all_data, 'npsneg_cosine');

zPAIN = single_trial_retrieve_data_all_studies(all_data, 'zrating');
zTEMP = single_trial_retrieve_data_all_studies(all_data, 'zT');

zNPS = single_trial_retrieve_data_all_studies(all_data, 'znps');
zNPScorr = single_trial_retrieve_data_all_studies(all_data, 'znps_corr');
zNPScosine = single_trial_retrieve_data_all_studies(all_data, 'znps_cosine');

zNPS_pos = single_trial_retrieve_data_all_studies(all_data, 'znpspos');
zNPScorr_pos = single_trial_retrieve_data_all_studies(all_data, 'znpspos_corr');
zNPScosine_pos = single_trial_retrieve_data_all_studies(all_data, 'znpspos_cosine');

zNPS_neg = single_trial_retrieve_data_all_studies(all_data, 'znpsneg');
zNPScorr_neg = single_trial_retrieve_data_all_studies(all_data, 'znpsneg_corr');
zNPScosine_neg = single_trial_retrieve_data_all_studies(all_data, 'znpsneg_cosine');

%%
function OUT =  single_trial_retrieve_data_all_studies(all_data, varname)
% - Retrieve a variable from study_canlab_dataset cell array
% For EVENT-LEVEL data:
% - Calculate event-level standard error and df including "ok_trials" only, excluding NaNs and high-VIF from event-level data
% - Return both no-NaN and ALL event-level data to permit concatenation with other variables
% - Return z-scored data within-subject (concatenated)
% - Concatenate events across studies for combined analysis
%
% INDIVIDUAL DIFFERENCES data:
% - Calculate individual differences (person-level averages)
% - Calculate normalized within-study ranks (rank subjects / N in study)
% - Concatenate subject means across studies for combined analysis
%
% - Return a structure with all variables
%
% Usage:
% OUT = single_trial_retrieve_data_all_studies(study_canlab_dataset, varname)
%
% Example:
% figure; plot(VARS_CAT.Pain_mean)  % extracted pain from prep scripts
% OUT =  single_trial_retrieve_data_all_studies(study_canlab_dataset, 'ratings');
% hold on; plot(OUT.subject_means_cat, 'r');
%
% Example: individual diffs
% PAIN =  single_trial_retrieve_data_all_studies(study_canlab_dataset, 'ratings');
% NPS =  single_trial_retrieve_data_all_studies(study_canlab_dataset, 'NPS');
% corr(PAIN.rank_subjectmeans_cat, NPS.rank_subjectmeans_cat)
% r = []; for i = 1:nstudies, r(i, 1) = corr(PAIN.subject_means_by_study{i}, NPS.subject_means_by_study{i}); end

[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);

OUT.nstudies = nstudies;
OUT.studynames = uniq_study_id;

event_by_study = {};
%event_by_study_noNaNs = {}; ***omitted this - redundant***
event_by_study_zscore = {};

% Extract from canlab_datasets
% ---------------------------------------------------------------------
for i = 1:nstudies
    
    this_dat = all_data(i == study_id,:);
    [uniq_subject_id, ~, subject_id] = unique(this_dat.subject_id,'rows','stable');
    
    for j = 1:length(uniq_subject_id)
        this_subj_dat = this_dat(j == subject_id,:);
        event_by_study{i}{j} = this_subj_dat{:,find(strcmpi(this_subj_dat.Properties.VariableNames,varname))};
    end
end

OUT.event_by_study = event_by_study;

% STE and DF
% ---------------------------------------------------------------------

clear N

for i = 1:nstudies
    
    %event_by_study_noNaNs{i} = {};
    event_by_study_zscore{i} = {};
    
    % Standard error
    ste_by_study{i} = cellfun(@ste, event_by_study{i})';
    
    N(i) = length(event_by_study{i});
    
    for j = 1:N(i)
        % z-score within, omit nans
        [wasnan, eventstmp] = nanremove(event_by_study{i}{j});
        eventstmp = zscore(eventstmp);
        eventstmp = naninsert(wasnan, eventstmp);
        
        event_by_study_zscore{i}{j} = eventstmp;
        
        % remove nans ***omitted this - redundant***
        %[wasnan, event_by_study_noNaNs{i}{j}] = nanremove(event_by_study{i}{j});
    end
    
    % Degrees of freedom
    df_by_study{i} = (cellfun(@length, event_by_study{i}) - 1)';  % not precise without removing NaNs, now ok, see above
    
end  % study

%OUT.event_by_study_noNaNs = event_by_study_noNaNs;
OUT.event_by_study_zscore = event_by_study_zscore;
OUT.N = N;
OUT.df_by_study = df_by_study;

% INDIVIDUAL DIFFS
% ---------------------------------------------------------------------
for i = 1:nstudies
    
    OUT.subject_means_by_study{i} = cellfun(@nanmean, event_by_study{i})';
    
    % Within-person standard errors across trials
    OUT.subject_stes_by_study{i} = cellfun(@ste, event_by_study{i})';
    
end

% CONCATENATE
% ---------------------------------------------------------------------
eventscat = {};
Xi = {};  % subject intercept model
Xis = {}; % study intercept model

for i = 1:nstudies
    
    eventscat{i} = cat(1, OUT.event_by_study{i}{:});

    eventscatz{i} = cat(1, OUT.event_by_study_zscore{i}{:});

    Xi{i} = intercept_model(OUT.df_by_study{i}'+1); % adjust +1 to get n trials
    
    Xis{i} = ones(size(eventscat{i}));
    
end

OUT.events_cat = cat(1, eventscat{:});
OUT.events_cat_zscore_within_subject = cat(1, eventscatz{:});

OUT.subject_intercepts = blkdiag(Xi{:});
OUT.study_intercepts = blkdiag(Xis{:});

OUT.subject_means_cat = cat(1, OUT.subject_means_by_study{:});
OUT.subject_stes_cat = cat(1, OUT.subject_stes_by_study{:});

% RANKS
% ---------------------------------------------------------------------
for i = 1:nstudies
    
    OUT.rank_subjectmeans_by_study{i} = rankdata(OUT.subject_means_by_study{i}) ./ length(OUT.subject_means_by_study{i});
    
end

OUT.rank_subjectmeans_cat = cat(1, OUT.rank_subjectmeans_by_study{:});

% Rescale experiment-wise by median abs. deviation
% ---------------------------------------------------------------------
OUT = single_trial_rescale_multistudy_data_by_mad(OUT);


end % function
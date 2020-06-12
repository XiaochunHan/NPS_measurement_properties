% % - Collect data for local NPS regions across all subjects in all studies
% - Return within-subject z-scored events in local_NPS_all_events_by_region
% - Save subject means and rescale study-wise by study MAD
% - Return subject means in local_NPS_by_region_pos and local_NPS_by_region_neg
% - Calculate Cohen's d effect size for each subregion/study
% - Print a table of effect sizes

% Key output variables:
% -------------------------------------------------------------------------
nps_posnames = {'npspos_corr'    'pos_nps_vermis_corr'    'pos_nps_rIns_corr'    'pos_nps_rV1_corr'    'pos_nps_rThal_corr'    'pos_nps_lIns_corr'    'pos_nps_rdpIns_corr'    'pos_nps_rS2_Op_corr'    'pos_nps_dACC_corr'};
nps_negnames = {'npsneg_corr'    'neg_nps_rLOC_corr'    'neg_nps_lLOC_corr'    'neg_nps_rpLOC_corr'    'neg_nps_pgACC_corr'    'neg_nps_lSTS_corr'    'neg_nps_rIPL_corr'    'neg_nps_PCC_corr'};

clear local_NPS_all_events_by_region local_NPS_by_region_pos local_NPS_by_region_neg d_by_study_region_pos d_by_study_region_neg NPS_subject_means

% local_NPS_by_region_pos: Cell 1 x regions, each is vector of NPS subject
% means [subjects x 1] for local pattern
%
% NPS_subject_means: vector of NPS subject means [subjects x 1] for whole NPS

% d_by_study_region: Cell 1 x regions, each is vector of NPS cohen's d [studies x 1] for local pattern
%
% NPS_d_by_study: Same, for overall NPS

% Functions
% -------------------------------------------------------------------------

% Rescale data for display/aggregation
rescalefcn =  @(x) double(x) ./ mad(double(x));

% Effect size function (is not affected by rescaling)
dfun = @(x) mean(double(x)) ./ std(double(x));

local_NPS_all_events_by_region.descrip = 'Single-trial estimates z-scored within participant';
local_NPS_all_events_by_region.varnames = [nps_posnames nps_negnames];

% Main loop
% -------------------------------------------------------------------------

% printstr('Positive regions')
% printstr(dashes)

for i = 1:length(nps_posnames)
    fprintf('Posregion %s \n',nps_posnames{i});
    % Retrieve data structure for this variable - local NPS for this region
    Y_by_study_region = single_trial_retrieve_data_all_studies(all_data_selected, nps_posnames{i});
    
    % Get and rescale means - scale by study MAD
    mysubjectmeans = Y_by_study_region.subject_means_by_study;
%     mysubjectmeans = cellfun(rescalefcn, mysubjectmeans, 'UniformOutput', false);
%    
%     % Save for connectivity
    local_NPS_all_events_by_region.nps_posnames{i}.event_by_study_zscore = Y_by_study_region.event_by_study_zscore;
    local_NPS_all_events_by_region.nps_posnames{i}.event_by_study = Y_by_study_region.event_by_study;
    local_NPS_all_events_by_region.nps_posnames{i}.subject_means_by_study = Y_by_study_region.subject_means_by_study;

    % Save for plots, etc:
%     local_NPS_by_region_pos{i} = cat(1, mysubjectmeans{:});
    
    % Effect size
    d = cellfun(dfun, mysubjectmeans, 'UniformOutput', false);
    d = cat(1, d{:});
    
    nps_d_by_study_region_pos{i} = d;
    
    
    fprintf('%s\tAverage d = %3.2f\t Range =\t%3.2f\t%3.2f\n', nps_posnames{i}, mean(d), min(d), max(d));
    
end

% printstr('Negative regions')
% printstr(dashes)

for i = 1:length(nps_negnames)
    fprintf('Posregion %s \n',nps_negnames{i});
    % Retrieve data structure for this variable - local NPS for this region
    Y_by_study_region = single_trial_retrieve_data_all_studies(all_data_selected, nps_negnames{i});
    
    % Get and rescale means - scale by study MAD
    mysubjectmeans = Y_by_study_region.subject_means_by_study;
%     mysubjectmeans = cellfun(rescalefcn, mysubjectmeans, 'UniformOutput', false);
%    
%     % Save for connectivity
    local_NPS_all_events_by_region.nps_negnames{i}.event_by_study_zscore = Y_by_study_region.event_by_study_zscore;
    local_NPS_all_events_by_region.nps_negnames{i}.event_by_study = Y_by_study_region.event_by_study;
    local_NPS_all_events_by_region.nps_negnames{i}.subject_means_by_study = Y_by_study_region.subject_means_by_study;

    % Save for plots, etc:
%     local_NPS_by_region_neg{i} = cat(1, mysubjectmeans{:});
    
    % Effect size
    d = cellfun(dfun, mysubjectmeans, 'UniformOutput', false);
    d = cat(1, d{:});
    
    nps_d_by_study_region_neg{i} = d;
    
    
    fprintf('%s\tAverage d = %3.2f\t Range =\t%3.2f\t%3.2f\n', nps_negnames{i}, mean(d), min(d), max(d));
    
end

% printstr(dashes)

% whole pattern NPS
% -------------------------------------------------------------------------

% NPScorr_subject_means = cellfun(rescalefcn, NPScorr.subject_means_by_study, 'UniformOutput', false);
NPScorr_d_by_study = cellfun(dfun, NPScorr.subject_means_by_study, 'UniformOutput', false);

% NPScorr_subject_means = cat(1, NPScorr.subject_means_by_study{:});
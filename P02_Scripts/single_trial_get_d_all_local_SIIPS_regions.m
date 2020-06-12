% - Collect data for local SIIPS regions across all subjects in all studies
% - Return within-subject z-scored events in local_SIIPS_all_events_by_region
% - Save subject means and rescale study-wise by study MAD
% - Return subject means in local_SIIPS_by_region_pos and local_SIIPS_by_region_neg
% - Calculate Cohen's d effect size for each subregion/study
% - Print a table of effect sizes

% Key output variables:
% -------------------------------------------------------------------------
siips_posnames = {'siipspos_corr'  'pos_siips_lCB_corr'    'pos_siips_vermis_corr'    'pos_siips_rCB_corr'    'pos_siips_rMTG_corr'    'pos_siips_rSN_corr'    'pos_siips_rmdpINS_corr'    'pos_siips_laINS_corr'    'pos_siips_rvLPFC_corr'...
                'pos_siips_lCOp_corr'    'pos_siips_rCOp_corr'  'pos_siips_lmINS_corr' 'pos_siips_ldpINS_corr'    'pos_siips_lThal_corr' 'pos_siips_lCaud_corr' 'pos_siips_rCaud_corr' 'pos_siips_dmPFC_corr' 'pos_siips_MCC_SMA_corr'...
                'pos_siips_rPrecen_corr' 'pos_siips_lPrec_corr' 'pos_siips_rSPL_corr'  'pos_siips_lSPL_corr'};
siips_negnames = {'siipsneg_corr'  'neg_siips_lTP_corr'    'neg_siips_lHC_PHC_corr'    'neg_siips_rTP_corr'    'neg_siips_rHC_corr'    'neg_siips_lTP2_corr'    'neg_siips_vmPFC_corr'    'neg_siips_lNAc_corr'    'neg_siips_rLG_corr'   'neg_siips_rSTG_corr'...
                'neg_siips_lMTG_corr'    'neg_siips_rNAc_corr'  'neg_siips_rCun_corr'  'neg_siips_lSTG_corr'  'neg_siips_lMOG_corr'  'neg_siips_ldlPFC_corr'    'neg_siips_rdlPFC_corr'    'neg_siips_rS2_corr'   'neg_siips_rSMC_corr'...
                'neg_siips_rPrecu_corr'  'neg_siips_lSMC_corr'  'neg_siips_lSPL_corr'  'neg_siips_midPrecen_corr' 'neg_siips_lPrecu_corr'};
            
clear local_SIIPS_all_events_by_region local_SIIPS_by_region_pos local_SIIPS_by_region_neg d_by_study_region_pos d_by_study_region_neg SIIPS_subject_means

% local_SIIPS_by_region_pos: Cell 1 x regions, each is vector of SIIPS subject
% means [subjects x 1] for local pattern
%
% SIIPS_subject_means: vector of SIIPS subject means [subjects x 1] for whole SIIPS

% d_by_study_region: Cell 1 x regions, each is vector of SIIPS cohen's d [studies x 1] for local pattern
%
% SIIPS_d_by_study: Same, for overall SIIPS

% Functions
% -------------------------------------------------------------------------

% Rescale data for display/aggregation
rescalefcn =  @(x) double(x) ./ mad(double(x));

% Effect size function (is not affected by rescaling)
dfun = @(x) mean(double(x)) ./ std(double(x));

local_SIIPS_all_events_by_region.descrip = 'Single-trial estimates z-scored within participant';
local_SIIPS_all_events_by_region.varnames = [siips_posnames siips_negnames];

% Main loop
% -------------------------------------------------------------------------

% printstr('Positive regions')
% printstr(dashes)

for i = 1:length(siips_posnames)
    fprintf('Posregion %s \n',siips_posnames{i});
    % Retrieve data structure for this variable - local SIIPS for this region
    Y_by_study_region = single_trial_retrieve_data_all_studies(all_data_selected, siips_posnames{i});
    
    % Get and rescale means - scale by study MAD
    mysubjectmeans = Y_by_study_region.subject_means_by_study;
%     mysubjectmeans = cellfun(rescalefcn, mysubjectmeans, 'UniformOutput', false);
%    
%     % Save for connectivity
    local_SIIPS_all_events_by_region.siips_posnames{i}.event_by_study_zscore = Y_by_study_region.event_by_study_zscore;
    local_SIIPS_all_events_by_region.siips_posnames{i}.event_by_study = Y_by_study_region.event_by_study;
    local_SIIPS_all_events_by_region.siips_posnames{i}.subject_means_by_study = Y_by_study_region.subject_means_by_study;


    % Save for plots, etc:
    local_SIIPS_by_region_pos{i} = cat(1, mysubjectmeans{:});
    
    % Effect size
    d = cellfun(dfun, mysubjectmeans, 'UniformOutput', false);
    d = cat(1, d{:});
    
    siips_d_by_study_region_pos{i} = d;
    
    
    fprintf('%s\tAverage d = %3.2f\t Range =\t%3.2f\t%3.2f\n', siips_posnames{i}, mean(d), min(d), max(d));
    
end

% printstr('Negative regions')
% printstr(dashes)

for i = 1:length(siips_negnames)
    fprintf('Posregion %s \n',siips_negnames{i});
    % Retrieve data structure for this variable - local SIIPS for this region
    Y_by_study_region = single_trial_retrieve_data_all_studies(all_data_selected, siips_negnames{i});
    
    % Get and rescale means - scale by study MAD
    mysubjectmeans = Y_by_study_region.subject_means_by_study;
%     mysubjectmeans = cellfun(rescalefcn, mysubjectmeans, 'UniformOutput', false);
%    
%     % Save for connectivity
    local_SIIPS_all_events_by_region.siips_negnames{i}.event_by_study_zscore = Y_by_study_region.event_by_study_zscore;
    local_SIIPS_all_events_by_region.siips_negnames{i}.event_by_study = Y_by_study_region.event_by_study;
    local_SIIPS_all_events_by_region.siips_negnames{i}.subject_means_by_study = Y_by_study_region.subject_means_by_study;

    % Save for plots, etc:
    local_SIIPS_by_region_neg{i} = cat(1, mysubjectmeans{:});
    
    % Effect size
    d = cellfun(dfun, mysubjectmeans, 'UniformOutput', false);
    d = cat(1, d{:});
    
    siips_d_by_study_region_neg{i} = d;
    
    
    fprintf('%s\tAverage d = %3.2f\t Range =\t%3.2f\t%3.2f\n', siips_negnames{i}, mean(d), min(d), max(d));
    
end

% printstr(dashes)

% whole pattern SIIPS
% -------------------------------------------------------------------------

% SIIPScorr_subject_means = cellfun(rescalefcn, SIIPScorr.subject_means_by_study, 'UniformOutput', false);
SIIPScorr_d_by_study = cellfun(dfun, SIIPScorr.subject_means_by_study, 'UniformOutput', false);

SIIPScorr_subject_means = cat(1, SIIPScorr.subject_means_by_study{:});

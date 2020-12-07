clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
studycolors = seaborn_colors(8)';
cd(Path);
load('metadata_all_NPS_complete_exclude_nsf.mat');

[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
sub = [];
t = [];
for i = 1:nstudies
    this_dat = all_data(i == study_id,:);
    s = unique(this_dat.subject_id,'rows','stable');
    sub = [sub;size(s,1)];
    t = [t;size(this_dat,1)];
    label{i} = [uniq_study_id{i},'-',num2str(size(s,1)),'S-',num2str(size(this_dat,1)),'T'];
    
end
%%
figname = 'Study distribution';
create_figure(figname); 
wani_pie(t, 'colors', studycolors,'labels',label, 'hole','hole_size',20000);
axis off;
% set(gcf,'Position',[100 100 1000 800])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
%%
PAIN = single_trial_retrieve_data_all_studies(all_data_selected, 'rating');
TEMP = single_trial_retrieve_data_all_studies(all_data_selected, 'T');

% all
NPS = single_trial_retrieve_data_all_studies(all_data_selected, 'nps');
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
NPScosine = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_cosine');

SIIPS = single_trial_retrieve_data_all_studies(all_data_selected, 'siips');
SIIPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'siips_corr');
SIIPScosine = single_trial_retrieve_data_all_studies(all_data_selected, 'siips_cosine');

clear this_dat all_data_selected;

% % pos
% NPS_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'npspos');
% NPScorr_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'npspos_corr');
% NPScosine_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'npspos_cosine');
% 
% SIIPS_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'siipspos');
% SIIPScorr_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'siipspos_corr');
% SIIPScosine_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'siipspos_cosine');
% 
% % neg
% NPS_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'npsneg');
% NPScorr_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'npsneg_corr');
% NPScosine_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'npsneg_cosine');
% 
% SIIPS_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'siipsneg');
% SIIPScorr_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'siipsneg_corr');
% SIIPScosine_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'siipsneg_cosine');

% zPAIN = single_trial_retrieve_data_all_studies(all_data_selected, 'zrating');
% zTEMP = single_trial_retrieve_data_all_studies(all_data_selected, 'zT');
% 
% % all_z
% zNPS = single_trial_retrieve_data_all_studies(all_data_selected, 'znps');
% zNPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'znps_corr');
% zNPScosine = single_trial_retrieve_data_all_studies(all_data_selected, 'znps_cosine');
% 
% zSIIPS = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiips');
% zSIIPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiips_corr');
% zSIIPScosine = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiips_cosine');
% 
% % pos_z
% zNPS_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'znpspos');
% zNPScorr_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'znpspos_corr');
% zNPScosine_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'znpspos_cosine');
% 
% zSIIPS_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiipspos');
% zSIIPScorr_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiipspos_corr');
% zSIIPScosine_pos = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiipspos_cosine');
% 
% % neg_z
% zNPS_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'znpsneg');
% zNPScorr_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'znpsneg_corr');
% zNPScosine_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'znpsneg_cosine');
% 
% zSIIPS_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiipsneg');
% zSIIPScorr_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiipsneg_corr');
% zSIIPScosine_neg = single_trial_retrieve_data_all_studies(all_data_selected, 'zsiipsneg_cosine');

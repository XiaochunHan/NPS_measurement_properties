clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
studycolors = seaborn_colors(9)';
cd(Path);
load('metadata_all_valid.mat');
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
SIIPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'siips_corr');
single_trial_get_d_all_local_NPS_regions;
single_trial_get_d_all_local_SIIPS_regions;
%% Pain signature mean response

figname = 'NPS local regions Effect size stim vs. baseline';

create_figure(figname,2,1)

d_nps_corr = mean(cat(1,NPScorr_d_by_study{:}));
ste_nps_corr = ste(cat(1,NPScorr_d_by_study{:}));
d_siips_corr = mean(cat(1,SIIPScorr_d_by_study{:}));
ste_siips_corr = ste(cat(1,SIIPScorr_d_by_study{:}));

subplot(2,1,1);
clear han*
npspos_mean_d_all = cellfun(@mean, nps_d_by_study_region_pos, 'UniformOutput', false);
npspos_se_d_all = cellfun(@ste, nps_d_by_study_region_pos, 'UniformOutput', false);

bar(cell2mat(npspos_mean_d_all),'y');
hold on
errorbar(cell2mat(npspos_mean_d_all), cell2mat(npspos_se_d_all), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_nps_corr+ste_nps_corr,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(d_nps_corr-ste_nps_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_posnames), 'xticklabels', nps_posnames, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS positive local regions');
legend off;

%%
subplot(2,1,2);
clear han*
npsneg_mean_d_all = cellfun(@mean, nps_d_by_study_region_neg, 'UniformOutput', false);
npsneg_se_d_all = cellfun(@ste, nps_d_by_study_region_neg, 'UniformOutput', false);

bar(cell2mat(npsneg_mean_d_all),'b');
hold on
errorbar(cell2mat(npsneg_mean_d_all), cell2mat(npsneg_se_d_all), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_nps_corr+ste_nps_corr,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(d_nps_corr-ste_nps_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_negnames), 'xticklabels', nps_negnames, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS negative local regions');
legend off;

set(gcf,'Position',[100 100 1000 1000])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
%%
figname = 'SIIPS local regions Effect size stim vs. baseline';

create_figure(figname,2,1)

subplot(2,1,1);
clear han*
siipspos_mean_d_all = cellfun(@mean, siips_d_by_study_region_pos, 'UniformOutput', false);
siipspos_se_d_all = cellfun(@ste, siips_d_by_study_region_pos, 'UniformOutput', false);

bar(cell2mat(siipspos_mean_d_all),'y');
hold on
errorbar(cell2mat(siipspos_mean_d_all), cell2mat(siipspos_se_d_all), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_siips_corr+ste_siips_corr,'--','SIIPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_siips_corr,'LineWidth',1.5);
hold on;
han5 = yline(d_siips_corr-ste_siips_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(siips_posnames), 'xticklabels', siips_posnames, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of SIIPS positive local regions');
legend off;

%%
subplot(2,1,2);
clear han*
siipsneg_mean_d_all = cellfun(@mean, siips_d_by_study_region_neg, 'UniformOutput', false);
siipsneg_se_d_all = cellfun(@ste, siips_d_by_study_region_neg, 'UniformOutput', false);

bar(cell2mat(siipsneg_mean_d_all),'b');
hold on
errorbar(cell2mat(siipsneg_mean_d_all), cell2mat(siipsneg_se_d_all), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_siips_corr+ste_siips_corr,'--','SIIPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_siips_corr,'LineWidth',1.5);
hold on;
han5 = yline(d_siips_corr-ste_siips_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(siips_negnames), 'xticklabels', siips_negnames, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of SIIPS negative local regions');
legend off;
set(gcf,'Position',[100 100 1000 1000])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
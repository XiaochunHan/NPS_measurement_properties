clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
cd(Path);
load('metadata_all_valid.mat');
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
SIIPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'siips_corr');
PAIN = single_trial_retrieve_data_all_studies(all_data_selected, 'T');
single_trial_get_d_all_local_NPS_regions;
single_trial_get_d_all_local_SIIPS_regions;
clearvars -except NPScorr SIIPScorr PAIN local_NPS_all_events_by_region local_SIIPS_all_events_by_region NPScorr_d_by_study nps_posnames nps_negnames siips_posnames siips_negnames figsavedir;
%% NPS correlation with TEMP between subjects

figname = 'NPS local regions correlation with PAIN between subjects';
X = PAIN;
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    stats_table_npspos = plugin_regress_within_subject(X, Y, figname);
    d_npspos = atanh(stats_table_npspos.between_person_r);
    d_npspos_mean(p,1) = d_npspos(10,1);
    d_npspos_ste(p,1) = ste(d_npspos(1:9,1));
end
for p = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{p};
    stats_table_npsneg = plugin_regress_within_subject(X, Y, figname);
    d_npsneg = atanh(stats_table_npsneg.between_person_r);
    d_npsneg_mean(p,1) = d_npsneg(10,1);
    d_npsneg_ste(p,1) = ste(d_npsneg(1:9,1));
end
create_figure(figname,2,1)

Y = NPScorr;
stats_table_nps = plugin_regress_within_subject(X, Y, figname);
d_nps = atanh(stats_table_nps.between_person_r);
d_nps_mean = d_nps(10,1);
d_nps_ste = ste(d_nps(1:9,1));

subplot(2,1,1);
clear han*
bar(d_npspos_mean,'y');
hold on
errorbar(d_npspos_mean, d_npspos_ste, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_nps_mean+d_nps_ste,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_nps_mean,'LineWidth',1.5);
hold on;
han5 = yline(d_nps_mean-d_nps_ste,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_posnames),'xticklabels', nps_posnames, 'FontSize', 18);
xtickangle(45);
ylim([-0.5 1]);
ylabel('Mean ffect size (z)'); 
title('Mean effect sizes of NPS positive local regions');
legend off;

%%
subplot(2,1,2);
clear han*
bar(d_npsneg_mean,'b');
hold on
errorbar(d_npsneg_mean, d_npsneg_ste, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_nps_mean+d_nps_ste,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_nps_mean,'LineWidth',1.5);
hold on;
han5 = yline(d_nps_mean-d_nps_ste,'--','LineWidth',1);
set(gca,'xtick',1:length(nps_negnames), 'xticklabels', nps_negnames, 'FontSize', 18);
xtickangle(45);
ylim([-0.5 1]);
ylabel('Mean ffect size (z)'); 
title('Mean effect sizes of NPS negative local regions');
legend off;

set(gcf,'Position',[100 100 1000 1000])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);


%% SIIPS correlation with PAIN between subjects
clearvars -except SIIPScorr PAIN local_SIIPS_all_events_by_region siips_posnames siips_negnames figsavedir;

figname = 'SIIPS local regions correlation with PAIN between subjects';
X = PAIN;
for p = 1:length(siips_posnames)
    Y = local_SIIPS_all_events_by_region.siips_posnames{p};
    stats_table_siipspos = plugin_regress_within_subject(X, Y, figname);
    d_siipspos = atanh(stats_table_siipspos.between_person_r);
    d_siipspos_mean(p,1) = d_siipspos(10,1);
    d_siipspos_ste(p,1) = ste(d_siipspos(1:9,1));
end
for p = 1:length(siips_negnames)
    Y = local_SIIPS_all_events_by_region.siips_negnames{p};
    stats_table_siipsneg = plugin_regress_within_subject(X, Y, figname);
    d_siipsneg = atanh(stats_table_siipsneg.between_person_r);
    d_siipsneg_mean(p,1) = d_siipsneg(10,1);
    d_siipsneg_ste(p,1) = ste(d_siipsneg(1:9,1));
end
create_figure(figname,2,1)

Y = SIIPScorr;
stats_table_siips = plugin_regress_within_subject(X, Y, figname);
d_siips = atanh(stats_table_siips.between_person_r);
d_siips_mean = d_siips(10,1);
d_siips_ste = ste(d_siips(1:9,1));

subplot(2,1,1);
clear han*
bar(d_siipspos_mean,'y');
hold on
errorbar(d_siipspos_mean, d_siipspos_ste, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_siips_mean+d_siips_ste,'--','SIIPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_siips_mean,'LineWidth',1.5);
hold on;
han5 = yline(d_siips_mean-d_siips_ste,'--','LineWidth',1);
set(gca, 'xtick',1:length(siips_posnames),'xticklabels', siips_posnames, 'FontSize', 18);
xtickangle(45);
ylim([-0.5 1]);
ylabel('Mean ffect size (z)'); 
title('Mean effect sizes of SIIPS positive local regions');
legend off;

%%
subplot(2,1,2);
clear han*
bar(d_siipsneg_mean,'b');
hold on
errorbar(d_siipsneg_mean, d_siipsneg_ste, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_siips_mean+d_siips_ste,'--','SIIPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(d_siips_mean,'LineWidth',1.5);
hold on;
han5 = yline(d_siips_mean-d_siips_ste,'--','LineWidth',1);
set(gca,'xtick',1:length(siips_negnames), 'xticklabels', siips_negnames, 'FontSize', 18);
xtickangle(45);
ylim([-0.5 1]);
ylabel('Mean ffect size (z)'); 
title('Mean effect sizes of SIIPS negative local regions');
legend off;

set(gcf,'Position',[100 100 1000 1000])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
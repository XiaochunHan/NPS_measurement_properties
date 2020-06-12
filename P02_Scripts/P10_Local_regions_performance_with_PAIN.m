clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
cd(Path);
load('metadata_all_valid.mat');
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
SIIPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'siips_corr');
PAIN = single_trial_retrieve_data_all_studies(all_data_selected, 'rating');
single_trial_get_d_all_local_NPS_regions;
single_trial_get_d_all_local_SIIPS_regions;
clearvars -except NPScorr SIIPScorr PAIN local_NPS_all_events_by_region local_SIIPS_all_events_by_region NPScorr_d_by_study nps_posnames nps_negnames siips_posnames siips_negnames figsavedir;
%% NPS correlation with TEMP
dfun = @(x) mean(x) ./ std(x);

figname = 'NPS local regions correlation with PAIN';
X = PAIN;
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    [~,~,within_r_pos] = plugin_regress_within_subject(X, Y, figname);
    d_pos = cellfun(dfun, within_r_pos, 'UniformOutput', false);
    d_pos = cat(1, d_pos{:});
    d_npspos_corr(p,1) = mean(d_pos);
    ste_npspos_corr(p,1) = ste(d_pos);
end
for n = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{n};
    [~,~,within_r_neg] = plugin_regress_within_subject(X, Y, figname);
    d_neg = cellfun(dfun, within_r_neg, 'UniformOutput', false);
    d_neg = cat(1, d_neg{:});
    d_npsneg_corr(n,1) = mean(d_neg);
    ste_npsneg_corr(n,1) = ste(d_neg);
end
create_figure(figname,2,1)

Y = NPScorr;
[~,~,within_r] = plugin_regress_within_subject(X, Y, figname);
d_nps_corr = cellfun(dfun, within_r, 'UniformOutput', false);
d_nps_corr = cat(1, d_nps_corr{:});
mean_d_nps_corr = mean(d_nps_corr);
ste_d_nps_corr = ste(d_nps_corr);

subplot(2,1,1);
clear han*
bar(d_npspos_corr,'y');
hold on
errorbar(d_npspos_corr, ste_npspos_corr, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(mean_d_nps_corr+ste_d_nps_corr,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(mean_d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(mean_d_nps_corr-ste_d_nps_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_posnames),'xticklabels', nps_posnames, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS positive local regions');
legend off;

%%
subplot(2,1,2);
clear han*
bar(d_npsneg_corr,'b');
hold on
errorbar(d_npsneg_corr, ste_npsneg_corr, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(mean_d_nps_corr+ste_d_nps_corr,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(mean_d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(mean_d_nps_corr-ste_d_nps_corr,'--','LineWidth',1);
set(gca,'xtick',1:length(nps_negnames), 'xticklabels', nps_negnames, 'FontSize', 18);
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


%% SIIPS correlation with PAIN
clearvars -except SIIPScorr PAIN local_SIIPS_all_events_by_region siips_posnames siips_negnames figsavedir dfun;

figname = 'SIIPS local regions correlation with PAIN';
X = PAIN;
for p = 1:length(siips_posnames)
    Y = local_SIIPS_all_events_by_region.siips_posnames{p};
    [~,~,within_r_pos] = plugin_regress_within_subject(X, Y, figname);
    d_pos = cellfun(dfun, within_r_pos, 'UniformOutput', false);
    d_pos = cat(1, d_pos{:});
    d_siipspos_corr(p,1) = mean(d_pos);
    ste_siipspos_corr(p,1) = ste(d_pos);
end
for n = 1:length(siips_negnames)
    Y = local_SIIPS_all_events_by_region.siips_negnames{n};
    [~,~,within_r_neg] = plugin_regress_within_subject(X, Y, figname);
    d_neg = cellfun(dfun, within_r_neg, 'UniformOutput', false);
    d_neg = cat(1, d_neg{:});
    d_siipsneg_corr(n,1) = mean(d_neg);
    ste_siipsneg_corr(n,1) = ste(d_neg);
end
create_figure(figname,2,1)

Y = SIIPScorr;
[~,~,within_r] = plugin_regress_within_subject(X, Y, figname);
d_siips_corr = cellfun(dfun, within_r, 'UniformOutput', false);
d_siips_corr = cat(1, d_siips_corr{:});
mean_d_siips_corr = mean(d_siips_corr);
ste_d_siips_corr = ste(d_siips_corr);

subplot(2,1,1);
clear han*
bar(d_siipspos_corr,'y');
hold on
errorbar(d_siipspos_corr, ste_siipspos_corr, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(mean_d_siips_corr+ste_d_siips_corr,'--','SIIPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(mean_d_siips_corr,'LineWidth',1.5);
hold on;
han5 = yline(mean_d_siips_corr-ste_d_siips_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(siips_posnames),'xticklabels', siips_posnames, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of SIIPS positive local regions');
legend off;

%%
subplot(2,1,2);
clear han*
bar(d_siipsneg_corr,'b');
hold on
errorbar(d_siipsneg_corr, ste_siipsneg_corr, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(mean_d_siips_corr+ste_d_siips_corr,'--','NPS correlation effect size','LineWidth',1);
hold on;
han4 = yline(mean_d_siips_corr,'LineWidth',1.5);
hold on;
han5 = yline(mean_d_siips_corr-ste_d_siips_corr,'--','LineWidth',1);
set(gca,'xtick',1:length(siips_negnames), 'xticklabels', siips_negnames, 'FontSize', 18);
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
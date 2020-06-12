clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
cd(Path);
load('metadata_all_valid.mat');
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
SIIPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'siips_corr');
single_trial_get_d_all_local_NPS_regions;
single_trial_get_d_all_local_SIIPS_regions;
clearvars -except NPScorr SIIPScorr local_NPS_all_events_by_region local_SIIPS_all_events_by_region nps_posnames nps_negnames siips_posnames siips_negnames figsavedir;

%%
for i = 1:NPScorr.nstudies
    
    reliab_npscorr(i,1) = reliability_split_half(NPScorr.event_by_study{i});
    reliab_siipscorr(i,1) = reliability_split_half(SIIPScorr.event_by_study{i});
    for p = 1:length(nps_posnames)
        reliab_npspos(i,p) = reliability_split_half(local_NPS_all_events_by_region.nps_posnames{p}.event_by_study{i});
    end
    for n = 1:length(nps_negnames)
        reliab_npsneg(i,n) = reliability_split_half(local_NPS_all_events_by_region.nps_negnames{n}.event_by_study{i});
    end
    for p = 1:length(siips_posnames)
        reliab_siipspos(i,p) = reliability_split_half(local_SIIPS_all_events_by_region.siips_posnames{p}.event_by_study{i});
    end
    for n = 1:length(siips_negnames)
        reliab_siipsneg(i,n) = reliability_split_half(local_SIIPS_all_events_by_region.siips_negnames{n}.event_by_study{i});
    end
    
end

%%
figname = 'NPS local regions reliability';

create_figure(figname,2,1)

subplot(2,1,1);
clear han
mean_r_pos = mean(reliab_npspos);
se_d_pos = ste(reliab_npspos);
han = bar(mean_r_pos, 'y');
hold on
han2 = errorbar(mean_r_pos, se_d_pos, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
ylim([0 1]);
ylabel('Reliability Spearman-brown'); 
title('Split-half Reliability of NPS local regions');
% axis tight
hold on;
han3 = yline(mean(reliab_npscorr)+std(reliab_npscorr)/3,'--','Reliability of NPS correlation','LineWidth',1);
hold on;
han4 = yline(mean(reliab_npscorr),'LineWidth',1.5);
hold on;
han5 = yline(mean(reliab_npscorr)-std(reliab_npscorr)/3,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_posnames),'xticklabels', nps_posnames, 'FontSize', 18);
xtickangle(45);
legend off;

subplot(2,1,2);
clear han
mean_r_neg = mean(reliab_npsneg);
se_d_neg = ste(reliab_npsneg);
han = bar(mean_r_neg, 'b');
hold on
han2 = errorbar(mean_r_neg, se_d_neg, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
ylim([0 1]);
ylabel('Reliability Spearman-brown'); 
title('Split-half Reliability of NPS local regions');
% axis tight
hold on;
han3 = yline(mean(reliab_npscorr)+std(reliab_npscorr)/3,'--','Reliability of NPS correlation','LineWidth',1);
hold on;
han4 = yline(mean(reliab_npscorr),'LineWidth',1.5);
hold on;
han5 = yline(mean(reliab_npscorr)-std(reliab_npscorr)/3,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_negnames),'xticklabels', nps_negnames, 'FontSize', 18);
xtickangle(45);
legend off;

set(gcf,'Position',[100 100 1000 1000])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);

%%
figname = 'SIIPS local regions reliability';

create_figure(figname,2,1)

subplot(2,1,1);
clear han
mean_r_pos = mean(reliab_siipspos);
se_d_pos = ste(reliab_siipspos);
han = bar(mean_r_pos, 'y');
hold on
han2 = errorbar(mean_r_pos, se_d_pos, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
ylim([0 1]);
ylabel('Reliability Spearman-brown'); 
title('Split-half Reliability of SIIPS local regions');
% axis tight
hold on;
han3 = yline(mean(reliab_siipscorr)+std(reliab_siipscorr)/3,'--','Reliability of SIIPS correlation','LineWidth',1);
hold on;
han4 = yline(mean(reliab_siipscorr),'LineWidth',1.5);
hold on;
han5 = yline(mean(reliab_siipscorr)-std(reliab_siipscorr)/3,'--','LineWidth',1);
set(gca, 'xtick',1:length(siips_posnames),'xticklabels', siips_posnames, 'FontSize', 18);
xtickangle(45);
legend off;

subplot(2,1,2);
clear han
mean_r_neg = mean(reliab_siipsneg);
se_d_neg = ste(reliab_siipsneg);
han = bar(mean_r_neg, 'b');
hold on
han2 = errorbar(mean_r_neg, se_d_neg, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
ylim([0 1]);
ylabel('Reliability Spearman-brown'); 
title('Split-half Reliability of SIIPS local regions');
% axis tight
hold on;
han3 = yline(mean(reliab_siipscorr)+std(reliab_siipscorr)/3,'--','Reliability of SIIPS correlation','LineWidth',1);
hold on;
han4 = yline(mean(reliab_siipscorr),'LineWidth',1.5);
hold on;
han5 = yline(mean(reliab_siipscorr)-std(reliab_siipscorr)/3,'--','LineWidth',1);
set(gca, 'xtick',1:length(siips_negnames),'xticklabels', siips_negnames, 'FontSize', 18);
xtickangle(45);
legend off;

set(gcf,'Position',[100 100 1000 1000])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
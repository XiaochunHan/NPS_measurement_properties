clear;clc;close all;
Path = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/Figure';
studycolors = seaborn_colors(9)';
cd(Path);
load('metadata_all_NPS_complete.mat');
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
TEMP = single_trial_retrieve_data_all_studies(all_data, 'T');
single_trial_get_d_all_local_NPS_regions;
variableNames = {'nps','pos_nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                 'neg_nps','neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_all = [cat(1,NPS_d_by_study{:}),cat(2,nps_d_by_study_region_pos{:}),cat(2,nps_d_by_study_region_neg{:})];
table_all = array2table(d_all, 'VariableNames', variableNames);
cd('../behavior')
writetable(table_all, 'NPS_local_mean_response_effect_size.csv');
%% Pain signature mean response

figname = 'NPS local regions Effect size stim vs. baseline';

create_figure(figname)

d_nps = mean(cat(1,NPS_d_by_study{:}));
ste_nps = ste(cat(1,NPS_d_by_study{:}));

clear han*
npspos_mean_d_all = cellfun(@mean, nps_d_by_study_region_pos, 'UniformOutput', false);
npspos_se_d_all = cellfun(@ste, nps_d_by_study_region_pos, 'UniformOutput', false);
npsneg_mean_d_all = cellfun(@mean, nps_d_by_study_region_neg, 'UniformOutput', false);
npsneg_se_d_all = cellfun(@ste, nps_d_by_study_region_neg, 'UniformOutput', false);

nps_mean_d_all = [cell2mat(npspos_mean_d_all),cell2mat(npsneg_mean_d_all)];
nps_se_d_all = [cell2mat(npspos_se_d_all),cell2mat(npsneg_se_d_all)];

for i = 1:length(nps_mean_d_all)
    
    if i <= 9  
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [203 123 190]./255);
    else
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [143 177 207]./255);
    end

end
hold on
errorbar(nps_mean_d_all, nps_se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_nps_corr+ste_nps_corr,'--','NPScorr effect size','LineWidth',1);
hold on;
han4 = yline(d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(d_nps_corr-ste_nps_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_names), 'xticklabels', nps_names, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean effect size (d)'); 
title('NPS local regions [Pain minus Baseline]');
legend off;

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);

%% NPS correlation with TEMP
clearvars -except NPS PAIN TEMP local_NPS_all_events_by_region nps_posnames nps_negnames nps_names figsavedir;
dfun = @(x) mean(x) ./ std(x);

figname = 'NPS local regions correlation with Temperature';
X = TEMP;
d_pos_all = [];
d_neg_all = [];
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    [~,~,within_r_pos] = plugin_regress_within_subject(X, Y, figname);
    d_pos = cellfun(dfun, within_r_pos, 'UniformOutput', false);
    d_pos = cat(1, d_pos{:});
    d_pos_all=[d_pos_all,d_pos];
    d_npspos(p,1) = mean(d_pos);
    ste_npspos(p,1) = ste(d_pos);
end
for n = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{n};
    [~,~,within_r_neg] = plugin_regress_within_subject(X, Y, figname);
    d_neg = cellfun(dfun, within_r_neg, 'UniformOutput', false);
    d_neg = cat(1, d_neg{:});
    d_neg_all=[d_neg_all,d_neg];
    d_npsneg(n,1) = mean(d_neg);
    ste_npsneg(n,1) = ste(d_neg);
end

Y = NPS;
[~,~,within_r] = plugin_regress_within_subject(X, Y, figname);
d_nps = cellfun(dfun, within_r, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});

variableNames = {'nps','pos_nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                 'neg_nps','neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_temp_all = [d_nps, d_pos_all, d_neg_all];
table_all = array2table(d_temp_all, 'VariableNames', variableNames);
cd('../behavior')
writetable(table_all, 'NPS_local_within_temp_effect_size.csv');

%%
mean_d_nps = mean(d_nps);
ste_d_nps = ste(d_nps);

nps_mean_d_all = [d_npspos',d_npsneg'];
nps_se_d_all = [ste_npspos',ste_npsneg'];

create_figure(figname)

clear han*
for i = 1:length(nps_mean_d_all)
    
    if i <= 9  
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [203 123 190]./255);
    else
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [143 177 207]./255);
    end

end

hold on
errorbar(nps_mean_d_all, nps_se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(mean_d_nps_corr+ste_d_nps_corr,'--','NPScorr effect size','LineWidth',1);
hold on;
han4 = yline(mean_d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(mean_d_nps_corr-ste_d_nps_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_names),'xticklabels', nps_names, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean effect size (d)'); 
title('NPS local regions correlation with Temperature');
legend off;

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);

%% NPS correlation with PAIN
clearvars -except NPS PAIN local_NPS_all_events_by_region nps_posnames nps_negnames nps_names figsavedir;
dfun = @(x) mean(x) ./ std(x);

figname = 'NPS local regions correlation with Pain';
X = PAIN;
d_pos_all = [];
d_neg_all = [];
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    [~,~,within_r_pos] = plugin_regress_within_subject(X, Y, figname);
    d_pos = cellfun(dfun, within_r_pos, 'UniformOutput', false);
    d_pos = cat(1, d_pos{:});
    d_pos_all = [d_pos_all,d_pos];
    d_npspos_corr(p,1) = mean(d_pos);
    ste_npspos_corr(p,1) = ste(d_pos);
end
for n = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{n};
    [~,~,within_r_neg] = plugin_regress_within_subject(X, Y, figname);
    d_neg = cellfun(dfun, within_r_neg, 'UniformOutput', false);
    d_neg = cat(1, d_neg{:});
    d_neg_all = [d_neg_all,d_neg];
    d_npsneg(n,1) = mean(d_neg);
    ste_npsneg(n,1) = ste(d_neg);
end

Y = NPS;
[~,~,within_r] = plugin_regress_within_subject(X, Y, figname);
d_nps = cellfun(dfun, within_r, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});

variableNames = {'nps','pos_nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                 'neg_nps','neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_pain_all = [d_nps, d_pos_all, d_neg_all];
table_all = array2table(d_pain_all, 'VariableNames', variableNames);
cd('../behavior')
writetable(table_all, 'NPS_local_within_pain_effect_size.csv');

%%
mean_d_nps = mean(d_nps);
ste_d_nps = ste(d_nps);

nps_mean_d_all = [d_npspos',d_npsneg'];
nps_se_d_all = [ste_npspos',ste_npsneg'];

create_figure(figname)

clear han*
for i = 1:length(nps_mean_d_all)
    
    if i <= 9  
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [203 123 190]./255);
    else
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [143 177 207]./255);
    end

end

hold on
errorbar(nps_mean_d_all, nps_se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(mean_d_nps_corr+ste_d_nps_corr,'--','NPScorr effect size','LineWidth',1);
hold on;
han4 = yline(mean_d_nps_corr,'LineWidth',1.5);
hold on;
han5 = yline(mean_d_nps_corr-ste_d_nps_corr,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_names),'xticklabels', nps_names, 'FontSize', 18);
xtickangle(45);
ylim([-1 3]);
ylabel('Mean effect size (d)'); 
title('NPS local regions correlation with Pain rating');
legend off;

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
%% NPS correlation with Pain between subject
clearvars -except NPS PAIN local_NPS_all_events_by_region nps_posnames nps_negnames nps_names figsavedir;

figname = 'NPS local regions correlation with PAIN between subjects';
r2d = @(r) 2*r ./ (1 - r.^2).^.5;
X = PAIN;
d_pos_all = [];
d_neg_all = [];
for p = 1:length(nps_posnames)
    Y = local_NPS_all_events_by_region.nps_posnames{p};
    stats_table_npspos = plugin_regress_within_subject(X, Y, figname);
    d_npspos = r2d(stats_table_npspos.between_person_r);
    d_pos_all = [d_pos_all,d_npspos];
    d_npspos_mean(p,1) = d_npspos(10,1);
    d_npspos_ste(p,1) = ste(d_npspos(1:9,1));
end
for p = 1:length(nps_negnames)
    Y = local_NPS_all_events_by_region.nps_negnames{p};
    stats_table_npsneg = plugin_regress_within_subject(X, Y, figname);
    d_npsneg = r2d(stats_table_npsneg.between_person_r(1:9));
    d_neg_all = [d_neg_all,d_npsneg];
    d_npsneg_mean(p,1) = d_npsneg(10,1);
    d_npsneg_ste(p,1) = ste(d_npsneg(1:9,1));
end

Y = NPS;
stats_table_nps = plugin_regress_within_subject(X, Y, figname);
d_nps = r2d(stats_table_nps.between_person_r(1:9));

variableNames = {'nps','pos_nps','pos_vermis','pos_rIns','pos_rV1','pos_rThal','pos_lIns','pos_rdpIns','pos_rS2','pos_dACC',...
                 'neg_nps','neg_rLOC','neg_lLOC','neg_rpLOC','neg_pgACC','neg_lSTS','neg_rIPL','neg_PCC'};
d_pain_all = [d_nps, d_pos_all, d_neg_all];
table_all = array2table(d_pain_all, 'VariableNames', variableNames);
cd('../behavior')
writetable(table_all, 'NPS_local_between_pain_effect_size.csv');

%%
d_nps_mean = d_nps(10,1);
d_nps_ste = ste(d_nps(1:9,1));

nps_mean_d_all = [d_npspos_mean',d_npsneg_mean'];
nps_se_d_all = [d_npspos_ste',d_npsneg_ste'];

create_figure(figname)
clear han*
for i = 1:length(nps_mean_d_all)
    
    if i <= 9  
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [203 123 190]./255);
    else
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [143 177 207]./255);
    end

end

hold on
errorbar(nps_mean_d_all, nps_se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
hold on;
han3 = yline(d_nps_mean+d_nps_ste,'--','NPScorr effect size','LineWidth',1);
hold on;
han4 = yline(d_nps_mean,'LineWidth',1.5);
hold on;
han5 = yline(d_nps_mean-d_nps_ste,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_names),'xticklabels', nps_names, 'FontSize', 18);
xtickangle(45);
ylim([-0.5 0.5]);
ylabel('Mean effect size (z)'); 
title('NPS local regions between-sub correlation with Pain');
legend off;

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);

%%
clearvars -except NPScorr local_NPS_all_events_by_region nps_posnames nps_negnames nps_names figsavedir;

for i = 1:NPScorr.nstudies
    
    reliab_npscorr(i,1) = reliability_split_half(NPScorr.event_by_study{i});
    for p = 1:length(nps_posnames)
        reliab_npspos(i,p) = reliability_split_half(local_NPS_all_events_by_region.nps_posnames{p}.event_by_study{i});
    end
    for n = 1:length(nps_negnames)
        reliab_npsneg(i,n) = reliability_split_half(local_NPS_all_events_by_region.nps_negnames{n}.event_by_study{i});
    end
    
end

figname = 'NPS local regions reliability';

create_figure(figname)

clear han
mean_r_pos = mean(reliab_npspos);
se_d_pos = ste(reliab_npspos);
mean_r_neg = mean(reliab_npsneg);
se_d_neg = ste(reliab_npsneg);

nps_mean_d_all = [mean_r_pos,mean_r_neg];
nps_se_d_all = [se_d_pos,se_d_neg];

clear han*
for i = 1:length(nps_mean_d_all)
    
    if i <= 9  
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [203 123 190]./255);
    else
       han(i) = bar(i, nps_mean_d_all(i), 'FaceColor', [143 177 207]./255);
    end

end
hold on
han2 = errorbar(nps_mean_d_all, nps_se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
ylim([0 1]);
ylabel('Reliability Spearman-brown'); 
title('Split-half Reliability of NPS local regions');
% axis tight
hold on;
han3 = yline(mean(reliab_npscorr)+std(reliab_npscorr)/3,'--','Reliability of NPScorr','LineWidth',1);
hold on;
han4 = yline(mean(reliab_npscorr),'LineWidth',1.5);
hold on;
han5 = yline(mean(reliab_npscorr)-std(reliab_npscorr)/3,'--','LineWidth',1);
set(gca, 'xtick',1:length(nps_names),'xticklabels', nps_names, 'FontSize', 18);
xtickangle(45);
legend off;

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
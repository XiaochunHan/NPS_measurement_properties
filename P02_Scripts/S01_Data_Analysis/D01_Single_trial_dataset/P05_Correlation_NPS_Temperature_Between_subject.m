clear;clc;close all;
Path = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/Figure';
studycolors = seaborn_colors(8)';
cd(Path);
load('metadata_all_NPS_complete_exclude_nsf.mat');
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
TEMP = single_trial_retrieve_data_all_studies(all_data, 'T');
%%
nps_mean = cat(1,NPS.subject_means_by_study_rescale{:});
temp_mean = cat(1,TEMP.subject_means_by_study{:});
for s = 1:length(NPS.studynames)
    names{s}((1:length(NPS.subject_means_by_study_rescale{s})),1) = deal(NPS.studynames(s,1));
end
names = cat(1,names{:});
mean_data = table(names,nps_mean,temp_mean, 'VariableNames',{'study','nps','temp'}); 
cd('../behavior')
writetable(mean_data, 'NPS_between_r_temp_exclude_nsf.csv');
%%
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
NPScosine = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_cosine');
%% Plot relationships between pain and NPS
clear within_r* b_*;

X = TEMP;
Y = NPS;
xname = 'Temp';
yname = 'NPSdot';
figname = 'Temp by NPS by study within subject';

[stats_table_nps, ~, within_r_nps] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain between-person correlation with NPSdot';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and NPScorr

X = PAIN;
Y = NPScorr;
xname = 'Pain';
yname = 'NPScorr';
figname = 'Pain by NPScorr by study within subject';

[stats_table_nps_corr, ~, within_r_nps_corr] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain between-person correlation with NPScorr';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and NPScosine

X = PAIN;
Y = NPScosine;
xname = 'Pain';
yname = 'NPScos';
figname = 'Pain by NPScosine by study within subject';

[stats_table_nps_cos, ~, within_r_nps_cos] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain between-person correlation with NPScos';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS correlation with Pain between subject';

create_figure(figname,2,1)

z_nps = atanh(stats_table_nps.between_person_r);
z_nps_corr = atanh(stats_table_nps_corr.between_person_r);
z_nps_cos = atanh(stats_table_nps_cos.between_person_r);

subplot(2,1,2);
clear han
mean_d_all = [z_nps(10,1),z_nps_corr(10,1),z_nps_cos(10,1)];
se_d_all = [ste(z_nps(1:9,1)),ste(z_nps_corr(1:9,1)),ste(z_nps_cos(1:9,1))];
indexcolors = {[189/255 196/255 153/255],[231/255 209/255 146/255],[212/255 132/255 111/255]};
for i = 1:3
      
    han(i) = bar(i, mean_d_all(i), 'FaceColor', indexcolors{i});

end
hold on
errorbar(mean_d_all, se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
set(gca, 'FontSize', 18, 'XTick', 1:3);
xticklabels({'dot product','correlation','cosine'})
ylim([-0.5 1.5]);
ylabel('Mean effect size (z)'); 
title('Mean effect sizes of NPS');

subplot(2,1,1);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, z_nps_corr(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, z_nps_corr(1:9,1), 1 ./ sqrt(NPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study');ylim([-0.5 1.5]);
ylabel('Effect size (z)'); 
title('Effect size by study NPScorr');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(z_nps_corr(1:9,1)), min(z_nps_corr(1:9,1)), max(z_nps_corr(1:9,1)));

set(gcf,'Position',[100 100 550 700])

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
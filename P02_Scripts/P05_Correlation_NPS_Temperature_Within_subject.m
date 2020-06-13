clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
studycolors = seaborn_colors(9)';
cd(Path);
load('metadata_all_valid.mat');
NPS = single_trial_retrieve_data_all_studies(all_data_selected, 'nps');
NPScorr = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_corr');
NPScosine = single_trial_retrieve_data_all_studies(all_data_selected, 'nps_cosine');
TEMP = single_trial_retrieve_data_all_studies(all_data_selected, 'T');
%% Plot relationships between temperature and NPS

X = TEMP;
Y = NPS;
xname = 'Temperature';
yname = 'NPS';
figname = 'Temperature by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_nps] = plugin_regress_within_subject(X, Y, figname);

figname = 'Temperature within-person correlation with NPS violins';
NPS_main_effect = plugin_plot_violins_withinperson_by_study(within_r_nps, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS_corr

X = TEMP;
Y = NPScorr;
xname = 'Temperature';
yname = 'NPScorr';
figname = 'Temperature by NPScorr by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_nps_corr] = plugin_regress_within_subject(X, Y, figname);

figname = 'Temperature within-person correlation with NPScorr violins';
NPScorr_main_effect = plugin_plot_violins_withinperson_by_study(within_r_nps_corr, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS_cosine

X = TEMP;
Y = NPScosine;
xname = 'Temperature';
yname = 'NPS cosine';
figname = 'TEMP by NPS cosine by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_nps_cos] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPScosine violins';
NPScosine_main_effect = plugin_plot_violins_withinperson_by_study(within_r_nps_cos, X.studynames, figname, figsavedir, studycolors);

%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS correlation with Temperature';

create_figure(figname,1,2)

dfun = @(x) mean(x) ./ std(x);
d_nps = cellfun(dfun, within_r_nps_corr, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});
subplot(1,2,2);
clear han
mean_d_all = [NPS_main_effect.d(10,1),NPScorr_main_effect.d(10,1),NPScosine_main_effect.d(10,1)];
se_d_all = [ste(NPS_main_effect.d(1:9,1)),ste(NPScorr_main_effect.d(1:9,1)),ste(NPScosine_main_effect.d(1:9,1))];
indexcolors = {[189/255 196/255 153/255],[231/255 209/255 146/255],[212/255 132/255 111/255]};
for i = 1:3
      
    han(i) = bar(i, mean_d_all(i), 'FaceColor', indexcolors{i});

end
hold on
errorbar(mean_d_all, se_d_all, 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
set(gca, 'FontSize', 18, 'XTick', 1:3);
xticklabels({'dot product','correlation','cosine'})
ylim([0 4])
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS');
% legend('dot product','correlation','cosine');
% axis tight

subplot(1,2,1);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_nps(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_nps, 1 ./ sqrt(NPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4]);
ylabel('Effect size (d)'); 
title('Effect size by study NPScorr');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_nps), min(d_nps), max(d_nps));

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
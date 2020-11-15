clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/Figure';
studycolors = seaborn_colors(9)';
cd(Path);
load('metadata_all_NPS_complete.mat');
NPS = single_trial_retrieve_data_all_studies(all_data, 'nps');
rescale = cat(1,NPS.subject_means_by_study_rescale{:});
for s = 1:length(NPS.studynames)
    names{s}((1:length(NPS.subject_means_by_study_rescale{s})),1) = deal(NPS.studynames(s,1));
end
names = cat(1,names{:});
mean_data = table(names,rescale, 'VariableNames',{'study','rescale_mean'}); 
cd('../behavior')
writetable(mean_data, 'NPS_mean_response.csv');
%%
NPScorr = single_trial_retrieve_data_all_studies(all_data, 'nps_corr');
NPScosine = single_trial_retrieve_data_all_studies(all_data, 'nps_cosine');
%%
figname = 'NPS vs. baseline by study rescale by mad';
INPUT_STRUCT = NPS;
NPS_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%%
figname = 'NPScorr Pain minus Baseline by study';
INPUT_STRUCT = NPScorr;
NPScorr_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%%
figname = 'NPS cosine stim vs. baseline by study';
INPUT_STRUCT = NPScosine;
NPScosine_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS Effect size stim vs. baseline by study';

create_figure(figname,1,2)

dfun = @(x) mean(x) ./ std(x);
d_nps = cellfun(dfun, NPScorr.subject_means_by_study, 'UniformOutput', false);
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
ylabel('Mean effect size (d)'); 
title('Mean effect sizes of NPS');
%%
subplot(1,2,1);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_nps(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
% ehan = errorbar(1:nstudies, d_nps, 1 ./ sqrt(NPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

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
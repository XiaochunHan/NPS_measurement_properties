%%
figname = 'NPS vs. baseline by study';
INPUT_STRUCT = NPS;
NPS_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%%
figname = 'NPS corr stim vs. baseline by study';
INPUT_STRUCT = NPScorr;
NPScorr_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%%
figname = 'NPS cosine stim vs. baseline by study';
INPUT_STRUCT = NPScosine;
NPScosine_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);
%%
figname = 'SIIPS vs. baseline by study';
INPUT_STRUCT = SIIPS;
SIIPS_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%%
figname = 'SIIPS corr stim vs. baseline by study';
INPUT_STRUCT = SIIPScorr;
SIIPScorr_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);

%%
figname = 'SIIPS cosine stim vs. baseline by study';
INPUT_STRUCT = SIIPScosine;
SIIPScosine_main_effect = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors);
close all;
%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS and SIIPS Effect size stim vs. baseline by study';

create_figure(figname,1,3)

dfun = @(x) mean(x) ./ std(x);
d_nps = cellfun(dfun, NPScorr.subject_means_by_study, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});
d_siips = cellfun(dfun, SIIPScorr.subject_means_by_study, 'UniformOutput', false);
d_siips = cat(1, d_siips{:});
subplot(1,3,1);
clear han
mean_d_all = [NPS_main_effect.d(10,1),NPScorr_main_effect.d(10,1),NPScosine_main_effect.d(10,1);SIIPS_main_effect.d(10,1),SIIPScorr_main_effect.d(10,1),SIIPScosine_main_effect.d(10,1)];
se_d_all = [std(NPS_main_effect.d(1:9,1)),std(NPScorr_main_effect.d(1:9,1)),std(NPScosine_main_effect.d(1:9,1));std(SIIPS_main_effect.d(1:9,1)),std(SIIPScorr_main_effect.d(1:9,1)),std(SIIPScosine_main_effect.d(1:9,1))]./3;
bar(mean_d_all, 'grouped');
hold on
% Find the number of groups and the number of bars in each group
ngroups = size(mean_d_all, 1);
nbars = size(mean_d_all, 2);
% Calculate the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, mean_d_all(:,i), se_d_all(:,i), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
end
set(gca, 'FontSize', 18);
xticklabels({'NPS','','SIIPS'})
ylim([0 4])
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS and SIIPS');
legend('dot product','correlation','cosine');
% axis tight
%%
subplot(1,3,2);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_nps(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_nps, 1 ./ sqrt(NPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4]);
ylabel('Effect size (d)'); 
title('Effect size by study NPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_nps), min(d_nps), max(d_nps));

subplot(1,3,3);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_siips(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_siips, 1 ./ sqrt(SIIPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4]);
ylabel('Effect size (d)'); 
title('Effect size by study SIIPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_siips), min(d_siips), max(d_siips));

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';
studycolors = seaborn_colors(9)';
cd(Path);
load('metadata_all_valid.mat');
%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS Effect size stim vs. baseline by study';

create_figure(figname, 1, 2)

dfun = @(x) mean(x) ./ std(x);
d = cellfun(dfun, NPS.subject_means_by_study, 'UniformOutput', false);
d = cat(1, d{:});

clear han
for i = 1:nstudies
      
    han(i) = bar(i, d(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d, 1 ./ sqrt(NPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylabel('Effect size (d)'); 
title('Effect size by study NPS');
axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d), min(d), max(d));

% Add dark bars for the largest individual local-region effect
single_trial_get_d_all_local_NPS_regions;

% This returns:
% local_NPS_by_region_pos: Cell 1 x regions, each is vector of NPS subject
% means [subjects x 1] for local pattern
% local_NPS_by_region_neg
%
% NPS_subject_means: vector of NPS subject means [subjects x 1] for whole NPS

% d_by_study_region_pos: Cell 1 x regions, each is vector of NPS cohen's d [studies x 1] for local pattern
% NPS_d_by_study: Same, for overall NPS
%
% local_NPS_all_events_by_region = all single-trial events

% Local regions
subplot(1, 2, 2)

% stack subregions, [regions x studies]
X = [cat(1, NPS_d_by_study{:}) cat(2, d_by_study_region_pos{:}) cat(2, d_by_study_region_neg{:})]';
imagesc(X); 
colorbar
set(gca, 'YDir', 'reverse', 'XTick', 1:length(uniq_study_id), 'YTick', 1:size(X, 1), 'YTickLabel', [{'NPS'} posnames negnames])

drawnow, snapnow

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);

%%
subplot(1, 3, 2)
d = cellfun(dfun, NPScorr.subject_means_by_study, 'UniformOutput', false);
d = cat(1, d{:});

clear han
for i = 1:nstudies
      
    han(i) = bar(i, d(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d, 1 ./ sqrt(NPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylabel('Effect size (d)'); 
title('Effect size by study NPScorr');
axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d), min(d), max(d));
%%
subplot(1, 3, 3)
d = cellfun(dfun, NPScosine.subject_means_by_study, 'UniformOutput', false);
d = cat(1, d{:});

clear han
for i = 1:nstudies
      
    han(i) = bar(i, d(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d, 1 ./ sqrt(NPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylabel('Effect size (d)'); 
title('Effect size by study NPScosine');
axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d), min(d), max(d));

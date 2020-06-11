function dtable = plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)
%
% Create a violin plot by study with all individual subjects
% plugin_plot_violins_by_study(INPUT_STRUCT, figname)
% 
% Example:
% figname = 'NPS stim vs. baseline by study';
% INPUT_STRUCT = NPS;
% plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)


% Display helper functions
% ------------------------------------------------------------------

dashes = '----------------------------------------------';
printstr = @(dashes) disp(dashes);
printhdr = @(str) fprintf('%s\n%s\n%s\n', dashes, str, dashes);

% Useful variables
% ------------------------------------------------------------------
nstudies = INPUT_STRUCT.nstudies;
studynames = INPUT_STRUCT.studynames;


% Figure
% ------------------------------------------------------------------

printhdr('FIGURE plot and stats');
printhdr(figname);

create_figure(figname)

clear han boxhan

for i = 1:nstudies
    
    y = INPUT_STRUCT.subject_means_by_study{i};  %./ mad(INPUT_STRUCT.subject_means_by_study{i});
    x = unifrnd(i - .2, i + .2, length(y), 1);
    
    boxhan = barplot_columns(y, 'colors', studycolors{i}, 'x', i, 'nofig', 'noind', 'nobars');
    han(i) = plot(x, y, 'o', 'MarkerFaceColor', studycolors{i}, 'Color', studycolors{i} ./ 2);

end

% Axis formatting
% ------------------------------------------------------------------

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XTickLabel', 1:nstudies);
xlabel('Study'); ylabel('Brain pattern response'); 
title(figname);
axis tight
lineh = plot_horizontal_line(0);
set(lineh, 'LineStyle', '--', 'LineWidth', 2);

% Save
% ------------------------------------------------------------------

drawnow, snapnow

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);


% Aggregate effect sizes and print table
% ------------------------------------------------------------------

dfun = @(x) mean(x) ./ std(x);
d = cellfun(dfun, INPUT_STRUCT.subject_means_by_study, 'UniformOutput', false);
d = cat(1, d{:});
d = [d; mean(d)];
studynumber = ([1:nstudies NaN])';
studynames = [studynames; {'Mean'}];

for i = 1:length(INPUT_STRUCT.subject_means_by_study)
    
    [h, p_value(i, 1), ci, stats] = ttest(INPUT_STRUCT.subject_means_by_study{i});
    t_value(i, 1) = stats.tstat;
    
end
t_value = [t_value; nanmean(t_value)];
p_value = [p_value; nanmean(p_value)];

dtable = table(studynames, studynumber, d, t_value, p_value);

printhdr(figname);
disp(dtable);

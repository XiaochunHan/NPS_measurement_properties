function plugin_plot_violins_withinperson_by_study(input_cell, studynames, figname, figsavedir, studycolors)
%
% Create a violin plot by study with all individual subjects, within-person relationships
% plugin_plot_violins_withinperson_by_study(input_cell, figname)
% 
% Example:
% figname = 'NPS within-person correlation with pain by study';
% [stats_table, within_b, within_r] = plugin_regress_within_subject(NPS, PAIN, figname);
% plugin_plot_violins_withinperson_by_study(within_r, NPS.studynames, figname, figsavedir, studycolors)


% Display helper functions
% ------------------------------------------------------------------

dashes = '----------------------------------------------';
printstr = @(dashes) disp(dashes);
printhdr = @(str) fprintf('%s\n%s\n%s\n', dashes, str, dashes);

% Useful variables
% ------------------------------------------------------------------
nstudies = length(input_cell);

% Figure
% ------------------------------------------------------------------

printhdr('FIGURE plot and stats');
printhdr(figname);

create_figure(figname)

clear han boxhan

for i = 1:nstudies
    
    y = input_cell{i};  
    x = unifrnd(i - .2, i + .2, length(y), 1);
    
    if all(isnan(y)), continue, end % skip if no data
    
    boxhan = barplot_columns(y, 'colors', studycolors{i}, 'x', i, 'nofig', 'noind', 'nobars');
    han(i) = plot(x, y, 'o', 'MarkerFaceColor', studycolors{i}, 'Color', studycolors{i} ./ 2);

end

% Axis formatting
% ------------------------------------------------------------------

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XTickLabel', 1:nstudies);
xlabel('Study'); ylabel('Single-trial Correlation'); 
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
d = cellfun(dfun, input_cell, 'UniformOutput', false);
d = cat(1, d{:});
d = [d; nanmean(d)];
studynumber = ([1:nstudies NaN])';

if ~iscolumn(studynames), studynames = studynames'; end

studynames = [studynames; {'Mean'}];
dtable = table(studynames, studynumber, d);

printhdr(figname);
disp(dtable);

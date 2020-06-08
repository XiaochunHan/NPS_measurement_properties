function plugin_scatterplot_across_studies(X, Y, xname, yname, figname, figsavedir, studycolors)
%
% Create a scatterplot by study with all individual subjects
% plugin_scatterplot_across_studies(X, PAIN, figname, figsavedir, studycolors)
% 
% Example:
% figname = 'TEMP by PAIN';
% X = TEMP;
% Y = PAIN;
% plugin_scatterplot_across_studies(X, Y, xname, yname, figname, figsavedir, studycolors)


% Display helper functions
% ------------------------------------------------------------------

dashes = '----------------------------------------------';
printstr = @(dashes) disp(dashes);
printhdr = @(str) fprintf('%s\n%s\n%s\n', dashes, str, dashes);

% Useful variables
% ------------------------------------------------------------------
nstudies = X.nstudies;
studynames = X.studynames;

% Figure
% ------------------------------------------------------------------

printhdr('FIGURE plot and stats');
printhdr(figname);

create_figure(figname);

clear han boxhan

x = X.subject_means_cat;
y = Y.subject_means_cat;

plot(x, y, 'ko'); 
han = refline;
set(han, 'LineWidth', 3, 'Color', [.3 .3 .3]);
r = corr(x, y);
fprintf('Correlation between individ. diffs in temp and brain response is %3.2f\n', r);
axis tight

for i = 1:nstudies

    x = X.subject_means_by_study{i};
    y = Y.subject_means_by_study{i};
        
    han(i) = plot(x, y, 'o', 'color', studycolors{i}./2, 'markerfacecolor', studycolors{i});

end

% Axis formatting
% ------------------------------------------------------------------

set(gca, 'FontSize', 18);
xlabel(xname); ylabel(yname); 
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



end % function

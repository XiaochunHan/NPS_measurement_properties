function plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors)
%
% Create a scatterplot by study with all individual subjects
% plugin_scatterplot_by_study_betweensubjects(X, PAIN, figname, figsavedir, studycolors)
% 
% Example:
% figname = 'TEMP by PAIN';
% X = TEMP;
% Y = PAIN;
% plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors)


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

nrows = 3;
ncols = ceil(nstudies ./ 3);

create_figure(figname, nrows, ncols);

% clear han boxhan
% 
% x = X.subject_means_cat;
% y = Y.subject_means_cat;
% 
% plot(x, y, 'ko'); 
% han = refline;
% set(han, 'LineWidth', 3, 'Color', [.3 .3 .3]);
% r = corr(x, y);
% fprintf('Correlation between individ. diffs in temp and brain response is %3.2f\n', r);
% axis tight

for i = 1:nstudies
    
    subplot(nrows, ncols, i);
    
    x = X.subject_means_by_study{i};
    y = Y.subject_means_by_study{i};
    
    han(i) = plot(x, y, 'o', 'color', studycolors{i}./2, 'markerfacecolor', studycolors{i});
    
    refline
    
    
    % Axis formatting
    % ------------------------------------------------------------------
    
    set(gca, 'FontSize', 12);
    xlabel(xname); ylabel(yname);
    title(format_strings_for_legend(studynames{i}));
    axis tight
    lineh = plot_horizontal_line(0);
    set(lineh, 'LineStyle', '--', 'LineWidth', 2);
    
    
end  % study


% Save
% ------------------------------------------------------------------

drawnow, snapnow

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);



end % function

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


for i = 1:nstudies
    
    subplot(nrows, ncols, i);
    
    x = X.event_by_study_zscore{i};
    y = Y.event_by_study_zscore{i};
    
    for j = 1:length(x)
        
        mycolor = studycolors{i} + .15 * rand(1, 3);
        mycolor(mycolor < 0) = 0;
        mycolor(mycolor > 1) = 1;
        
        plot(x{j}, y{j}, 'o', 'color', studycolors{i}./2, 'markerfacecolor', mycolor);
        
    end
    
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

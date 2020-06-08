function stats_table = plugin_scatterplot_by_study(INPUT_STRUCT, PAIN, figname, figsavedir, studycolors)
%
% Create a scatterplot by study with all individual subjects
% plugin_scatterplot_by_study(INPUT_STRUCT, PAIN, figname, figsavedir, studycolors)
% 
% Example:
% figname = 'NPS stim vs. baseline by study';
% INPUT_STRUCT = NPS;
% plugin_scatterplot_by_study(INPUT_STRUCT, TEMP, figname, figsavedir, studycolors)


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

create_figure(figname);

clear han boxhan

y =  INPUT_STRUCT.subject_means_cat;
x = PAIN.subject_means_cat;
wh = x < 2; % omit temp coded as 1 2 - REMI
y(wh) = [];
x(wh) = [];
plot(x, y, 'ko'); 
han = refline;
set(han, 'LineWidth', 3, 'Color', [.3 .3 .3]);
r = corr(x, y);
fprintf('Correlation between individ. diffs in temp and brain response is %3.2f\n', r);
axis tight

for i = 1:nstudies

    y = INPUT_STRUCT.subject_means_by_study{i};
    x = PAIN.subject_means_by_study{i};
        
    % omit temp coded as 1 2 - REMI
    if all(x < 2), continue, end
        
    han(i) = plot(x, y, 'o', 'color', studycolors{i}./2, 'markerfacecolor', studycolors{i});

end

% Axis formatting
% ------------------------------------------------------------------

set(gca, 'FontSize', 18);
xlabel('Pain'); ylabel('Brain response'); 
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

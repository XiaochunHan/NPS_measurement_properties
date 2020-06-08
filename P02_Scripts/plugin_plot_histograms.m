function plugin_plot_histograms(INPUT_STRUCT, figname, figsavedir, studycolors)
%
% Create a histogram by study with all individual subjects
% plugin_plot_pain_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)
% 
% Example:
% figname = 'NPS stim vs. baseline by study';
% INPUT_STRUCT = NPS;
% plugin_plot_by_temperature_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)


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

printhdr(figname);


nrows = 3;
ncols = ceil(nstudies ./ 3);

create_figure(figname, nrows, ncols);

for i = 1:nstudies
    
    subplot(nrows, ncols, i);
    
    dat = INPUT_STRUCT.event_by_study{i};
    dat = cat(1, dat{:});
    
        studynum(i, 1) = i;
    totalnumevents(i, 1) = length(dat);
    numzeros(i, 1) = sum(dat == 0);
    numnegativevalues(i, 1) = sum(dat < 0);
    numnan(i, 1) = sum(isnan(dat));
    
    histogram(dat, 30)
    title(format_strings_for_legend(studynames{i}));
    axis tight
end

zerotable = table(studynames, studynum, totalnumevents, numzeros, numnan, numnegativevalues);
disp(zerotable);



% Save
% ------------------------------------------------------------------

drawnow, snapnow

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);



end % function

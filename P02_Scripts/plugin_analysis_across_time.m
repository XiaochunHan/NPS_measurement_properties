function [study_ts, subject_count, wh_to_plot] = plugin_analysis_across_time(study_canlab_dataset, varname, figname, figsavedir, studycolors)
%
% Create a scatterplot by study with all individual subjects
% plugin_scatterplot_by_study_betweensubjects(X, PAIN, figname, figsavedir, studycolors)
% 
% Example:
% figname = 'Pain over time within session';
% varname = 'ratings';
% plugin_analysis_across_time(study_canlab_dataset, varname, figname, figsavedir, studycolors)


% Display helper functions
% ------------------------------------------------------------------

dashes = '----------------------------------------------';
printstr = @(dashes) disp(dashes);
printhdr = @(str) fprintf('%s\n%s\n%s\n', dashes, str, dashes);

% Useful variables
% ------------------------------------------------------------------
nstudies = length(study_canlab_dataset);

for i = 1:nstudies
    
    myname = format_strings_for_legend(study_canlab_dataset{i}.Description.Experiment_Name);
    studynames(i, 1) = myname;
    
end

% Figure
% ------------------------------------------------------------------

printhdr('FIGURE plot and stats');
printhdr(figname);

nrows = 3;
ncols = ceil(nstudies ./ 3);

create_figure(figname, nrows, ncols);

for i = 1:nstudies
    
    subplot(nrows, ncols, i);
    
    % Get trials x subjects data matrix
    y{i} = get_var(study_canlab_dataset{i}, varname); %, 'conditional', {'ok_trials', 1});
    
    % nan out the invalid trials instead of conditionalizing, to preserve
    % trial alignment
    ok{i} = get_var(study_canlab_dataset{i}, 'ok_trials'); 
    ok{i}(isnan(ok{i})) = 0; 
    y{i}(~ok{i}) = NaN;
    
    study_ts{i} = nanmean(y{i});
    subject_count{i} = sum(~isnan(y{i}));
    
    study_err{i} = ste(y{i});
    wh_to_plot{i} = subject_count{i} >= 3; % which to plot
    
    errorbar(study_ts{i}(wh_to_plot{i}), study_err{i}(wh_to_plot{i}));
    han(i) = plot(study_ts{i}(wh_to_plot{i}), 'o-', 'color', studycolors{i}./2, 'markerfacecolor', studycolors{i});
    
    
    % Axis formatting
    % ------------------------------------------------------------------
    xname = 'Trial number';
    set(gca, 'FontSize', 12);
    xlabel(xname); ylabel(format_strings_for_legend(varname));
    title(format_strings_for_legend(studynames{i}));
    axis tight
    %lineh = plot_horizontal_line(0);
    %set(lineh, 'LineStyle', '--', 'LineWidth', 2);
    
    
end  % study


% Save
% ------------------------------------------------------------------

drawnow, snapnow

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);



end % function

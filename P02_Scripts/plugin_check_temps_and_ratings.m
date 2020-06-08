nstudies = length(study_canlab_dataset);

create_figure('hist', 4, 4)

for i = 1:nstudies
    
    D = study_canlab_dataset{i}; 
    [subj_descriptives, event_descriptives] = get_descriptives(D, 'event', {'temp' 'ratings'});
    disp(event_descriptives)
    ratevar = get_var(D, 'ratings');
    subplot(4, 4, i);
    histogram(ratevar(:), 30)
    title(D.Description.Experiment_Name);
    axis tight
end

%%
create_figure('scatter', 4, 4)
clear between_corr

for i = 1:nstudies
    
    D = study_canlab_dataset{i}; 
    tempvar = get_var(D, 'temp');
    ratevar = get_var(D, 'ratings');
    
    % between-person
    tempvar_means = nanmean(tempvar')';
    ratevar_means = nanmean(ratevar')';
    [wasnan, tempvar_means, ratevar_means] = nanremove(tempvar_means, ratevar_means);
    between_corr(i, 1) = corr(tempvar_means, ratevar_means);
    
    [wasnan, tempvar, ratevar] = nanremove(tempvar(:), ratevar(:));
    
    subplot(4, 4, i);
    plot_correlation_samefig(tempvar, ratevar);
    title(D.Description.Experiment_Name);
    %axis tight
    xlabel('Temp'); ylabel('Rating');
    
    hold on;
    wh = ratevar <= 0;
    plot(tempvar(wh), ratevar(wh), 'ro', 'MarkerSize', 6, 'LineWidth', 3);
    
end

%% Table of zero/negative ratings

[studynum, numzeros,numnegativevalues] = deal(0);

for i = 1:nstudies
    
    D = study_canlab_dataset{i};
    ratevar = get_var(D, 'ratings');
    
    numzeros(i, 1) = sum(ratevar(:) == 0);
    numnegativevalues(i, 1) = sum(ratevar(:) < 0);
    
    studynum(i, 1) = i;
end

zerotable = table(studynum, numzeros, numnegativevalues);
disp(zerotable);


%%

% 
% studies 9 and 11 have only 1 temp, 47


%%


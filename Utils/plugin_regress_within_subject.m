function [stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname)
%
% - all trials are already selected to be 'ok' (no high vifs and/or missing
% data) in variable prep
%
% Example:
% X = TEMP;
% Y = NPS;
% [stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y,, figname);


myfield = 'event_by_study_zscore'; % event_by_study or event_by_study_madscaled or event_by_study_zscore

% Display helper functions
% ------------------------------------------------------------------

dashes = '----------------------------------------------';
printstr = @(dashes) disp(dashes);
printhdr = @(str) fprintf('%s\n%s\n%s\n', dashes, str, dashes);


% Useful variables
% ------------------------------------------------------------------
nstudies = X.nstudies;
studynames = X.studynames;

clear within_r within_p

for i = 1:nstudies
    
    x = X.(myfield){i};
    y = Y.(myfield){i};
        
    n = length(y);
    
    for j = 1:n
        
        [wasnan, x{j}, y{j}] = nanremove(double(x{j}), double(y{j}));
        
        if all(wasnan)
            [rr, pp] = deal(NaN);
            b = [NaN; NaN];
            
        else
            
            [rr, pp] = corr(x{j}, y{j});
            
            % Slope
            [b, dev, stats] = glmfit(x{j}, y{j});
            
        end
        
        within_b{i}(j, 1) = b(2);
        
        within_r{i}(j, 1) = rr;
        within_p{i}(j, 1) = pp;

    end
    
    % Stats by study
    if all(isnan(within_b{i})) % no valid data
        
        [t_by_study(i, 1), df_by_study(i, 1), p_by_study(i, 1), within_person_r(i, 1), within_person_b(i, 1), within_person_b_ste(i, 1),between_person_r(i, 1), between_person_p(i, 1)] = deal(NaN);
        within_person_r_CI(i, :) = [NaN NaN];
        
    else
        
        % Within-person stats
        [~,P,~,STATS] = ttest(within_b{i});
        t_by_study(i, 1) = STATS.tstat;
        df_by_study(i, 1) = STATS.df;
        p_by_study(i, 1) = P;
        
        [~, ~, CI] = ttest(within_r{i});
        
        within_person_r(i, 1) = nanmean(within_r{i});
        within_person_r_CI(i, :) = CI;
        
        within_person_b(i, 1) = nanmean(within_b{i});
        within_person_b_ste(i, 1) = ste(within_b{i});
        
        % Between-person stats
        [between_person_r(i, 1), between_person_p(i, 1)] = corr(X.subject_means_by_study{i}, Y.subject_means_by_study{i});
        
        
    end % tstats for study
    
end % study

dfun = @(x) mean(x) ./ std(x);
d_within = cellfun(dfun, within_r, 'UniformOutput', false);
d_within = cat(1, d_within{:});
d_within = [d_within; nanmean(d_within)];

r_all = cat(1, within_r{:});

printhdr(figname);

printstr('Within-person correlations, Grand average');
fprintf(1, 'r = %3.2f +- %3.2f (SE)\n', nanmean(r_all), ste(r_all))

fprintf(1, '\n');

studynumber = ([1:nstudies Inf])';
studynames = [studynames; {'Mean'}];

t_by_study = [t_by_study; nanmean(t_by_study)];
df_by_study = [df_by_study; nanmean(df_by_study)];
p_by_study = [p_by_study; nanmean(p_by_study)];

within_person_r = [within_person_r; nanmean(within_person_r)];
within_person_r_CI = [within_person_r_CI; nanmean(within_person_r_CI)];
within_person_b = [within_person_b; nanmean(within_person_b)];
within_person_b_ste = [within_person_b_ste; nanmean(within_person_b_ste)];

r2d = @(r) 2*r ./ (1 - r.^2).^.5;
d_between = arrayfun(r2d, between_person_r);

between_person_r = [between_person_r; nanmean(between_person_r)];
between_person_p = [between_person_p; nanmean(between_person_p)];
d_between = [d_between; nanmean(d_between)];


studynames2 = studynames;

stats_table = table(studynames, studynumber, within_person_b, within_person_r, within_person_r_CI, t_by_study, df_by_study, p_by_study, d_within, studynames2, between_person_r, between_person_p, d_between);

disp(stats_table);

end % function
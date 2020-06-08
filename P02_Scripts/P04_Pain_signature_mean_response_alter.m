
varnames = {'NPS' 'NPScorr' 'NPScosine'};


%%
clear my_outcomes *_all

for v = 1:length(varnames)
    
    create_figure(['Mean responses by study - ',varnames{v}], 3, 5)
    
    clear studynames data_table
    Y = eval(varnames{v});
    
    for i = 1:nstudies
        
        subplot(3, 5, i)
        
        % Get data
        
        y = Y.event_by_study{i};
        
        % Standard error
        e = cellfun(@ste, y)';
        
        % Degrees of freedom
        df = (cellfun(@length, y) - 1)';
        
        % Subject means
        y = cellfun(@nanmean, y)';
        
        %y = VARS.NPS_mean{i};
        %e = VARS.NPS_ste{i};
        
        % Single-subject t-values
        t = y ./ e;
        
        % Single-subject p-values
        p = 2 * min(tcdf(t, df), tcdf(-t, df));
        
        % normalize to approx same scale - does not change stats
        scalefactor = mad(y);
        y = y ./ scalefactor;
        e = e ./ scalefactor;
        
        % sort them
        [~, indx] = sort(y, 'ascend');
        
        y = y(indx);
        e = e(indx);
        t = t(indx);
        p = p(indx);
        
        
        plot(y, 'ko', 'MarkerFaceColor', [.4 .4 .4], 'MarkerSize', 5)
        errorbar(y, e, 'k.');
        
        wh = find(t < 0 & p < .05);
        plot(wh, y(wh), 'bo', 'MarkerFaceColor',  [.4 .4 1], 'MarkerSize', 5)
        
        wh = find(t > 0 & p < .05);
        plot(wh, y(wh), 'ro', 'MarkerFaceColor',  [1 .5 0], 'MarkerSize', 5)
        
        axis tight
        
        set(gca, 'YLim', [-4 8]);
        
        plot_horizontal_line(0);
        
        myname = Y.studynames(i);
        title(myname)
        
        
        % Data table
        % -------------------------------------------------------------------
        % N  mean_trials Percent_confirm Percent_wrong Percent_undetermined single_trial_d study_d
        N = length(y);
        mean_trials = mean(df + 1);
        pos = 100 * sum(y > 0 & p < .05) ./ N;  % percent pos
        neg = 100 * sum(y < 0 & p < .05) ./ N;  % percent pos
        inc = 100 * sum(p > .05) ./ N;  % percent inconclusive
        
        single_trial_d = mean(y ./ (e .* sqrt(df+1)));
        study_d = mean(y) ./ std(y);
        
        studynames(i) = myname;
        studyN(i, 1) = N;
        
        data_table(i, :) = [N mean_trials pos neg inc single_trial_d study_d];
        
        
    end  % Subject loop
    
    drawnow, snapnow
    
    %wh_valid = 2:12;
    
    names = {'N'  'mean_N_trials' 'Percent_confirm' 'Percent_wrong' 'Percent_undetermined' 'single_trial_d' 'study_d'};
    print_matrix(data_table, names, studynames);
    
    % weighted average, overall and without NSF and levoderm
    
    w = studyN / sum(studyN);
    
    all_means = data_table' * w;
    disp('Mean (all)')
    print_matrix(all_means', names);
    
%     w = studyN(wh_valid) / sum(studyN(wh_valid));
%     pub_means = data_table(wh_valid, :)' * w;
%     disp('Mean (valid checked independent datasets)')
%     print_matrix(pub_means', names);
    
    snapnow
    
    % Aggregate data across studies
    % ---------------------------------------------------------------------
    accuracy_all(:, v) = data_table(:, 3);
    wrong_all(:, v) = data_table(:, 4);
    single_trial_d_all(:, v) = data_table(:, 6);
    study_d_all(:, v) = data_table(:, 7);
    
    
end  % Variable v

%% Plot summary across all vars

create_figure('means across vars', 2, 2);

[my_outcomes, myxnames] = deal({});
my_outcomes{1} = accuracy_all;
my_outcomes{2} = wrong_all;

my_outcomes{3} = single_trial_d_all;
my_outcomes{4} = study_d_all;

mytitles = {'Positive hits' 'Wrong decisions' 'Single trial d' 'Subject-level d'};
myylabels = {'Proportion of participants' 'Proportion of participants' 'Cohen''s d' 'Cohen''s d'}
for i = 1:length(varnames)
    myxnames(i) = format_strings_for_legend(varnames{i});
    
    myxnames{i} = strrep(myxnames{i}, 'NPS cosine similarity none', 'cossim');
    myxnames{i} = strrep(myxnames{i}, 'NPSpos cosine similarity none', 'cossim pos');
    myxnames{i} = strrep(myxnames{i}, 'NPSpos cosine similarity none', 'cossim neg');
end

colors = seaborn_colors(length(varnames)); %{[.7 .2 .2] [.5 .4 .2] [.2 .7 .2] [.2 .5 .4]};

for v = 1:length(my_outcomes)
    
    subplot(2, 2, v);
    
    barplot_columns(my_outcomes{v}, 'nofig', 'color', colors, 'noviolin', 'dolines');
    
    title(mytitles{v});
    
    set(gca, 'XTicklabel', myxnames, 'XTickLabelRotation', 45);
    ylabel(myylabels{v});
    xlabel(' ');
    
end

drawnow, snapnow


%% Plot relationships between temperature and Pain

X = zTEMP;
Y = zPAIN;
xname = 'Temperature';
yname = 'Pain';
figname = 'TEMP by Pain by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with Pain violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'TEMP between-person correlation with Pain violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);
%% Plot relationships between temperature and NPS

X = zTEMP;
Y = zNPS;
xname = 'Temperature';
yname = 'NPS';
figname = 'TEMP by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPS violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'TEMP between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);
%% Plot relationships between temperature and NPS_corr

X = zTEMP;
Y = zNPScorr;
xname = 'Temperature';
yname = 'NPS_corr';
figname = 'TEMP by NPScorr by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r1] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPScorr violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'TEMP between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);
%% Plot relationships between temperature and NPS_cosine

X = zTEMP;
Y = zNPScosine;
xname = 'Temperature';
yname = 'NPS_corr';
figname = 'TEMP by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPS violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'TEMP between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);

%% Plot relationships between pain and NPS

X = zPAIN;
Y = zNPS;
xname = 'Pain';
yname = 'NPS';
figname = 'Pain by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with NPS violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);
%% Plot relationships between pain and NPS_corr

X = zPAIN;
Y = zNPScorr;
xname = 'Pain';
yname = 'NPS_corr';
figname = 'Pain by NPScorr by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r2] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with NPScorr violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);
%% Plot relationships between pain and NPS_cosine

X = zPAIN;
Y = zNPScosine;
xname = 'Pain';
yname = 'NPS_corr';
figname = 'Pain by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with NPS violins';
plugin_plot_violins_withinperson_by_study(within_r, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table2, between_b, between_r] = plugin_regress_between_subject(X, Y, figname);
%% Temp vs. Pain
for i = 1:length(within_r1)
    within_r_dif{1,i} = within_r2{1,i} - within_r1{1,i};
end
figname = 'Pain vs. Temp within-person correlation with NPScorr violins';
plugin_plot_violins_withinperson_by_study(within_r_dif, X.studynames, figname, figsavedir, studycolors);

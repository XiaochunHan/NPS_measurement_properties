X = NPS;
Y = PAIN;
xname = 'NPS';
yname = 'Pain';

figname = sprintf('%s by %s by study between subject', xname, yname);

plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);
%%
X = NPScorr;
Y = PAIN;
xname = 'NPScorr';
yname = 'Pain';

figname = sprintf('%s by %s by study between subject', xname, yname);

plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);
%%
X = NPScosine;
Y = PAIN;
xname = 'NPScosine';
yname = 'Pain';

figname = sprintf('%s by %s by study between subject', xname, yname);

plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
[stats_table, within_b, within_r] = plugin_regress_within_subject(X, Y, figname);

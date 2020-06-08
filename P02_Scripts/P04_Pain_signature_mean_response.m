studycolors = seaborn_colors(15)';
%%
figname = 'NPS vs. baseline by study';
INPUT_STRUCT = NPS;
plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)

%%
figname = 'NPS corr stim vs. baseline by study';
INPUT_STRUCT = NPScorr;
plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)

%%
figname = 'NPSneg cosine stim vs. baseline by study';
INPUT_STRUCT = NPScosine;
plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)
%%
figname = 'NPS pos corr stim vs. baseline by study';
INPUT_STRUCT = NPScorr_pos;
plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)
%%
figname = 'NPS pos cosine stim vs. baseline by study';
INPUT_STRUCT = NPScosine_pos;
plugin_plot_violins_by_study(INPUT_STRUCT, figname, figsavedir, studycolors)
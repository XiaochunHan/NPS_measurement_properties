figsavedir = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/Figure';

figname = 'Histograms Temperature';
plugin_plot_histograms(TEMP, figname, figsavedir);

figname = 'Histograms Pain';
plugin_plot_histograms(PAIN, figname, figsavedir);

figname = 'Histograms NPS';
plugin_plot_histograms(NPS, figname, figsavedir);

figname = 'Histograms NPS cosine sim';
plugin_plot_histograms(NPScosine, figname, figsavedir);

figname = 'Histograms NPS corr sim';
plugin_plot_histograms(NPScorr, figname, figsavedir);

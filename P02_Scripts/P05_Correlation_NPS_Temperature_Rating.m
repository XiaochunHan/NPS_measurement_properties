%% Plot relationships between temperature and NPS

X = TEMP;
Y = NPS;
xname = 'Temperature';
yname = 'NPS';
figname = 'TEMP by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_nps] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPS violins';
NPS_main_effect = plugin_plot_violins_withinperson_by_study(within_r_nps, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS_corr

X = TEMP;
Y = NPScorr;
xname = 'Temperature';
yname = 'NPS_corr';
figname = 'TEMP by NPS correlation by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_nps_corr] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPScorr violins';
NPScorr_main_effect = plugin_plot_violins_withinperson_by_study(within_r_nps_corr, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS_cosine

X = TEMP;
Y = NPScosine;
xname = 'Temperature';
yname = 'NPS cosine';
figname = 'TEMP by NPS cosine by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_nps_cos] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with NPScosine violins';
NPScosine_main_effect = plugin_plot_violins_withinperson_by_study(within_r_nps_cos, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS

X = TEMP;
Y = SIIPS;
xname = 'Temperature';
yname = 'SIIPS';
figname = 'TEMP by SIIPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_siips] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with SIIPS violins';
SIIPS_main_effect = plugin_plot_violins_withinperson_by_study(within_r_siips, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS_corr

X = TEMP;
Y = SIIPScorr;
xname = 'Temperature';
yname = 'SIIPScorr';
figname = 'TEMP by NPScorr by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_siips_corr] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with SIIPScorr violins';
SIIPScorr_main_effect = plugin_plot_violins_withinperson_by_study(within_r_siips_corr, X.studynames, figname, figsavedir, studycolors);

%% Plot relationships between temperature and NPS_cosine

X = TEMP;
Y = SIIPScosine;
xname = 'Temperature';
yname = 'SIIPScosine';
figname = 'TEMP by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[~, ~, within_r_siips_cos] = plugin_regress_within_subject(X, Y, figname);

figname = 'TEMP within-person correlation with SIIPScosine violins';
SIIPScosine_main_effect = plugin_plot_violins_withinperson_by_study(within_r_siips_cos, X.studynames, figname, figsavedir, studycolors);

%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS and SIIPS correlation with Temperature';

create_figure(figname,1,3)

dfun = @(x) mean(x) ./ std(x);
d_nps = cellfun(dfun, within_r_nps_corr, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});
d_siips = cellfun(dfun, within_r_siips_corr, 'UniformOutput', false);
d_siips = cat(1, d_siips{:});
subplot(1,3,1);
clear han
mean_d_all = [NPS_main_effect.d(10,1),NPScorr_main_effect.d(10,1),NPScosine_main_effect.d(10,1);SIIPS_main_effect.d(10,1),SIIPScorr_main_effect.d(10,1),SIIPScosine_main_effect.d(10,1)];
se_d_all = [std(NPS_main_effect.d(1:9,1)),std(NPScorr_main_effect.d(1:9,1)),std(NPScosine_main_effect.d(1:9,1));std(SIIPS_main_effect.d(1:9,1)),std(SIIPScorr_main_effect.d(1:9,1)),std(SIIPScosine_main_effect.d(1:9,1))]./3;
bar(mean_d_all, 'grouped');
hold on
% Find the number of groups and the number of bars in each group
ngroups = size(mean_d_all, 1);
nbars = size(mean_d_all, 2);
% Calculate the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, mean_d_all(:,i), se_d_all(:,i), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
end
set(gca, 'FontSize', 18);
xticklabels({'NPS','','SIIPS'})
ylim([0 4.5])
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS and SIIPS');
legend('dot product','correlation','cosine');
% axis tight

subplot(1,3,2);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_nps(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_nps, 1 ./ sqrt(NPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4.5]);
ylabel('Effect size (d)'); 
title('Effect size by study NPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_nps), min(d_nps), max(d_nps));

subplot(1,3,3);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_siips(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_siips, 1 ./ sqrt(SIIPScosine.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4.5]);
ylabel('Effect size (d)'); 
title('Effect size by study SIIPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_siips), min(d_siips), max(d_siips));

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);











%% Plot relationships between pain and NPS
clear within_r* b_*;

X = PAIN;
Y = NPS;
xname = 'Pain';
yname = 'NPS';
figname = 'Pain by NPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table_nps, ~, within_r_nps] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with NPS violins';
plugin_plot_violins_withinperson_by_study(within_r_nps, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with NPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and NPScorr

X = PAIN;
Y = NPScorr;
xname = 'Pain';
yname = 'NPScorr';
figname = 'Pain by NPScorr by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table_nps_corr, ~, within_r_nps_corr] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with NPScorr violins';
plugin_plot_violins_withinperson_by_study(within_r_nps_corr, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with NPScorr violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and NPScosine

X = PAIN;
Y = NPScosine;
xname = 'Pain';
yname = 'NPScosine';
figname = 'Pain by NPScosine by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table_nps_cos, ~, within_r_nps_cos] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with NPScosine violins';
plugin_plot_violins_withinperson_by_study(within_r_nps_cos, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with NPScosine violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and SIIPS

X = PAIN;
Y = SIIPS;
xname = 'Pain';
yname = 'SIIPS';
figname = 'Pain by SIIPS by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table_siips, ~, within_r_siips] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with SIIPS violins';
plugin_plot_violins_withinperson_by_study(within_r_siips, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with SIIPS violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and SIIPS_corr

X = PAIN;
Y = SIIPScorr;
xname = 'Pain';
yname = 'SIIPScorr';
figname = 'Pain by SIIPScorr by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table_siips_corr, ~, within_r_siips_corr] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with SIIPScorr violins';
plugin_plot_violins_withinperson_by_study(within_r_siips_corr, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with SIIPScorr violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Plot relationships between pain and SIIPScosine

X = PAIN;
Y = SIIPScosine;
xname = 'Pain';
yname = 'SIIPScosine';
figname = 'Pain by SIIPScosine by study within subject';

plugin_scatterplot_by_study_withinsubjects(X, Y, xname, yname, figname, figsavedir, studycolors);

[stats_table_siips_cos, ~, within_r_siips_cos] = plugin_regress_within_subject(X, Y, figname);

figname = 'Pain within-person correlation with SIIPScosine violins';
plugin_plot_violins_withinperson_by_study(within_r_siips_cos, X.studynames, figname, figsavedir, studycolors);

figname = 'Pain between-person correlation with SIIPScosine violins';
plugin_scatterplot_by_study_betweensubjects(X, Y, xname, yname, figname, figsavedir, studycolors);
%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS and SIIPS within subject correlation with Pain';

create_figure(figname,1,3)

dfun = @(x) mean(x) ./ std(x);
d_nps = cellfun(dfun, within_r_nps, 'UniformOutput', false);
d_nps = cat(1, d_nps{:});
d_nps_corr = cellfun(dfun, within_r_nps_corr, 'UniformOutput', false);
d_nps_corr = cat(1, d_nps_corr{:});
d_nps_cos = cellfun(dfun, within_r_nps_cos, 'UniformOutput', false);
d_nps_cos = cat(1, d_nps_cos{:});
d_siips = cellfun(dfun, within_r_siips, 'UniformOutput', false);
d_siips = cat(1, d_siips{:});
d_siips_corr = cellfun(dfun, within_r_siips_corr, 'UniformOutput', false);
d_siips_corr = cat(1, d_siips_corr{:});
d_siips_cos = cellfun(dfun, within_r_siips_cos, 'UniformOutput', false);
d_siips_cos = cat(1, d_siips_cos{:});
subplot(1,3,1);
clear han
mean_d_all = [mean(d_nps),mean(d_nps_corr),mean(d_nps_cos);mean(d_siips),mean(d_siips_corr),mean(d_siips_cos)];
se_d_all = [std(d_nps),std(d_nps_corr),std(d_nps_cos);std(d_siips),std(d_siips_corr),std(d_siips_cos)]./3;
bar(mean_d_all, 'grouped');
hold on
% Find the number of groups and the number of bars in each group
ngroups = size(mean_d_all, 1);
nbars = size(mean_d_all, 2);
% Calculate the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, mean_d_all(:,i), se_d_all(:,i), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
end
set(gca, 'FontSize', 18);
xticklabels({'NPS','','SIIPS'})
ylim([0 4.5])
ylabel('Mean ffect size (d)'); 
title('Mean effect sizes of NPS and SIIPS');
legend('dot product','correlation','cosine');
% axis tight

subplot(1,3,2);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_nps_corr(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_nps_corr, 1 ./ sqrt(NPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4.5]);
ylabel('Effect size (d)'); 
title('Effect size by study NPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_nps_corr), min(d_nps_corr), max(d_nps_corr));

subplot(1,3,3);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, d_siips_corr(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, d_siips_corr, 1 ./ sqrt(SIIPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([0 4.5]);
ylabel('Effect size (d)'); 
title('Effect size by study SIIPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(d_siips_corr), min(d_siips_corr), max(d_siips_corr));

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);



%% Effect size by study, for whole pattern and subregions
nstudies = NPS.nstudies;

figname = 'NPS and SIIPS between subject correlation with Pain';

create_figure(figname,1,3)

z_nps = atanh(stats_table_nps.between_person_r);
z_nps_corr = atanh(stats_table_nps_corr.between_person_r);
z_nps_cos = atanh(stats_table_nps_cos.between_person_r);
z_siips = atanh(stats_table_siips.between_person_r);
z_siips_corr = atanh(stats_table_siips_corr.between_person_r);
z_siips_cos = atanh(stats_table_siips_cos.between_person_r);

subplot(1,3,1);
clear han
mean_d_all = [z_nps(10,1),z_nps_corr(10,1),z_nps_cos(10,1);z_siips(10,1),z_siips_corr(10,1),z_siips_cos(10,1)];
se_d_all = [std(z_nps(1:9,1)),std(z_nps_corr(1:9,1)),std(z_nps_cos(1:9,1));std(z_siips(1:9,1)),std(z_siips_corr(1:9,1)),std(z_siips_cos(1:9,1))]./3;
bar(mean_d_all, 'grouped');
hold on
% Find the number of groups and the number of bars in each group
ngroups = size(mean_d_all, 1);
nbars = size(mean_d_all, 2);
% Calculate the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, mean_d_all(:,i), se_d_all(:,i), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
end
set(gca, 'FontSize', 18);
xticklabels({'NPS','','SIIPS'})
ylim([-0.5 1.5]);
ylabel('Mean ffect size (z)'); 
title('Mean effect sizes of NPS and SIIPS');
legend('dot product','correlation','cosine');
% axis tight

subplot(1,3,2);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, z_nps_corr(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, z_nps_corr(1:9,1), 1 ./ sqrt(NPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study');ylim([-0.5 1.5]);
ylabel('Effect size (z)'); 
title('Effect size by study NPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(z_nps_corr(1:9,1)), min(z_nps_corr(1:9,1)), max(z_nps_corr(1:9,1)));

subplot(1,3,3);
clear han
for i = 1:nstudies
      
    han(i) = bar(i, z_siips_corr(i), 'FaceColor', studycolors{i});

end

% Error bars proportional to df for std. err
ehan = errorbar(1:nstudies, z_siips_corr(1:9,1), 1 ./ sqrt(SIIPScorr.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

set(gca, 'XTick', 1:nstudies, 'FontSize', 18);
xlabel('Study'); ylim([-0.5 1.5]);
ylabel('Effect size (z)'); 
title('Effect size by study SIIPS correlation');
% axis tight

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(z_siips_corr(1:9,1)), min(z_siips_corr(1:9,1)), max(z_siips_corr(1:9,1)));

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);

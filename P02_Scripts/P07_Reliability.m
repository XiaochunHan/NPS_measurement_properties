%%
for i = 1:nstudies
    
    reliab_nps(i,1) = reliability_split_half(NPS.event_by_study{i});
    reliab_npscorr(i,1) = reliability_split_half(NPScorr.event_by_study{i});
    reliab_npscosine(i,1) = reliability_split_half(NPScosine.event_by_study{i});
    
    reliab_siips(i,1) = reliability_split_half(SIIPS.event_by_study{i});
    reliab_siipscorr(i,1) = reliability_split_half(SIIPScorr.event_by_study{i});
    reliab_siipscosine(i,1) = reliability_split_half(SIIPScosine.event_by_study{i});
    
    reliab_pain(i,1) = reliability_split_half(PAIN.event_by_study{i});
    
end
clear NPS* SIIPS* PAIN TEMP
%%
% Data table
% -------------------------------------------------------------------
data_table = table(NPS.studynames, reliab_nps, reliab_npscorr, reliab_npscosine, reliab_siips, reliab_siipscorr, reliab_siipscosine, reliab_pain);
disp(data_table)

drawnow, snapnow

%%
figname = 'Reliability by study';

create_figure(figname, 2, 3);

clear han
mycolor = [1 .5 0];
han(1) = plot(reliab_nps, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(reliab_pain, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
xlabel('Study'); ylabel('Reliability');
title('NPS ICC');

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -
subplot(2, 3, 2);
clear han

mycolor = [1 .5 0];
han(1) = plot(reliab_npscorr, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(reliab_pain, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
xlabel('Study'); ylabel('Reliability');
title('NPS Corr ICC');

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -
subplot(2, 3, 3);
clear han

mycolor = [1 .5 0];
han(1) = plot(reliab_npscosine, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(reliab_pain, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

legend(han, {'NPS cosine sim' 'Pain ratings'},'Location','southeast')
set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
xlabel('Study'); ylabel('Reliability');
title('NPS Cosine ICC');

subplot(2, 3, 4);

plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(reliab_nps(i), reliab_pain(i), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(reliab_nps(i)+.02, reliab_pain(i), num2str(i));
    
end

xlabel('NPS reliability');
ylabel('Pain reliability');
title('NPS Split-half Reliability');

% han = errorbar(meannps, meanpain, stepain, 'Color', [.2 .2 .7], 'LineWidth', 2);
% han = errorbar_horizontal(meannps, meanpain, stenps);
% set(han, 'Color', [.2 .2 .7], 'LineWidth', 2);

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -

subplot(2, 3, 5);

plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(reliab_npscorr(i), reliab_pain(i), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(reliab_npscorr(i)+.02, reliab_pain(i), num2str(i));
    
end

xlabel('NPS reliability');
ylabel('Pain reliability');
title('NPS correlation Split-half Reliability');

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -

subplot(2, 3, 6);

plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(reliab_npscosine(i), reliab_pain(i), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(reliab_npscosine(i)+.02, reliab_pain(i), num2str(i));
    
end

xlabel('NPS reliability');
ylabel('Pain reliability');
title('NPS cosine Split-half Reliability');

% Error bars proportional to df for std. err
%ehan = errorbar(1:nstudies, d, 1 ./ sqrt(NPS.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');




%%
figname = 'NPS and SIIPS Reliability';

create_figure(figname,2,3)

subplot(2,3,1);
clear han
mean_d_all = [mean(reliab_nps), mean(reliab_npscorr), mean(reliab_npscosine); mean(reliab_siips), mean(reliab_siipscorr), mean(reliab_siipscosine)];
se_d_all = [std(reliab_nps), std(reliab_npscorr), std(reliab_npscosine); std(reliab_siips), std(reliab_siipscorr), std(reliab_siipscosine)]./3;
han = bar(mean_d_all, 'grouped');
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
    han2 = errorbar(x, mean_d_all(:,i), se_d_all(:,i), 'k', 'linestyle', 'none', 'LineWidth', 2, 'Color', 'k');
end
xticklabels({'NPS','','SIIPS'})
ylim([0 1]);
ylabel('Reliability Spearman-brown'); 
title('Split-half Reliability of NPS and SIIPS');
% axis tight
hold on;
han3 = yline(mean(reliab_pain)+std(reliab_pain)/3,'--','Reliability of Pain rating','LineWidth',1);
hold on;
han4 = yline(mean(reliab_pain),'LineWidth',1.5);
hold on;
han5 = yline(mean(reliab_pain)-std(reliab_pain)/3,'--','LineWidth',1);
set(gca, 'FontSize', 18);
legend off;

subplot(2,3,2);
clear han

mycolor = [1 .5 0];
han(1) = plot(reliab_npscorr, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(reliab_pain, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
legend({'NPScorr' 'Pain ratings'},'Location','southeast');
xlabel('Study'); ylabel('Reliability');
title('NPS Corr Reliability');

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(reliab_npscorr), min(reliab_npscorr), max(reliab_npscorr));

subplot(2,3,3);
clear han

mycolor = [1 .5 0];
han(1) = plot(reliab_siipscorr, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(reliab_pain, 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
legend({'SIIPScorr' 'Pain ratings'},'Location','southeast')
xlabel('Study'); ylabel('Reliability');
title('SIIPS Correlation Reliability');

fprintf('Average d = %3.2f, Range = %3.2f to %3.2f\n', mean(reliab_siipscorr), min(reliab_siipscorr), max(reliab_siipscorr));

subplot(2,3,5);
plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(reliab_npscorr(i), reliab_pain(i), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(reliab_npscorr(i)+.02, reliab_pain(i), num2str(i));
    
end
xlabel('NPScorr reliability');
ylabel('Pain reliability');
title('NPS correlation Split-half Reliability');

subplot(2,3,6);
plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(reliab_siipscorr(i), reliab_pain(i), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(reliab_siipscorr(i)+.02, reliab_pain(i), num2str(i));
    
end
xlabel('SIIPScorr reliability');
ylabel('Pain reliability');
title('SIIPS correlation Split-half Reliability');

figsavename = strrep(figname, ' ', '_');
figsavename = strrep(figsavename, '.', '');
figsavefile = fullfile(figsavedir, [figsavename '.png']);
saveas(gcf, figsavefile);
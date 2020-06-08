%%
for i = 1:nstudies
    
    DAT = zNPS.event_by_study{i};
    icc_nps{i} = reliability_ICC(DAT);
    
end
%%
for i = 1:nstudies
    
    DAT = zNPScorr.event_by_study{i};
    icc_npscorr{i} = reliability_ICC(DAT);
    
end

%%

for i = 1:nstudies
    
    DAT = zNPScosine.event_by_study{i};
    icc_npscosine{i} = reliability_ICC(DAT);
    
end
%%

for i = 1:nstudies
    
    DAT = zPAIN.event_by_study{i};
    icc_rating{i} = reliability_ICC(DAT);
    
end
%%
% Data table
% -------------------------------------------------------------------
nps_icc = icc_nps';
nps_corr_icc = icc_npscorr';
nps_cosine_icc = icc_npscosine';
rating_icc = icc_rating';

data_table = table(studynames, nps_icc, nps_corr_icc, nps_cosine_icc, rating_icc);
disp(data_table)

drawnow, snapnow

%%
figname = 'Reliability by study';

create_figure(figname, 2, 3);

clear han
mycolor = [1 .5 0];
han(1) = plot(cell2mat(nps_icc), 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(cell2mat(rating_icc), 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
xlabel('Study'); ylabel('Reliability');
title('NPS ICC');

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -
subplot(2, 3, 2);
clear han

mycolor = [1 .5 0];
han(1) = plot(cell2mat(nps_corr_icc), 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(cell2mat(rating_icc), 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

legend(han, {'NPS cosine sim' 'Pain ratings'})
set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
xlabel('Study'); ylabel('Reliability');
title('NPS Corr ICC');

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -
subplot(2, 3, 3);
clear han

mycolor = [1 .5 0];
han(1) = plot(cell2mat(nps_cosine_icc), 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

mycolor = [.7 .2 .3];
han(2) = plot(cell2mat(rating_icc), 'o', 'Color', mycolor ./ 2, 'MarkerFaceColor', mycolor, 'MarkerSize', 8);

legend(han, {'NPS cosine sim' 'Pain ratings'})
set(gca, 'XTick', 1:nstudies, 'FontSize', 18, 'XLim', [0 nstudies+1], 'YLim', [0 1]);
xlabel('Study'); ylabel('Reliability');
title('NPS Cosine ICC');

subplot(2, 3, 4);

plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(cell2mat(nps_icc(i)), cell2mat(rating_icc(i)), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(cell2mat(nps_icc(i))+.02, cell2mat(rating_icc(i)), num2str(i));
    
end

xlabel('NPS reliability');
ylabel('Pain reliability');
title('NPS ICC');

% han = errorbar(meannps, meanpain, stepain, 'Color', [.2 .2 .7], 'LineWidth', 2);
% han = errorbar_horizontal(meannps, meanpain, stenps);
% set(han, 'Color', [.2 .2 .7], 'LineWidth', 2);

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -

subplot(2, 3, 5);

plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(cell2mat(nps_corr_icc(i)), cell2mat(rating_icc(i)), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(cell2mat(nps_corr_icc(i))+.02, cell2mat(rating_icc(i)), num2str(i));
    
end

xlabel('NPS reliability');
ylabel('Pain reliability');
title('NPS Corr ICC');

% - - - - - - - - - - - - - - - - - - - - - - - - - - - -

subplot(2, 3, 6);

plot([0 1], [0 1], 'k:', 'LineWidth', 2);
axis equal
set(gca, 'XLim', [.4 1], 'YLim', [.4 1])

for i = 1:nstudies
    
    plot(cell2mat(nps_cosine_icc(i)), cell2mat(rating_icc(i)), 'o', 'Color', studycolors{i} ./ 2, 'MarkerFaceColor', studycolors{i}, 'LineWidth', 1, 'MarkerSize', 8)
    text(cell2mat(nps_cosine_icc(i))+.02, cell2mat(rating_icc(i)), num2str(i));
    
end

xlabel('NPS reliability');
ylabel('Pain reliability');
title('NPS Cosine ICC');

% Error bars proportional to df for std. err
%ehan = errorbar(1:nstudies, d, 1 ./ sqrt(NPS.N), 'LineStyle', 'none', 'LineWidth', 2, 'Color', 'k');

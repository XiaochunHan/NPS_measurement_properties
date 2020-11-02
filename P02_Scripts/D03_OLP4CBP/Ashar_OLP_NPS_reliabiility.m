% Load dataset and format into table
% ------------------------------------------------
clear;clc;

fname = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D03_OLP4CBP/P01_Extract_data/nps_test_retest_OLP4CBP.csv';
dat = importdata(fname);
dattable = array2table(dat.data, 'VariableNames', dat.colheaders);
savePath = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D03_OLP4CBP/P01_Extract_data';
%%
% Calculate new variables
dattable.thumb_hi_vs_lo_nps_dotprod = dattable.thumb_hi_nps_dotprod - dattable.thumb_lo_nps_dotprod;
dattable.thumb_hi_vs_lo_nps_cossim = dattable.thumb_hi_nps_cossim - dattable.thumb_lo_nps_cossim;
dattable.thumb_hi_vs_lo_nps_corr = dattable.thumb_hi_nps_corr - dattable.thumb_lo_nps_corr;
dattable.thumb_hi_vs_lo_meanpain = dattable.thumb_hi_meanpain - dattable.thumb_lo_meanpain;
dattable.sound_hi_vs_lo_nps_dotprod = dattable.sound_hi_nps_dotprod - dattable.sound_lo_nps_dotprod;
dattable.sound_hi_vs_lo_nps_cossim = dattable.sound_hi_nps_cossim - dattable.sound_lo_nps_cossim;
dattable.sound_hi_vs_lo_nps_corr = dattable.sound_hi_nps_corr - dattable.sound_lo_nps_corr;
dattable.sound_hi_vs_lo_meanpain = dattable.sound_hi_meanpain - dattable.sound_lo_meanpain;

dattable.thumb_mean_nps_dotprod = (dattable.thumb_hi_nps_dotprod + dattable.thumb_lo_nps_dotprod)/2;
dattable.thumb_mean_nps_cossim = (dattable.thumb_hi_nps_cossim + dattable.thumb_lo_nps_cossim)/2;
dattable.thumb_mean_nps_corr = (dattable.thumb_hi_nps_corr + dattable.thumb_lo_nps_corr)/2;
dattable.thumb_mean_meanpain = (dattable.thumb_hi_meanpain + dattable.thumb_lo_meanpain)/2;
dattable.sound_mean_nps_dotprod = (dattable.sound_hi_nps_dotprod + dattable.sound_lo_nps_dotprod)/2;
dattable.sound_mean_nps_cossim = (dattable.sound_hi_nps_cossim + dattable.sound_lo_nps_cossim)/2;
dattable.sound_mean_nps_corr = (dattable.sound_hi_nps_corr + dattable.sound_lo_nps_corr)/2;
dattable.sound_mean_meanpain = (dattable.sound_hi_meanpain + dattable.sound_lo_meanpain)/2;

dattable.Properties.VariableDescriptions{1} = 'Participant ID';
dattable.Properties.VariableDescriptions{2} = 'Group: 1 = PRT therapy, 2 = placebo, 3 = no treatment';
dattable.Properties.VariableDescriptions{3} = 'Session: 1 = baseline, 2 = 4 weeks post';
dattable.Properties.VariableDescriptions{4} = 'NPS dotproduct values for thumb 4 kg/cm2';
dattable.Properties.VariableDescriptions{5} = 'NPS cossim values for thumb 4 kg/cm2';
dattable.Properties.VariableDescriptions{6} = 'NPS corr values for thumb 4 kg/cm2';
dattable.Properties.VariableDescriptions{7} = 'NPS dotproduct values for thumb 7 kg/cm2';
dattable.Properties.VariableDescriptions{8} = 'NPS cossim values for thumb 7 kg/cm2';
dattable.Properties.VariableDescriptions{9} = 'NPS corr values for thumb 7 kg/cm2';

dattable.Properties.VariableDescriptions{10} = 'NPS dotproduct values for sound low';
dattable.Properties.VariableDescriptions{11} = 'NPS cossim values for sound low';
dattable.Properties.VariableDescriptions{12} = 'NPS corr values for sound low';
dattable.Properties.VariableDescriptions{13} = 'NPS dotproduct values for sound hig';
dattable.Properties.VariableDescriptions{14} = 'NPS cossim values for sound hig';
dattable.Properties.VariableDescriptions{15} = 'NPS corr values for sound hig';

dattable.Properties.VariableDescriptions{16} = 'Pain rating for thumb 4 kg/cm2';
dattable.Properties.VariableDescriptions{17} = 'Pain rating for thumb 7 kg/cm2';
dattable.Properties.VariableDescriptions{18} = 'Pain rating for sound low';
dattable.Properties.VariableDescriptions{19} = 'Pain rating for sound hig';

dattable.Properties.VariableDescriptions{20} = 'NPS dotproduct values for thumb High - Low, 7-4 kg/cm2';
dattable.Properties.VariableDescriptions{21} = 'NPS cossim values for thumb High - Low, 7-4 kg/cm2';
dattable.Properties.VariableDescriptions{22} = 'NPS corr values for thumb High - Low, 7-4 kg/cm2';
dattable.Properties.VariableDescriptions{23} = 'Pain rating for thumb High - Low, 7-4 kg/cm2';

dattable.Properties.VariableDescriptions{24} = 'NPS dotproduct values for sound High - Low';
dattable.Properties.VariableDescriptions{25} = 'NPS cossim values for sound High - Low';
dattable.Properties.VariableDescriptions{26} = 'NPS corr values for sound High - Low';
dattable.Properties.VariableDescriptions{27} = 'Pain rating for sound High - Low';

dattable.Properties.VariableDescriptions{28} = 'NPS dotproduct values for mean thumb High and Low, 7 and 4 kg/cm2';
dattable.Properties.VariableDescriptions{29} = 'NPS cossim values for mean thumb High and Low, 7 and 4 kg/cm2';
dattable.Properties.VariableDescriptions{30} = 'NPS corr values for mean thumb High and Low, 7 and 4 kg/cm2';
dattable.Properties.VariableDescriptions{31} = 'Pain rating for mean thumb High and Low, 7 and 4 kg/cm2';

dattable.Properties.VariableDescriptions{32} = 'NPS dotproduct values for mean sound High and Low';
dattable.Properties.VariableDescriptions{33} = 'NPS cossim values for mean sound High and Low';
dattable.Properties.VariableDescriptions{34} = 'NPS corr values for mean sound High and Low';
dattable.Properties.VariableDescriptions{35} = 'Pain rating for mean sound High and Low';

% save OLP_PRT_Ashar_NPS_test_retest_data_table dattable

%% Match participants for time 1, time 2
% ------------------------------------------------

t1 = dattable.time == 1;
t2 = dattable.time == 2;

id1 = dattable.id(t1);
id2 = dattable.id(t2);

[common_ids,IA,IB] = intersect(id1, id2);

idx = ismember(dattable.id, common_ids);
common_ids_idx = false(size(dattable.id));
common_ids_idx(idx) = true;

dattable.has_t1_t2 = common_ids_idx;
dattable(1:10, :)


t1final = dattable.has_t1_t2 & t1;
t2final = dattable.has_t1_t2 & t2;

% check for mismatches if we use these indices. 0 is good
any(diff([dattable.id(t1final) dattable.id(t2final)], [], 2))

t1table = dattable(t1final, :);
t2table = dattable(t2final, :);

fprintf('Participants with time 1 and time 2: %3.0f ', length(common_ids));

cd(savePath);
writetable(t1table,'Time1_data.csv')
writetable(t2table,'Time2_data.csv')
%% test-retest thumb
% ------------------------------------------------

create_figure('scatter', 4, 4); 
% nps dotproduct
subplot(4, 4, 1);

x = [t1table.thumb_lo_nps_dotprod t2table.thumb_lo_nps_dotprod];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 2);

x = [t1table.thumb_hi_nps_dotprod t2table.thumb_hi_nps_dotprod];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 3);

x = [t1table.thumb_hi_vs_lo_nps_dotprod t2table.thumb_hi_vs_lo_nps_dotprod];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 4);

x = [t1table.thumb_mean_nps_dotprod t2table.thumb_mean_nps_dotprod];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps dotproduct, ICC(3, k) = %3.2f', iccval));

% nps cossim
subplot(4, 4, 5);

x = [t1table.thumb_lo_nps_cossim t2table.thumb_lo_nps_cossim];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 6);

x = [t1table.thumb_hi_nps_cossim t2table.thumb_hi_nps_cossim];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 7);

x = [t1table.thumb_hi_vs_lo_nps_cossim t2table.thumb_hi_vs_lo_nps_cossim];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 8);

x = [t1table.thumb_mean_nps_cossim t2table.thumb_mean_nps_cossim];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps cossim, ICC(3, k) = %3.2f', iccval));

% nps corr
subplot(4, 4, 9);

x = [t1table.thumb_lo_nps_corr t2table.thumb_lo_nps_corr];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 10);

x = [t1table.thumb_hi_nps_corr t2table.thumb_hi_nps_corr];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 11);

x = [t1table.thumb_hi_vs_lo_nps_corr t2table.thumb_hi_vs_lo_nps_corr];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 12);

x = [t1table.thumb_mean_nps_corr t2table.thumb_mean_nps_corr];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps corr, ICC(3, k) = %3.2f', iccval));

% pain rating
subplot(4, 4, 13);

x = [t1table.thumb_lo_meanpain t2table.thumb_lo_meanpain];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 14);

x = [t1table.thumb_hi_meanpain t2table.thumb_hi_meanpain];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 15);

x = [t1table.thumb_hi_vs_lo_meanpain t2table.thumb_hi_vs_lo_meanpain];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 16);

x = [t1table.thumb_mean_meanpain t2table.thumb_mean_meanpain];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean pain rating, ICC(3, k) = %3.2f', iccval));

%% test-retest thumb: Therapy
% ------------------------------------------------

create_figure('scatter', 4, 4); 
% nps dotproduct
subplot(4, 4, 1);
wh1 = t1table.group == 1;
wh2 = t2table.group == 1;

x = [t1table.thumb_lo_nps_dotprod(wh1) t2table.thumb_lo_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 2);

x = [t1table.thumb_hi_nps_dotprod(wh1) t2table.thumb_hi_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 3);

x = [t1table.thumb_hi_vs_lo_nps_dotprod(wh1) t2table.thumb_hi_vs_lo_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 4);

x = [t1table.thumb_mean_nps_dotprod(wh1) t2table.thumb_mean_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps dotproduct, ICC(3, k) = %3.2f', iccval));

% nps cossim
subplot(4, 4, 5);

x = [t1table.thumb_lo_nps_cossim(wh1) t2table.thumb_lo_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 6);

x = [t1table.thumb_hi_nps_cossim(wh1) t2table.thumb_hi_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 7);

x = [t1table.thumb_hi_vs_lo_nps_cossim(wh1) t2table.thumb_hi_vs_lo_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 8);

x = [t1table.thumb_mean_nps_cossim(wh1) t2table.thumb_mean_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps cossim, ICC(3, k) = %3.2f', iccval));

% nps corr
subplot(4, 4, 9);

x = [t1table.thumb_lo_nps_corr(wh1) t2table.thumb_lo_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 10);

x = [t1table.thumb_hi_nps_corr(wh1) t2table.thumb_hi_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 11);

x = [t1table.thumb_hi_vs_lo_nps_corr(wh1) t2table.thumb_hi_vs_lo_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 12);

x = [t1table.thumb_mean_nps_corr(wh1) t2table.thumb_mean_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps corr, ICC(3, k) = %3.2f', iccval));

% pain rating
subplot(4, 4, 13);

x = [t1table.thumb_lo_meanpain(wh1) t2table.thumb_lo_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 14);

x = [t1table.thumb_hi_meanpain(wh1) t2table.thumb_hi_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 15);

x = [t1table.thumb_hi_vs_lo_meanpain(wh1) t2table.thumb_hi_vs_lo_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 16);

x = [t1table.thumb_mean_meanpain(wh1) t2table.thumb_mean_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean pain rating, ICC(3, k) = %3.2f', iccval));

%% test-retest thumb: Placebo
% ------------------------------------------------

create_figure('scatter', 4, 4); 
% nps dotproduct
subplot(4, 4, 1);
wh1 = t1table.group == 2;
wh2 = t2table.group == 2;

x = [t1table.thumb_lo_nps_dotprod(wh1) t2table.thumb_lo_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 2);

x = [t1table.thumb_hi_nps_dotprod(wh1) t2table.thumb_hi_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 3);

x = [t1table.thumb_hi_vs_lo_nps_dotprod(wh1) t2table.thumb_hi_vs_lo_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 4);

x = [t1table.thumb_mean_nps_dotprod(wh1) t2table.thumb_mean_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps dotproduct, ICC(3, k) = %3.2f', iccval));

% nps cossim
subplot(4, 4, 5);

x = [t1table.thumb_lo_nps_cossim(wh1) t2table.thumb_lo_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 6);

x = [t1table.thumb_hi_nps_cossim(wh1) t2table.thumb_hi_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 7);

x = [t1table.thumb_hi_vs_lo_nps_cossim(wh1) t2table.thumb_hi_vs_lo_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 8);

x = [t1table.thumb_mean_nps_cossim(wh1) t2table.thumb_mean_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps cossim, ICC(3, k) = %3.2f', iccval));

% nps corr
subplot(4, 4, 9);

x = [t1table.thumb_lo_nps_corr(wh1) t2table.thumb_lo_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 10);

x = [t1table.thumb_hi_nps_corr(wh1) t2table.thumb_hi_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 11);

x = [t1table.thumb_hi_vs_lo_nps_corr(wh1) t2table.thumb_hi_vs_lo_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 12);

x = [t1table.thumb_mean_nps_corr(wh1) t2table.thumb_mean_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean nps corr, ICC(3, k) = %3.2f', iccval));

% pain rating
subplot(4, 4, 13);

x = [t1table.thumb_lo_meanpain(wh1) t2table.thumb_lo_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 14);

x = [t1table.thumb_hi_meanpain(wh1) t2table.thumb_hi_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 15);

x = [t1table.thumb_hi_vs_lo_meanpain(wh1) t2table.thumb_hi_vs_lo_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi vs. low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 16);

x = [t1table.thumb_mean_meanpain(wh1) t2table.thumb_mean_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Thumb hi and low mean pain rating, ICC(3, k) = %3.2f', iccval));
%% test-retest thumb: Waitlies
% ------------------------------------------------

create_figure('scatter', 4, 4); 
% nps dotproduct
subplot(4, 4, 1);
wh1 = t1table.group == 3;
wh2 = t2table.group == 3;

x = [t1table.thumb_lo_nps_dotprod(wh1) t2table.thumb_lo_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 2);

x = [t1table.thumb_hi_nps_dotprod(wh1) t2table.thumb_hi_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 3);

x = [t1table.thumb_hi_vs_lo_nps_dotprod(wh1) t2table.thumb_hi_vs_lo_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi vs. low nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 4);

x = [t1table.thumb_mean_nps_dotprod(wh1) t2table.thumb_mean_nps_dotprod(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi and low mean nps dotproduct, ICC(3, k) = %3.2f', iccval));

% nps cossim
subplot(4, 4, 5);

x = [t1table.thumb_lo_nps_cossim(wh1) t2table.thumb_lo_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 6);

x = [t1table.thumb_hi_nps_cossim(wh1) t2table.thumb_hi_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 7);

x = [t1table.thumb_hi_vs_lo_nps_cossim(wh1) t2table.thumb_hi_vs_lo_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi vs. low nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 8);

x = [t1table.thumb_mean_nps_cossim(wh1) t2table.thumb_mean_nps_cossim(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi and low mean nps cossim, ICC(3, k) = %3.2f', iccval));

% nps corr
subplot(4, 4, 9);

x = [t1table.thumb_lo_nps_corr(wh1) t2table.thumb_lo_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 10);

x = [t1table.thumb_hi_nps_corr(wh1) t2table.thumb_hi_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 11);

x = [t1table.thumb_hi_vs_lo_nps_corr(wh1) t2table.thumb_hi_vs_lo_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi vs. low nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 12);

x = [t1table.thumb_mean_nps_corr(wh1) t2table.thumb_mean_nps_corr(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi and low mean nps corr, ICC(3, k) = %3.2f', iccval));

% pain rating
subplot(4, 4, 13);

x = [t1table.thumb_lo_meanpain(wh1) t2table.thumb_lo_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 14);

x = [t1table.thumb_hi_meanpain(wh1) t2table.thumb_hi_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 15);

x = [t1table.thumb_hi_vs_lo_meanpain(wh1) t2table.thumb_hi_vs_lo_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi vs. low pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 4, 16);

x = [t1table.thumb_mean_meanpain(wh1) t2table.thumb_mean_meanpain(wh2)];
x(sum(isnan(x), 2) == 1, :) = [];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'k', x);
title(sprintf('Thumb hi and low mean pain rating, ICC(3, k) = %3.2f', iccval));
%%
create_figure('scatter', 1, 3); 

subplot(1, 3, 1);

wh1 = t1table.group == 3 | t1table.group == 2;
wh2 = t2table.group == 3 | t2table.group == 2;

x = [t1table.thumb_lo(wh1) t2table.thumb_lo(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Waitlist+Placebo, Thumb low, ICC(3, k) = %3.2f', iccval));

subplot(1, 3, 2);

x = [t1table.thumb_hi(wh1) t2table.thumb_hi(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Waitlist+Placebo, Thumb hi, ICC(3, k) = %3.2f', iccval));

subplot(1, 3, 3);

x = [t1table.thumb_hi_v_lo(wh1) t2table.thumb_hi_v_lo(wh2)];
plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
iccval = ICC(3, 'single', x);
title(sprintf('Waitlist+Placebo, Thumb hi vs. low, ICC(3, k) = %3.2f', iccval));

disp('Note: we expect the highest ICC for high-intensity (painful) pressure')
disp('We also expect the highest ICC for waitlist group and possibly placebo')
disp('The most "pure test" is high, WL only');









% Load dataset and format into table
% ------------------------------------------------

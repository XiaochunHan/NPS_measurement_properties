clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
all_data = readtable(dataFile);
%% Correlation between Temperature and Pain
PAIN = single_trial_retrieve_data_all_studies(all_data, 'rating');
TEMP = single_trial_retrieve_data_all_studies(all_data, 'T');

X = TEMP;
Y = PAIN;
xname = 'Temperature';
yname = 'Pain';
figname = 'Temperature by Pain by study within subject';

[~, ~, within_r] = plugin_regress_within_subject(X, Y, figname);

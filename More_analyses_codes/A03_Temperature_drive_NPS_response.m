clear;clc;
addpath(genpath('./Osf_data'));
addpath(genpath('./Utils'));
addpath(genpath('./MATLAB/CanlabCore'));
dataFile = which('Single_trial_Study1-8.csv');
savedir = './FigureS1B_2_temperature_with_NPS_and_Pain';
all_data = readtable(dataFile);
%%
[uniq_study_id, ~, study_id] = unique(all_data.study_id,'rows','stable');
nstudies = length(uniq_study_id);
event_by_temp = {};

for i = 1:nstudies
    
    this_dat = all_data(i == study_id,:);
    [uniq_temp_id, ~, temp_id] = unique(this_dat.T,'rows','stable');
    
    for j = 1:length(uniq_temp_id)
        this_temp_dat = this_dat(j == temp_id,:);
        event_by_temp{i}{j} = this_temp_dat{:,find(strcmpi(this_temp_dat.Properties.VariableNames,'nps'))};
        
        if length(event_by_temp{i}{j})>15
           OUT.average_event_by_temp{i}(j) = nanmean(event_by_temp{i}{j}); 
           OUT.ste_event_by_temp{i}(j) = ste(event_by_temp{i}{j});
           OUT.temp_id{i}(j) = uniq_temp_id(j);
        end
    end

    [OUT.temp_id{i},I] = sort(OUT.temp_id{i});
    OUT.average_event_by_temp{i} = OUT.average_event_by_temp{i}(I);
    OUT.ste_event_by_temp{i} = OUT.ste_event_by_temp{i}(I);
end

%%
figure;
subplot(2,3,1);
plot(OUT.temp_id{1}, OUT.average_event_by_temp{1},'-*');
title('Study 1');
xlabel('Temperature');
ylabel('NPS');

subplot(2,3,2);
plot(OUT.temp_id{2}, OUT.average_event_by_temp{2},'-*');
title('Study 2');
xlabel('Temperature');
ylabel('NPS');

subplot(2,3,3);
plot(OUT.temp_id{3}, OUT.average_event_by_temp{3},'-*');
title('Study 3');
xlabel('Temperature');
ylabel('NPS');

subplot(2,3,4);
plot(OUT.temp_id{5}, OUT.average_event_by_temp{5},'-*');
title('Study 5');
xlabel('Temperature');
ylabel('NPS');

subplot(2,3,5);
plot(OUT.temp_id{6}, OUT.average_event_by_temp{6},'-*');
title('Study 6');
xlabel('Temperature');
ylabel('NPS');

subplot(2,3,6);
plot(OUT.temp_id{8}, OUT.average_event_by_temp{8},'-*');
title('Study 8');
xlabel('Temperature');
ylabel('NPS');
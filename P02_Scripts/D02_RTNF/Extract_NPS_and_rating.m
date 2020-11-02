clear;clc;
RatingPath = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D02_RTNF/P01_behavior_Raw/fMRI_behavioral';
ImgPath = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D02_RTNF/P03_con_all';
SavePath = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D02_RTNF/P05_result';
fnames = filenames(fullfile(ImgPath, 'sub-*con_0001.nii'));
tmpdat = fmri_data(fnames);
tmpdat = preprocess(tmpdat, 'smooth', 6);
%% Data check
histogram(get_wh_image(tmpdat, 1:81), 'byimage', 'by_tissue_type');
plot(tmpdat);
%% Second-level t test
t = ttest(tmpdat, .05, 'fdr');
figure;
obj = canlab_results_fmridisplay('compact2', 'overlay', 'icbm152_2009_symmetric_for_underlay.img' );
obj = removeblobs(obj);
obj = addblobs(obj, region(t), 'noverbose');
obj.title_montage(5, 'heat FDR<.05, smoothed w/ 6mm');
drawnow, snapnow
%% Extract NPS
vals = apply_nps(tmpdat, 'notables', 'noverbose');
vals_cos = apply_nps(tmpdat, 'notables', 'noverbose','cosine_similarity');
vals_corr = apply_nps(tmpdat, 'notables', 'noverbose','correlation');
npsvals(:,1) = vals{1};
npsvals(:,2) = vals_cos{1};
npsvals(:,3) = vals_corr{1};

npsvals = array2table(npsvals, 'VariableNames', {'dotProduct','cossim','corr'});

npsvals.subID = str2double(extractBetween(fnames,'sub-','-ses-'));
npsvals.sesID = str2double(extractBetween(fnames,'ses-','-con_'));
%% Extract Pain
cd(RatingPath);
subjects = unique(npsvals.subID,'stable');
rating = [];
for sub = 1:length(subjects)
    for ses = 2:4
        R = [];
        behFile = dir(['behav_sub',num2str(subjects(sub,1)),num2str(ses,'%.2d'),'_*']);
        for b = 1:length(behFile)
            load(behFile(b).name,'oratings');
            R = [R,oratings];
        end
        rating = [rating;mean(R)];
    end
end
npsvals.rating = rating;

%%
cd(SavePath);
writetable(npsvals,'RTNF_NPS_Rating_three_times.csv')
%% Cal ICC(3,1)
t1 = npsvals.sesID == 1;
t2 = npsvals.sesID == 2;
t3 = npsvals.sesID == 3;

t1final = npsvals(npsvals.sesID == 1,:);
t2final = npsvals(npsvals.sesID == 2,:);
t3final = npsvals(npsvals.sesID == 3,:);

% ------------------------------------------------

create_figure('scatter', 4, 3); 
% nps dotproduct
subplot(4, 3, 1);

x = [t1final.dotProduct t2final.dotProduct t3final.dotProduct];
iccval = ICC(3, 'single', x);

plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
title(sprintf('nps dotproduct, ICC(3, 1) = %3.2f', iccval));

subplot(4, 3, 2);

plot_correlation_samefig(x(:, 1), x(:, 3), [], 'ko');
xlabel('Session 1'); ylabel('Session 3');
title(sprintf('nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 3);

plot_correlation_samefig(x(:, 2), x(:, 3), [], 'ko');
xlabel('Session 2'); ylabel('Session 3');
title(sprintf('nps dotproduct, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 4);

x = [t1final.cossim t2final.cossim t3final.cossim];
iccval = ICC(3, 'single', x);

plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
title(sprintf('nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 5);

plot_correlation_samefig(x(:, 1), x(:, 3), [], 'ko');
xlabel('Session 1'); ylabel('Session 3');
title(sprintf('nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 6);

plot_correlation_samefig(x(:, 2), x(:, 3), [], 'ko');
xlabel('Session 2'); ylabel('Session 3');
title(sprintf('nps cossim, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 7);

x = [t1final.corr t2final.corr t3final.corr];
iccval = ICC(3, 'single', x);

plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
title(sprintf('nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 8);

plot_correlation_samefig(x(:, 1), x(:, 3), [], 'ko');
xlabel('Session 1'); ylabel('Session 3');
title(sprintf('nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 9);

plot_correlation_samefig(x(:, 2), x(:, 3), [], 'ko');
xlabel('Session 2'); ylabel('Session 3');
title(sprintf('nps corr, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 10);

x = [t1final.rating t2final.rating t3final.rating];
iccval = ICC(3, 'single', x);

plot_correlation_samefig(x(:, 1), x(:, 2), [], 'ko');
xlabel('Session 1'); ylabel('Session 2');
title(sprintf('Pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 11);

plot_correlation_samefig(x(:, 1), x(:, 3), [], 'ko');
xlabel('Session 1'); ylabel('Session 3');
title(sprintf('Pain rating, ICC(3, k) = %3.2f', iccval));

subplot(4, 3, 12);

plot_correlation_samefig(x(:, 2), x(:, 3), [], 'ko');
xlabel('Session 2'); ylabel('Session 3');
title(sprintf('Pain rating, ICC(3, k) = %3.2f', iccval));
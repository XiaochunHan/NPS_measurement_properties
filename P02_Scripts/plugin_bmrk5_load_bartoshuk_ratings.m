% Done in prep1_prep_data:
%
% wh_study = strncmp(studynames, 'bmrk5_painsound', length('bmrk5_painsound'));
% DAT = study_canlab_dataset{wh_study};
% S = studymetadata{wh_study};


ratingnames = { ...
    'Brightness_Room' 'Brightness_Restaurant' 'Brightest_Light' ... 
    'Loudness_Whisper' 'Loudness_Conversation' 'Loudest_Sound' ...
    'Warmth_Bread' 'Smell_Flower' 'Sweetness_Coke' 'Bitterness_Celery' ...
    'Saltiness_Strongest' 'Sweetness_Strongest' 'Sourness_Strongest' ...
    'Oral_Burn_Strongest' 'Oran_Pain_Strongest' 'Sweetness_Candy' ...
    };

%% Prep variables

clear ratingdata

for i = 1:length(ratingnames)
    
    myvar = S.(ratingnames{i});
    
    if iscell(myvar)
       
        myvar = cat(1, myvar{:});
        
    end
    
    if ~iscolumn(myvar), myvar = myvar'; end
                  
    ratingdata(:, i) = myvar;
    
end % ratings  

%% Prep pain and NPS for exploratory analyses

npscos = get_var(DAT, 'NPS_cosine_similarity_none');

nps2 = get_var(DAT, 'NPS_cosine_similarity_none', 'conditional', {'pain_or_sound', 1});
nps2 = nanmean(nps2')'; % identical to NPS mean

pain2 = get_var(DAT, 'ratings', 'conditional', {'pain_or_sound', 1});
pain2 = nanmean(pain2')'; % virtually identical with painmean

whitemean = get_var(DAT, 'White_Mean', 'conditional', {'pain_or_sound', 1});
whitemean = nanmean(whitemean')'; 

CSFmean = get_var(DAT, 'CSF_Mean', 'conditional', {'pain_or_sound', 1});
CSFmean = nanmean(CSFmean')'; 

for j = 1:length(S.ratings)
    
    whpain = S.pain_or_sound{j} == 1;
    
    painmean(j, 1) = nanmean(S.ratings{j}(whpain));
    
    npsmean(j, 1) = nanmean(npscos(j, whpain));
    
end

[wasnan, painmean_nonan, npsmean_nonan, ratingdata_nonan, whitemean, CSFmean] = nanremove(painmean, npsmean, ratingdata, whitemean, CSFmean);

%% Add vars to dataset

DAT = add_vars(DAT, ratingdata, 'Subj_Level', 'names', ratingnames);


%% Exploratory regression

disp('Predicting pain')
[B,SE,PVAL,INMODEL,STATS] = stepwisefit(ratingdata_nonan, painmean_nonan, 'penter',.1);
ratingnames(INMODEL)
B(INMODEL)

disp('Predicting NPS')
[B,SE,PVAL,INMODEL,STATS] = stepwisefit(ratingdata_nonan, npsmean_nonan, 'penter',.1);
ratingnames(INMODEL)
B(INMODEL)

%% PCA regression

disp(' ')
disp('Predicting Pain from PCA of Bartoshuk ratings')

[coeff, score, latent, tsquare] = princomp(ratingdata_nonan);

[B,DEV,STATS] = glmfit(score, painmean_nonan);
glm_table(STATS);

disp(' ')
disp('Predicting Pain from NPS and first component of Bartoshuk ratings')

[B,DEV,STATS] = glmfit([score(:, 1) npsmean_nonan whitemean CSFmean], painmean_nonan);

glm_table(STATS, {'Bartoshuk_ratings' 'NPScosine' 'Whitemean' 'CSFmean'});

disp(' ')
disp('Predicting NPS from first component of Bartoshuk ratings, white, CSF')

[B,DEV,STATS] = glmfit([painmean_nonan whitemean CSFmean], npsmean_nonan);

glm_table(STATS, {'Pain ratings' 'Whitemean' 'CSFmean'});


X = [score(:, 1) npsmean_nonan]; 

disp('Partial correlation of Pain and first component of Bartoshuk ratings controlling NPS')
[x,y,r,p,se,meany,stats] = partialcor(X, painmean_nonan, 1, 1);

disp('Partial correlation of Pain and NPS controlling Barto')
[x,y,r,p,se,meany,stats] = partialcor(X, painmean_nonan, 2, 1);

disp('Partial correlation of Pain and NPS controlling Barto white CSF means')
X = [score(:, 1) npsmean_nonan whitemean CSFmean]; 
[x,y,r,p,se,meany,stats] = partialcor(X, painmean_nonan, 2, 1);




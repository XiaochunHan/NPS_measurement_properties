clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
% st_datasets = {'nsf','bmrk3pain','bmrk3warm','bmrk4','bmrk5pain',...
%     'bmrk5snd','remi','scebl','ie2','ie','exp','levoderm',...
%     'romantic','ilcp','stephan'};

st_datasets = {'nsf','bmrk3pain','bmrk4','bmrk5pain',...
    'remi','scebl','ie2','ie','exp','ilcp'};

all_data = [];
for s = 1:length(st_datasets)
    cd(Path);
    if exist(['metadata_',st_datasets{s},'.mat'],'file')
        load(['metadata_',st_datasets{s},'.mat']);
        meta_data.study_id = repmat(st_datasets(s),height(meta_data),1);
    else
        this_dat = load_image_set(st_datasets{s});
        meta_data = extract_nps(this_dat);
        save(['metadata_',st_datasets{s},'.mat'],'meta_data');
    end
    if s == 1
       all_data = meta_data;
    else
       all_data = outerjoin(all_data,meta_data,'MergeKeys', true);
    end
end
cd(Path);
all_data = sortrows(all_data, [117 6 5 4]);
save('metadata_all_valid.mat','all_data');
clear meta_data s;
%% EXTRACT NPS
function metadata = extract_nps(dat)
% exclude trials with high vifs
if ismember('high_vif', dat.metadata_table.Properties.VariableNames)
   dat.metadata_table = dat.metadata_table(dat.metadata_table.high_vif ~= 1,:);
end

refmask = fmri_data(which('brainmask.nii'));  % shell image
nps = which('weights_NSF_grouppred_cvpcr.img');
npspos = which('weights_NSF_positive_smoothed_larger_than_10vox.img');
npsneg = which('weights_NSF_negative_smoothed_larger_than_10vox.img');
posnames = {'vermis'    'rIns'    'rV1'    'rThal'    'lIns'    'rdpIns'    'rS2_Op'    'dACC'};
negnames = {'rLOC'    'lLOC'    'rpLOC'    'pgACC'    'lSTS'    'rIPL'    'PCC'};

npsw = resample_space(fmri_data(nps), refmask);
npsposw = resample_space(fmri_data(npspos), refmask);
npsnegw = resample_space(fmri_data(npsneg), refmask);

nps_values = apply_mask(dat, npsw, 'pattern_expression', 'ignore_missing');
nps_corr_values = apply_mask(dat, npsw, 'pattern_expression', 'correlation', 'ignore_missing');
nps_cosine_values = apply_mask(dat, npsw, 'pattern_expression', 'cosine_similarity', 'ignore_missing');

npspos_values = apply_mask(dat, npsposw, 'pattern_expression', 'ignore_missing');
npspos_corr_values = apply_mask(dat, npsposw, 'pattern_expression', 'correlation', 'ignore_missing');
npspos_cosine_values = apply_mask(dat, npsposw, 'pattern_expression', 'cosine_similarity', 'ignore_missing');

npsneg_values = apply_mask(dat, npsnegw, 'pattern_expression', 'ignore_missing');
npsneg_corr_values = apply_mask(dat, npsnegw, 'pattern_expression', 'correlation', 'ignore_missing');
npsneg_cosine_values = apply_mask(dat, npsnegw, 'pattern_expression', 'cosine_similarity', 'ignore_missing');

all_dat2 = resample_space(dat, npspos);
clpos = extract_roi_averages(all_dat2, npspos, 'pattern_expression', 'contiguous_regions', 'nonorm');
clpos_corr = extract_roi_averages(all_dat2, npspos, 'pattern_expression', 'correlation', 'contiguous_regions', 'nonorm');
clpos_cosine = extract_roi_averages(all_dat2, npspos, 'pattern_expression', 'cosine_similarity', 'contiguous_regions', 'nonorm');
npspos_exp_by_region = cat(2, clpos.dat);
npspos_corr_exp_by_region = cat(2, clpos_corr.dat);
npspos_cosine_exp_by_region = cat(2, clpos_cosine.dat);

clneg = extract_roi_averages(all_dat2, npsneg, 'pattern_expression', 'contiguous_regions', 'nonorm');
clneg_corr = extract_roi_averages(all_dat2, npsneg, 'pattern_expression', 'correlation', 'contiguous_regions', 'nonorm');
clneg_cosine = extract_roi_averages(all_dat2, npsneg, 'pattern_expression', 'cosine_similarity', 'contiguous_regions', 'nonorm');
npsneg_exp_by_region = cat(2, clneg.dat);
npsneg_corr_exp_by_region = cat(2, clneg_corr.dat);
npsneg_cosine_exp_by_region = cat(2, clneg_cosine.dat);

dat.metadata_table.nps = nps_values;
dat.metadata_table.nps_corr = nps_corr_values;
dat.metadata_table.nps_cosine = nps_cosine_values;

dat.metadata_table.npspos = npspos_values;
dat.metadata_table.npspos_corr = npspos_corr_values;
dat.metadata_table.npspos_cosine = npspos_cosine_values;

dat.metadata_table.npsneg = npsneg_values;
dat.metadata_table.npsneg_corr = npsneg_corr_values;
dat.metadata_table.npsneg_cosine = npsneg_cosine_values;

% zcore
zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));
if ~isempty(find(strcmpi(dat.metadata_table.Properties.VariableNames,'T')))
   dat.metadata_table.zT = zscor_xnan(dat.metadata_table.T);
end
dat.metadata_table.zrating = zscor_xnan(dat.metadata_table.rating);

dat.metadata_table.znps = zscor_xnan(dat.metadata_table.nps);
dat.metadata_table.znps_corr = zscor_xnan(dat.metadata_table.nps_corr);
dat.metadata_table.znps_cosine = zscor_xnan(dat.metadata_table.nps_cosine);

dat.metadata_table.znpspos = zscor_xnan(dat.metadata_table.npspos);
dat.metadata_table.znpspos_corr = zscor_xnan(dat.metadata_table.npspos_corr);
dat.metadata_table.znpspos_cosine = zscor_xnan(dat.metadata_table.npspos_cosine);

dat.metadata_table.znpsneg = zscor_xnan(dat.metadata_table.npsneg);
dat.metadata_table.znpsneg_corr = zscor_xnan(dat.metadata_table.npsneg_corr);
dat.metadata_table.znpsneg_cosine = zscor_xnan(dat.metadata_table.npsneg_cosine);

for p = 1:length(posnames)
    pos_value_name = ['pos_nps_',posnames{p}];
    pos_corr_name = ['pos_nps_',posnames{p},'_corr'];
    pos_cosine_name = ['pos_nps_',posnames{p},'_cosine'];
    zpos_value_name = ['zpos_nps_',posnames{p}];
    zpos_corr_name = ['zpos_nps_',posnames{p},'_corr'];
    zpos_cosine_name = ['zpos_nps_',posnames{p},'_cosine'];
    dat.metadata_table.pos_value_name = npspos_exp_by_region(:,p);
    dat.metadata_table.pos_corr_name = npspos_corr_exp_by_region(:,p);
    dat.metadata_table.pos_cosine_name = npspos_cosine_exp_by_region(:,p);
    dat.metadata_table.zpos_value_name = zscor_xnan(npspos_exp_by_region(:,p));
    dat.metadata_table.zpos_corr_name = zscor_xnan(npspos_corr_exp_by_region(:,p));
    dat.metadata_table.zpos_cosine_name = zscor_xnan(npspos_cosine_exp_by_region(:,p));
end

for n = 1:length(negnames)
    neg_value_name = ['neg_nps_',negnames{n}];
    neg_corr_name = ['neg_nps_',negnames{n},'_corr'];
    neg_cosine_name = ['neg_nps_',negnames{n},'_cosine'];
    zneg_value_name = ['zneg_nps_',negnames{n}];
    zneg_corr_name = ['zneg_nps_',negnames{n},'_corr'];
    zneg_cosine_name = ['zneg_nps_',negnames{n},'_cosine'];
    dat.metadata_table.neg_value_name = npsneg_exp_by_region(:,n);
    dat.metadata_table.neg_corr_name = npsneg_corr_exp_by_region(:,n);
    dat.metadata_table.neg_cosine_name = npsneg_cosine_exp_by_region(:,n);
    dat.metadata_table.zneg_value_name = zscor_xnan(npsneg_exp_by_region(:,n));
    dat.metadata_table.zneg_corr_name = zscor_xnan(npsneg_corr_exp_by_region(:,n));
    dat.metadata_table.zneg_cosine_name = zscor_xnan(npsneg_cosine_exp_by_region(:,n));
end

metadata = dat.metadata_table;
end
%% EXTRACT SIIPS
function metadata = extract_siips(dat)
% exclude trials with high vifs
if ismember('high_vif', dat.metadata_table.Properties.VariableNames)
   dat.metadata_table = dat.metadata_table(dat.metadata_table.high_vif ~= 1,:);
end

refmask = fmri_data(which('brainmask.nii'));  % shell image
siips = which('nonnoc_v11_4_137subjmap_weighted_mean.nii');
[siipspos, siipsneg, ~, ~, names_pos, names_neg, ~] = load_siips_subregions();

siipsw = resample_space(fmri_data(siips), refmask);
siipsposw = resample_space(siipspos, refmask);
siipsnegw = resample_space(siipsneg, refmask);

siips_values = apply_mask(dat, siipsw, 'pattern_expression', 'ignore_missing');
siips_corr_values = apply_mask(dat, siipsw, 'pattern_expression', 'correlation', 'ignore_missing');
siips_cosine_values = apply_mask(dat, siipsw, 'pattern_expression', 'cosine_similarity', 'ignore_missing');

siipspos_values = apply_mask(dat, siipsposw, 'pattern_expression', 'ignore_missing');
siipspos_corr_values = apply_mask(dat, siipsposw, 'pattern_expression', 'correlation', 'ignore_missing');
siipspos_cosine_values = apply_mask(dat, siipsposw, 'pattern_expression', 'cosine_similarity', 'ignore_missing');

siipsneg_values = apply_mask(dat, siipsnegw, 'pattern_expression', 'ignore_missing');
siipsneg_corr_values = apply_mask(dat, siipsnegw, 'pattern_expression', 'correlation', 'ignore_missing');
siipsneg_cosine_values = apply_mask(dat, siipsnegw, 'pattern_expression', 'cosine_similarity', 'ignore_missing');

all_dat2 = resample_space(dat, siipspos);
clpos = extract_roi_averages(all_dat2, siipspos, 'pattern_expression', 'contiguous_regions', 'nonorm');
clpos_corr = extract_roi_averages(all_dat2, siipspos, 'pattern_expression', 'correlation', 'contiguous_regions', 'nonorm');
clpos_cosine = extract_roi_averages(all_dat2, siipspos, 'pattern_expression', 'cosine_similarity', 'contiguous_regions', 'nonorm');
siipspos_exp_by_region = cat(2, clpos.dat);
siipspos_corr_exp_by_region = cat(2, clpos_corr.dat);
siipspos_cosine_exp_by_region = cat(2, clpos_cosine.dat);

clneg = extract_roi_averages(all_dat2, siipsneg, 'pattern_expression', 'contiguous_regions', 'nonorm');
clneg_corr = extract_roi_averages(all_dat2, siipsneg, 'pattern_expression', 'correlation', 'contiguous_regions', 'nonorm');
clneg_cosine = extract_roi_averages(all_dat2, siipsneg, 'pattern_expression', 'cosine_similarity', 'contiguous_regions', 'nonorm');
siipsneg_exp_by_region = cat(2, clneg.dat);
siipsneg_corr_exp_by_region = cat(2, clneg_corr.dat);
siipsneg_cosine_exp_by_region = cat(2, clneg_cosine.dat);

dat.metadata_table.siips = siips_values;
dat.metadata_table.siips_corr = siips_corr_values;
dat.metadata_table.siips_cosine = siips_cosine_values;

dat.metadata_table.siipspos = siipspos_values;
dat.metadata_table.siipspos_corr = siipspos_corr_values;
dat.metadata_table.siipspos_cosine = siipspos_cosine_values;

dat.metadata_table.siipsneg = siipsneg_values;
dat.metadata_table.siipsneg_corr = siipsneg_corr_values;
dat.metadata_table.siipsneg_cosine = siipsneg_cosine_values;

% zcore
zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));

dat.metadata_table.zsiips = zscor_xnan(dat.metadata_table.siips);
dat.metadata_table.zsiips_corr = zscor_xnan(dat.metadata_table.siips_corr);
dat.metadata_table.zsiips_cosine = zscor_xnan(dat.metadata_table.siips_cosine);

dat.metadata_table.zsiipspos = zscor_xnan(dat.metadata_table.siipspos);
dat.metadata_table.zsiipspos_corr = zscor_xnan(dat.metadata_table.siipspos_corr);
dat.metadata_table.zsiipspos_cosine = zscor_xnan(dat.metadata_table.siipspos_cosine);

dat.metadata_table.zsiipsneg = zscor_xnan(dat.metadata_table.siipsneg);
dat.metadata_table.zsiipsneg_corr = zscor_xnan(dat.metadata_table.siipsneg_corr);
dat.metadata_table.zsiipsneg_cosine = zscor_xnan(dat.metadata_table.siipsneg_cosine);

for p = 1:length(names_pos)
    pos_value_name = ['pos_siips_',names_pos{p}];
    pos_corr_name = ['pos_siips_',names_pos{p},'_corr'];
    pos_cosine_name = ['pos_siips_',names_pos{p},'_cosine'];
    zpos_value_name = ['zpos_siips_',names_pos{p}];
    zpos_corr_name = ['zpos_siips_',names_pos{p},'_corr'];
    zpos_cosine_name = ['zpos_siips_',names_pos{p},'_cosine'];
    dat.metadata_table.pos_value_name = siipspos_exp_by_region(:,p);
    dat.metadata_table.pos_corr_name = siipspos_corr_exp_by_region(:,p);
    dat.metadata_table.pos_cosine_name = siipspos_cosine_exp_by_region(:,p);
    dat.metadata_table.zpos_value_name = zscor_xnan(siipspos_exp_by_region(:,p));
    dat.metadata_table.zpos_corr_name = zscor_xnan(siipspos_corr_exp_by_region(:,p));
    dat.metadata_table.zpos_cosine_name = zscor_xnan(siipspos_cosine_exp_by_region(:,p));
end

for n = 1:length(names_neg)
    neg_value_name = ['neg_siips_',names_neg{n}];
    neg_corr_name = ['neg_siips_',names_neg{n},'_corr'];
    neg_cosine_name = ['neg_siips_',names_neg{n},'_cosine'];
    zneg_value_name = ['zneg_siips_',names_neg{n}];
    zneg_corr_name = ['zneg_siips_',names_neg{n},'_corr'];
    zneg_cosine_name = ['zneg_siips_',names_neg{n},'_cosine'];
    dat.metadata_table.neg_value_name = siipsneg_exp_by_region(:,n);
    dat.metadata_table.neg_corr_name = siipsneg_corr_exp_by_region(:,n);
    dat.metadata_table.neg_cosine_name = siipsneg_cosine_exp_by_region(:,n);
    dat.metadata_table.zneg_value_name = zscor_xnan(siipsneg_exp_by_region(:,n));
    dat.metadata_table.zneg_corr_name = zscor_xnan(siipsneg_corr_exp_by_region(:,n));
    dat.metadata_table.zneg_cosine_name = zscor_xnan(siipsneg_cosine_exp_by_region(:,n));
end

metadata = dat.metadata_table;
end
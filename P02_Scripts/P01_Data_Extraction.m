clear;clc;
Path = '/Users/spring/Dropbox (Dartmouth College)/Single_trial_dataset/canlab_single_trials_for_git_repo';
st_datasets = {'nsf','bmrk3pain','bmrk3warm','bmrk4','bmrk5pain',...
    'bmrk5snd','remi','scebl','ie2','ie','exp','levoderm',...
    'romantic','ilcp'};

all_data = [];
for s = 1:length(st_datasets)
    cd(Path);
    if exist(['metadata_',st_datasets{s},'.mat'],'file')
        load(['metadata_',st_datasets{s},'.mat']);
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
all_data = sortrows(all_data, [6 5 4]);
save('metadata_all.mat','all_data');
%% EXTRACT NPS
function metadata = extract_nps(dat)
refmask = fmri_data(which('brainmask.nii'));  % shell image
nps = which('weights_NSF_grouppred_cvpcr.img');
npspos = which('weights_NSF_positive_smoothed_larger_than_10vox.img');
npsneg = which('weights_NSF_negative_smoothed_larger_than_10vox.img');
% posnames = {'vermis'    'rIns'    'rV1'    'rThal'    'lIns'    'rdpIns'    'rS2_Op'    'dACC'};
% negnames = {'rLOC'    'lLOC'    'rpLOC'    'pgACC'    'lSTS'    'rIPL'    'PCC'};

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

dat.metadata_table.pos_vermis = npspos_exp_by_region(:,1);
dat.metadata_table.pos_vermis_corr = npspos_corr_exp_by_region(:,1);
dat.metadata_table.pos_vermis_cosine = npspos_cosine_exp_by_region(:,1);

dat.metadata_table.pos_rIns = npspos_exp_by_region(:,2);
dat.metadata_table.pos_rIns_corr = npspos_corr_exp_by_region(:,2);
dat.metadata_table.pos_rIns_cosine = npspos_cosine_exp_by_region(:,2);

dat.metadata_table.pos_rV1 = npspos_exp_by_region(:,3);
dat.metadata_table.pos_rV1_corr = npspos_corr_exp_by_region(:,3);
dat.metadata_table.pos_rV1_cosine = npspos_cosine_exp_by_region(:,3);

dat.metadata_table.pos_rThal = npspos_exp_by_region(:,4);
dat.metadata_table.pos_rThal_corr = npspos_corr_exp_by_region(:,4);
dat.metadata_table.pos_rThal_cosine = npspos_cosine_exp_by_region(:,4);

dat.metadata_table.pos_lIns = npspos_exp_by_region(:,5);
dat.metadata_table.pos_lIns_corr = npspos_corr_exp_by_region(:,5);
dat.metadata_table.pos_lIns_cosine = npspos_cosine_exp_by_region(:,5);

dat.metadata_table.pos_rdpIns = npspos_exp_by_region(:,6);
dat.metadata_table.pos_rdpIns_corr = npspos_corr_exp_by_region(:,6);
dat.metadata_table.pos_rdpIns_cosine = npspos_cosine_exp_by_region(:,6);

dat.metadata_table.pos_rS2_Op = npspos_exp_by_region(:,7);
dat.metadata_table.pos_rS2_Op_corr = npspos_corr_exp_by_region(:,7);
dat.metadata_table.pos_rS2_Op_cosine = npspos_cosine_exp_by_region(:,7);

dat.metadata_table.pos_dACC = npspos_exp_by_region(:,8);
dat.metadata_table.pos_dACC_corr = npspos_corr_exp_by_region(:,8);
dat.metadata_table.pos_dACC_cosine = npspos_cosine_exp_by_region(:,8);

dat.metadata_table.neg_rLOC = npsneg_exp_by_region(:,1);
dat.metadata_table.neg_rLOC_corr = npsneg_corr_exp_by_region(:,1);
dat.metadata_table.neg_rLOC_cosine = npsneg_cosine_exp_by_region(:,1);

dat.metadata_table.neg_lLOC = npsneg_exp_by_region(:,2);
dat.metadata_table.neg_lLOC_corr = npsneg_corr_exp_by_region(:,2);
dat.metadata_table.neg_lLOC_cosine = npsneg_cosine_exp_by_region(:,2);

dat.metadata_table.neg_rpLOC = npsneg_exp_by_region(:,3);
dat.metadata_table.neg_rpLOC_corr = npsneg_corr_exp_by_region(:,3);
dat.metadata_table.neg_rpLOC_cosine = npsneg_cosine_exp_by_region(:,3);

dat.metadata_table.neg_pgACC = npsneg_exp_by_region(:,4);
dat.metadata_table.neg_pgACC_corr = npsneg_corr_exp_by_region(:,4);
dat.metadata_table.neg_pgACC_cosine = npsneg_cosine_exp_by_region(:,4);

dat.metadata_table.neg_lSTS = npsneg_exp_by_region(:,5);
dat.metadata_table.neg_lSTS_corr = npsneg_corr_exp_by_region(:,5);
dat.metadata_table.neg_lSTS_cosine = npsneg_cosine_exp_by_region(:,5);

dat.metadata_table.neg_rIPL = npsneg_exp_by_region(:,6);
dat.metadata_table.neg_rIPL_corr = npsneg_corr_exp_by_region(:,6);
dat.metadata_table.neg_rIPL_cosine = npsneg_cosine_exp_by_region(:,6);

dat.metadata_table.neg_PCC = npsneg_exp_by_region(:,7);
dat.metadata_table.neg_PCC_corr = npsneg_corr_exp_by_region(:,7);
dat.metadata_table.neg_PCC_cosine = npsneg_cosine_exp_by_region(:,7);

% exclude trials with high vifs
if ismember('high_vif', dat.metadata_table.Properties.VariableNames)
   dat.metadata_table = dat.metadata_table(dat.metadata_table.high_vif ~= 1,:);
end

% zcore
zscor_xnan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));

dat.metadata_table.zT = zscor_xnan(dat.metadata_table.T);
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

dat.metadata_table.pos_zvermis = zscor_xnan(dat.metadata_table.pos_vermis);
dat.metadata_table.pos_zvermis_corr = zscor_xnan(dat.metadata_table.pos_vermis_corr);
dat.metadata_table.pos_zvermis_cosine = zscor_xnan(dat.metadata_table.pos_vermis_cosine);

dat.metadata_table.pos_zrIns = zscor_xnan(dat.metadata_table.pos_rIns);
dat.metadata_table.pos_zrIns_corr = zscor_xnan(dat.metadata_table.pos_rIns_corr);
dat.metadata_table.pos_zrIns_cosine = zscor_xnan(dat.metadata_table.pos_rIns_cosine);

dat.metadata_table.pos_zrV1 = zscor_xnan(dat.metadata_table.pos_rV1);
dat.metadata_table.pos_zrV1_corr = zscor_xnan(dat.metadata_table.pos_rV1_corr);
dat.metadata_table.pos_zrV1_cosine = zscor_xnan(dat.metadata_table.pos_rV1_cosine);

dat.metadata_table.pos_zrThal = zscor_xnan(dat.metadata_table.pos_rThal);
dat.metadata_table.pos_zrThal_corr = zscor_xnan(dat.metadata_table.pos_rThal_corr);
dat.metadata_table.pos_zrThal_cosine = zscor_xnan(dat.metadata_table.pos_rThal_cosine);

dat.metadata_table.pos_zlIns = zscor_xnan(dat.metadata_table.pos_lIns);
dat.metadata_table.pos_zlIns_corr = zscor_xnan(dat.metadata_table.pos_lIns_corr);
dat.metadata_table.pos_zlIns_cosine = zscor_xnan(dat.metadata_table.pos_lIns_cosine);

dat.metadata_table.pos_zrdpIns = zscor_xnan(dat.metadata_table.pos_rdpIns);
dat.metadata_table.pos_zrdpIns_corr = zscor_xnan(dat.metadata_table.pos_rdpIns_corr);
dat.metadata_table.pos_zrdpIns_cosine = zscor_xnan(dat.metadata_table.pos_rdpIns_cosine);

dat.metadata_table.pos_zrS2_Op = zscor_xnan(dat.metadata_table.pos_rS2_Op);
dat.metadata_table.pos_zrS2_Op_corr = zscor_xnan(dat.metadata_table.pos_rS2_Op_corr);
dat.metadata_table.pos_zrS2_Op_cosine = zscor_xnan(dat.metadata_table.pos_rS2_Op_cosine);

dat.metadata_table.pos_zdACC = zscor_xnan(dat.metadata_table.pos_dACC);
dat.metadata_table.pos_zdACC_corr = zscor_xnan(dat.metadata_table.pos_dACC_corr);
dat.metadata_table.pos_zdACC_cosine = zscor_xnan(dat.metadata_table.pos_dACC_cosine);

dat.metadata_table.neg_zrLOC = zscor_xnan(dat.metadata_table.neg_rLOC);
dat.metadata_table.neg_zrLOC_corr = zscor_xnan(dat.metadata_table.neg_rLOC_corr);
dat.metadata_table.neg_zrLOC_cosine = zscor_xnan(dat.metadata_table.neg_rLOC_cosine);

dat.metadata_table.neg_zlLOC = zscor_xnan(dat.metadata_table.neg_lLOC);
dat.metadata_table.neg_zlLOC_corr = zscor_xnan(dat.metadata_table.neg_lLOC_corr);
dat.metadata_table.neg_zlLOC_cosine = zscor_xnan(dat.metadata_table.neg_lLOC_cosine);

dat.metadata_table.neg_zrpLOC = zscor_xnan(dat.metadata_table.neg_rpLOC);
dat.metadata_table.neg_zrpLOC_corr = zscor_xnan(dat.metadata_table.neg_rpLOC_corr);
dat.metadata_table.neg_zrpLOC_cosine = zscor_xnan(dat.metadata_table.neg_rpLOC_cosine);

dat.metadata_table.neg_zpgACC = zscor_xnan(dat.metadata_table.neg_pgACC);
dat.metadata_table.neg_zpgACC_corr = zscor_xnan(dat.metadata_table.neg_pgACC_corr);
dat.metadata_table.neg_zpgACC_cosine = zscor_xnan(dat.metadata_table.neg_pgACC_cosine);

dat.metadata_table.neg_zlSTS = zscor_xnan(dat.metadata_table.neg_lSTS);
dat.metadata_table.neg_zlSTS_corr = zscor_xnan(dat.metadata_table.neg_lSTS_corr);
dat.metadata_table.neg_zlSTS_cosine = zscor_xnan(dat.metadata_table.neg_lSTS_cosine);

dat.metadata_table.neg_zrIPL = zscor_xnan(dat.metadata_table.neg_rIPL);
dat.metadata_table.neg_zrIPL_corr = zscor_xnan(dat.metadata_table.neg_rIPL_corr);
dat.metadata_table.neg_zrIPL_cosine = zscor_xnan(dat.metadata_table.neg_rIPL_cosine);

dat.metadata_table.neg_zPCC = zscor_xnan(dat.metadata_table.neg_PCC);
dat.metadata_table.neg_zPCC_corr = zscor_xnan(dat.metadata_table.neg_PCC_corr);
dat.metadata_table.neg_zPCC_cosine = zscor_xnan(dat.metadata_table.neg_PCC_cosine);

metadata = dat.metadata_table;
end
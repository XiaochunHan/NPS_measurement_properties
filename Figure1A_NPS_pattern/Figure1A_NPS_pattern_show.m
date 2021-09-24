clear;clc;close all;
addpath(genpath('./MATLAB/CanlabCore'));
addpath(genpath('./MATLAB/MasksPrivate'));

nps_raw = fmri_data(which('weights_NSF_grouppred_cvpcr.img'));
nps_fdr = fmri_data(which('weights_NSF_grouppred_cvpcr_FDR05.img'));
overlay = which('keuken_2014_enhanced_for_underlay.img');
%% Axial view NPS
figure;
o2 = fmridisplay;
o2 = montage(o2, 'axial', 'slice_range', [-24 50], 'onerow', 'spacing', 10);
o2=addblobs(o2,region(nps_fdr));
snapnow
%% Saggital view NPS
figure;
o2 = fmridisplay('overlay', overlay);
axh1 = axes('Position', [-0.00 0.4 .17 .17]);
o2 = montage(o2, 'saggital', 'wh_slice', [-4 0 0], 'onerow', 'noverbose', 'existing_axes', axh1);
o2=addblobs(o2,region(nps_fdr));
text(50, -50, 'left');
drawnow

axh2 = axes('Position', [-0.00 0.6 .17 .17]);
o2 = montage(o2, 'saggital', 'wh_slice', [4 0 0], 'onerow', 'noverbose', 'existing_axes', axh2);
o2=addblobs(o2,region(nps_fdr));
text(50, -50, 'right');
drawnow

axh3 = axes('Position', [.10 0.5 .17 .17]);
o2 = montage(o2, 'saggital', 'wh_slice', [0 0 0], 'onerow', 'noverbose', 'existing_axes', axh3);
drawnow;
o2.montage{3}.slice_mm_coords;

axes(o2.montage{3}.axis_handles)
locs = -24:10:50;
for i = 1:length(locs)
    hh(i) = plot( [-105 65], [locs(i) locs(i)], 'b', 'LineWidth', 1);
end
%% Voxel pattern map: dACC/SMA -> x/y/z = 2/4/34
dat_sig = statistic_image;
dat_sig.dat = nps_raw.dat;
dat_sig.sig = nps_fdr.dat ~=0;
dat_sig.volInfo = nps_raw.volInfo;
 
x = [-5 5]; 
y = [-30 40];  
z = [20 50]; 
 
vox = voxel2mm(dat_sig.volInfo.xyzlist', dat_sig.volInfo.mat);
vox = vox';
idx1 = vox(:,2)> y(1) & vox(:,2)< y(2);
idx2 = vox(:,1)> x(1) & vox(:,1)< x(2);
idx3 = vox(:,3)> z(1) & vox(:,3)< z(2);
 
idx = idx1 & idx2 & idx3;
 
dat = dat_sig;
dat.dat = dat.dat(idx);
dat.sig = dat.sig(idx);
dat.removed_voxels = ~idx;
 
info = roi_contour_map(dat, 'xyz', 1, 'coord', 3,'colorbar','sig','notfill','color','parula');
set(gca, 'XDir','reverse')
caxis manual
caxis([-0.02 0.02]);
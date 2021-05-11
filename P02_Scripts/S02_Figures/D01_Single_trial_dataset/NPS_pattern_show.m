%% HOW_DO_I_VISUALIZE_DATA
% The help file shows you how to display neuroimaging data for publication
% by marianne reddan, 2016

%% General instructions
% -----------------------------------------------------------------------
%
% Before you start, the CANlab_Core_Tools must be added to your path with
% subfolders. Otherwise, you will get errors.
addpath(genpath('/Users/spring/Documents/MATLAB/CanlabCore'));
addpath(genpath('/Users/spring/Documents/MATLAB/MasksPrivate'));
addpath(genpath('/Users/spring/Documents/MATLAB/Neuroimaging_Pattern_Masks'));
%
% This example will use the neurologic pain signature (NPS): 
% "weights_NSF_grouppred_cvpcr" %NOTE TO TOR: This is currently in masks private
% 
% These data were published in:
% Wager, T. D., Atlas, L. Y., Lindquist, M. A., Roy, M., Woo, C.W., &
% Kross, E. (2013). An fMRI-Based Neurologic Signature of Physical Pain. 
% New England Journal of Medicine, 368:1388-97.

% ----------------------------------------------
%% Section 1: Load in data and quick view
% ----------------------------------------------
% Load in the image (any .nii or img) as an fmri_data object
nps = fmri_data(which('weights_NSF_grouppred_cvpcr_FDR05.img'));

% Quickly dispaly it and eyeball its properties
figure; plot(nps)
snapnow

close all;
% ----------------------------------------------
%% Plot slices with canlab_results_fmridisplay
% ----------------------------------------------
% You must convert the fmri_data object to a region object
% This takes a lot of memory, and can hang if you have too little.
figure; o2 = canlab_results_fmridisplay(region(nps),'noverbose');
snapnow

% Alternatively, display the slices you want first, then add image data
% This function has advanced control like outlining blobs, transparency
% overlays
figure; o2 = canlab_results_fmridisplay([],'noverbose');
o2=addblobs(o2,region(nps),'color',[.5 0 .5],'outline','linewidth', 2,'transvalue', .75)
snapnow

% Change the slices with 'montagetype' function
figure; o2 = canlab_results_fmridisplay(region(nps),'montagetype','compact2','noverbose');
snapnow
close all;
% ----------------------------------------------
%% For greater control over the slices displayed, use montage
% ----------------------------------------------
% 'slice_range' allows you to select the x y z coordinates
% give it a range of values, and determine the 'spacing' between them
figure;o2 = fmridisplay;
o2 = montage(o2, 'axial', 'slice_range', [-24 50], 'onerow', 'spacing', 10);
o2 = montage(o2, 'coronal', 'slice_range', [-38 -34], 'onerow','spacing', 1);
o2 = montage(o2, 'saggital', 'slice_range', [-5 5], 'spacing', 1);
o2=addblobs(o2,region(nps));
snapnow
figpath = '/Users/spring/Documents/Research/Reliability_NPS/P03_Figures';
export_fig(fullfile(figpath,'axial_-24_50_10.png'),'-png','-r200','-p0.05');
close all

% ----------------------------------------------
%% For 3D Surface Plots
% ----------------------------------------------
% There are multple options for producing 3D brains.

% See fmri_data.isosurface

% --------
% OPT1 - Plot on a 'slab' of brain like Reddan, Lindquist, Wager (2016)
% Effect Size paper
% --------
% First set up your underlay brain image (anatomical)
ovlname = 'keuken_2014_enhanced_for_underlay'; %this image is in CanlabCore
ycut_mm = -30; % Where to cut brain on Y axis
coords = [0 ycut_mm 0];
coords = [0 0 20];
anat = fmri_data(which('keuken_2014_enhanced_for_underlay.img'));
% Next set up the surface plot of your data
figure; 
set(gcf, 'Tag', 'surface'); 
f1 = gcf;
p = isosurface(anat, 'thresh', 140, 'nosmooth', 'zlim', [-Inf 20]);
view(137, 26);
lightRestoreSingle
colormap gray; 
brighten(.6); 
set(p, 'FaceAlpha', 1);
drawnow
set(f1, 'Color', 'w');
[mip, x, y, voldata] = pattern_surf_plot_mip(nps, 'nosmooth');
figure(f1)
hold on;
% Next rescale your surface data to match anatomical brainmap we want (kludge)
han = surf(x, y, mip .* 70 + 20);
set(han, 'AlphaDataMapping', 'scaled', 'AlphaData', abs(mip) .^ .5, 'FaceColor', 'interp', 'FaceAlpha', 'interp', 'EdgeColor', 'interp');
set(han, 'EdgeColor', 'none');
% Set colormap for plot
def = colormap('parula');
gray = colormap('gray');
cm = [def; gray];
colormap(cm);
view(147, 50);
axis off
% Apply to brain
drawnow; snapnow
close all;

% ---------
% OPT2 - Use default surf plot option in canlab_results_fmridisplay_marianne
% --------
o2 = canlab_results_fmridisplay(region(nps),'full','noverbose', 'nooutline');
snapnow;

% --------
% OPT3 - function tor_3D, or export your data to Caret
% --------

% ----------------------------------------------
%% For plotting voxel plots of ROIs use roi_contour_map
% ----------------------------------------------
% Convert image into clusters with region()
% Determine which clusters you want to plot and select them within the cluster object e.g., cl(NUMBEROFCLUSTER(S))
cl = region(nps);

% threshold based on extent of 8 vox or greater
num_vox_per_cluster = cat(1, cl.numVox);
cl(num_vox_per_cluster < 8) = [];

% Print a table, and return clusters with names attached in the cl structure
% This will separate positive and negative-valued voxels in each region

[clpos, clneg] = table(cl);
new_cl_with_labels = [clpos clneg];

% threshold based on extent of 50 vox or greater - just to have a set to
% display nicely: 
num_vox_per_cluster = cat(1, new_cl_with_labels.numVox);
new_cl_with_labels(num_vox_per_cluster < 50) = [];


% Montage of the clusters, showing each
montage(new_cl_with_labels, 'colormap', 'regioncenters');
snapnow

% Now plot 
info = roi_contour_map(new_cl_with_labels(1:5:end), 'cluster', 'use_same_range', 'colorbar','sig');
snapnow

% Note if you get errors here, check the number of voxels in your cluster.
% If less than 2, you cannot use this function.
% Here is an example of how to check
% for i=1:length(cl);disp(sprintf('cluster %d is %d voxels',i,cl(i).numVox));end
%%
dat = fmri_data(which('weights_NSF_grouppred_cvpcr.img'));
dat1 = fmri_data(which('weights_NSF_grouppred_cvpcr_FDR05.img'));
 
dat_sig = statistic_image;
dat_sig.dat = dat.dat;
dat_sig.sig = dat1.dat ~=0;
dat_sig.volInfo = dat.volInfo;
 
x = [-30 30]; %2
y = [-30 40]; %4 
z = [20 50]; %34

x = [-30 30]; %2
y = [-70 -20]; %4 
z = [20 60]; %34

% x = [-100 20];
% y = [-40 -30]; 
% z = [-80 80];

% x = [23 73];
% y = [-50 2]; 
% z = [7 21];
 
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
 
% info = roi_contour_map(dat, 'xyz', 2, 'coord', -35,'colorbar','surf','notfill');
info = roi_contour_map(dat, 'xyz', 1, 'coord', 4,'colorbar','sig','notfill','color','parula');
set(gca, 'YDir','reverse')
caxis manual
caxis([-0.02 0.02]);
figpath = '/Users/spring/Documents/Research/Reliability_NPS/P03_Figures';
export_fig(fullfile(figpath,'PCC_pattern.png'),'-png','-r200','-p0.05');
% export_fig(fullfile(figpath,'dACC_pattern.png'),'-png','-r200','-p0.05');
% export_fig(fullfile(figpath,'lS2_pattern.png'),'-png','-r200','-p0.05');
%%
keywords = {'hires right' 'thalamus' 'left_cutaway' 'right_cutaway' 'left_insula_slab' 'right_insula_slab' 'accumbens_slab' 'coronal_slabs' 'coronal_slabs_4' 'coronal_slabs_5'};

for i = 3%:length(keywords)

    figure; axis off

    surface_handles = surface(nps, keywords{i});

    % This essentially runs the code below:

    % surface_handles = addbrain(keywords{i}, 'noverbose');
    % render_on_surface(t, surface_handles, 'clim', [-7 7]);

    % Alternative: This command creates the same surfaces:
    % surface_handles = canlab_canonical_brain_surface_cutaways(keywords{i});
    % render_on_surface(t, surface_handles, 'clim', [-7 7]);
    
    drawnow, snapnow
    set(gca,'color',[0 0 0]);
    export_fig(fullfile(figpath,'nps_left_cutaway.png'),'-png','-r200','-p0.05');

end
%%
cl = region(nps);

% threshold based on extent of 8 vox or greater
num_vox_per_cluster = cat(1, cl.numVox);
cl(num_vox_per_cluster < 8) = [];

% Print a table, and return clusters with names attached in the cl structure
% This will separate positive and negative-valued voxels in each region

[clpos, clneg] = table(cl);
new_cl_with_labels = [clpos clneg];

% threshold based on extent of 50 vox or greater - just to have a set to
% display nicely:
num_vox_per_cluster = cat(1, new_cl_with_labels.numVox);
new_cl_with_labels(num_vox_per_cluster < 50) = [];


% Montage of the clusters, showing each
montage(new_cl_with_labels, 'colormap', 'regioncenters');
snapnow
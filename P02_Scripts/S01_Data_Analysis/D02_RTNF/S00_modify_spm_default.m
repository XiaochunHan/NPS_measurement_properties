edit spm_defaults
%% The following should be modified manually
defaults.stats.maxmem = 2^35; %modified from 2^26
defaults.mask.thresh = -Inf; %modified from 0.8
defaults.stats.fmri.hpf = 180; %modified from 128
defaults.stats.fmri.cvi = 'None'; %modified from ?AR(1)?

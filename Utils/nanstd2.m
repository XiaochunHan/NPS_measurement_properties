% NANSTD provides a replacement for MATLAB's nanstd that is almost
% compatible.
%
% For usage see STD. Note that the three-argument call with FLAG is not 
% supported.

function Y = nanstd2(varargin)
Y = sqrt(nanvar2(varargin{:}));

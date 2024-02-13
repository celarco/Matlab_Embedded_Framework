function Setup()

%Add path with subfolders
cwd=fileparts(mfilename('fullpath'));
addpath(cwd);
addpath(fullfile(cwd,'Blocks'));
addpath(fullfile(cwd,'Resources'));
%And save path
savepath;

end
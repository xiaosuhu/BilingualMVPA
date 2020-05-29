%% This script runs a general linear model on each of the "broken" .nirs files
%% generated by the Step1_BreakFiles.m script.

% uigetdir() will ask you to select the directory/ies with the "broken" .nirs
% files and load in the data.

datadir=uigetdir();
files=dir(datadir);
dirFlags=[files.isdir];

% select location for single subject output
outputdir = uigetdir();
addpath(outputdir);


start=4;

for i=start:length(files)
    subdir(i-start+1)=cellstr(strcat(files(i).folder,'/',files(i).name));
end

%% The default GLMFirstlevelAnalysis function does the following:
% Applies the Modified Beer Lambert Law to convert OD to HbO/Hbr
% Downsamples data to 2 Hz
% Applies a canonical GLM to estimate the hemodynamic response for each
% block (in this case, a block = one trial)
% Default HRF peak = 6 seconds
% Default no derivatives included

for i=1:length(subdir)
   FirstLevelStats{i}=GLMFirstlevelAnalysis(subdir{i}); 
end

% save single subject statistics to output directory
save([fullfile(outputdir),'/FirstLevelStats',num2str(i),'.m'], 'FirstLevelStats')
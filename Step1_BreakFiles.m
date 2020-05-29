%% This script breaks one fNIRS data file into multiple files by block
%% IMPORTANT NOTE:
%  Original .nirs data file will be REPLACED by N smaller files (1 per
%  block). Only run this script on a COPY of your original .nirs data.
%  Deleting the original file can be turned off in Blockbreaker function.

datadir=uigetdir();
data=nirs.io.loadDirectory(datadir,{'Subject','Session'});

% Blockbreaker function creates a new .nirs file for each block in task
% design; Trials are recoded as "blocks"
for i=1:length(data)
    Blockbreaker(data(i).description);
end
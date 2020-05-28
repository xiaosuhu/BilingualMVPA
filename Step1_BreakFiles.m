%% This script breaks one fNIRS data file into multiple files by block
%% IMPORTANT NOTE:
%  Original .nirs data file will be REPLACED by N smaller files (1 per
%  block). Only run this script on a COPY of your original .nirs data.

datadir=uigetdir();
data=nirs.io.loadDirectory(datadir,{'Subject','Session'});

for i=1:length(data)
    Blockbreaker(data(i).description);
end
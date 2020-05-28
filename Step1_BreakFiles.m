%% This script breaks one fNIRS data file into multiple files by block
datadir=uigetdir();
data=nirs.io.loadDirectory(datadir,{'Subject','Session'});

for i=1:length(data)
    Blockbreaker(data(i).description);
end
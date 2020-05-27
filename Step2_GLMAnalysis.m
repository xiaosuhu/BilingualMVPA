datadir=uigetdir();
files=dir(datadir);
dirFlags=[files.isdir];

start=4;

for i=start:length(files)
    subdir(i-start+1)=cellstr(strcat(files(i).folder,'/',files(i).name));
end

for i=1:length(subdir)
   FirstLevelStats{i}=GLMFirstlevelAnalysis(subdir{i}); 
end

save('FirstlevelStats.m','FirstLevelStats');
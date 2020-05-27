function Blockbreaker(file)
pathparts=strsplit(file,filesep);
filedir=pathparts{1};
for i=2:length(pathparts)-1
    if ispc
        filedir=strcat(filedir,'\',pathparts{i});
    elseif ismac
        filedir=strcat(filedir,'/',pathparts{i});     
    end
end
cd(filedir)
load(file,'-mat');

blocknum=12;

[trialstartind,col]=find(diff(s)==1);
trialstartind=[trialstartind col];
[~,sortind]=sort(trialstartind(:,1));
trialstartindsort=trialstartind(sortind,:);

blockstartind=trialstartind(1:4:end,:);
[~,sortind]=sort(blockstartind(:,1));
blockstartindsort=blockstartind(sortind,:);
blockstartindsort=[blockstartindsort; [size(d,1) 0]];

for i=1:size(blockstartindsort)-1
    startind=blockstartindsort(i,1);
    endind=blockstartindsort(i+1,1);
    cond=blockstartindsort(i,2);
    blockid=i;
    Filegenerator(aux,d,ml,s,SD,systemInfo,t,startind,endind,cond,file,blockid);
end

% Remove original file

delete(file); 

end


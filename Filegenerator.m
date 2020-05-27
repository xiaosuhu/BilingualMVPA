function Filegenerator(aux,d,ml,s,SD,systemInfo,t,startind,endind,cond,file,blockid)
%FILEGENERATOR Summary of this function goes here
%   Detailed explanation goes here
aux=aux(startind:endind,:);
d=d(startind:endind,:);
t=t(startind:endind);
s=s(startind:endind,:);
s=sum(s,2);

[trialstartind]=find(diff(s)==1);
[trialendind]=find(diff(s)==-1);
% trialdur=bsxfun(@minus,trialendind,trialstartind);

% Creat new S
s_tmp=zeros(size(s,1),4);
for i=1:4
    s_tmp(trialstartind(i):trialendind(i),i)=1;
end
s=s_tmp;

% try
%     save(strcat(file,'_Cond',num2str(cond),'_Block',num2str(blockid),'.nirs'),...
%         'aux','d','dStd','ml','s','SD','systemInfo','t');
% catch
save(strcat(file,'_Cond',num2str(cond),'_Block',num2str(blockid),'.nirs'),...
    'aux','d','ml','s','SD','systemInfo','t');
% end

end


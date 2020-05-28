classfun=@SVMTaskControl_lefthemi_MAtoPA;
chrange=8;
hbohbrswitch=2;

tic
for i=1:length(FirstLevelStats)
    [ACC(i,1),Confusion{i,1},mdl{i,1},VLoss(i,1),data{i}]=classificationtest(FirstLevelStats{i},classfun,chrange,hbohbrswitch);
end
toc

function [ACC,C,mdl,VLoss,data]=classificationtest(SubjStats,classfun,chrange,hbohbrswitch)
    [ACC,C,mdl,VLoss,data]=classfun(SubjStats,chrange,hbohbrswitch);
end


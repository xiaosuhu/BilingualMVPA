classfun=@SVMEasyControl_hbo_lefthemi_4FrontCH_MAtoPA;

tic
for i=1:length(FirstLevelStats)
    [ACC(i,1),Confusion{i,1},mdl{i,1},VLoss(i,1),data{i}]=classificationtest(FirstLevelStats{i},classfun);
end
toc



function [ACC,C,mdl,VLoss,data]=classificationtest(SubjStats,classfun)
[ACC,C,mdl,VLoss,data]=classfun(SubjStats);
end


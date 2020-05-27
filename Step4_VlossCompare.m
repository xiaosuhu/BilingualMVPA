load SVMEasyControl_hbo_lefthemi_4FrontCH_MAtoPA.mat
VlossSum=VLoss;

load SVMEasyControl_hbo_lefthemi_4FrontCH_PAtoMA.mat
VlossSum=[VlossSum VLoss];

load SVMEasyControl_hbo_lefthemi_8FrontCH_MAtoPA.mat
VlossSum=[VlossSum VLoss];

load SVMEasyControl_hbo_lefthemi_8FrontCH_PAtoMA.mat
VlossSum=[VlossSum VLoss];

load SVMEasyControl_hbohbr_lefthemi_4FrontCH_MAtoPA.mat
VlossSum=[VlossSum VLoss];

load  SVMEasyControl_hbohbr_lefthemi_4FrontCH_PAtoMA.mat
VlossSum=[VlossSum VLoss];

Vlossmean=mean(VlossSum,1);

for i=1:length(FirstLevelStats)
    disp(FirstLevelStats{i}(1).description)
end
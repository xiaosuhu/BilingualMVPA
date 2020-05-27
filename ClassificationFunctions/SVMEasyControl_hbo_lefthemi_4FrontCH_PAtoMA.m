function [ACC, C, mdl, ValidateLoss,Data] = SVMEasyControl_hbo_lefthemi_4FrontCH_PAtoMA(SubjStats)
% Only Easy and Control conditions are selected for classification

% for i=1:length(SubjStats)
%     disp(SubjStats(i).description);
% end
%% Form up the feature matrix for machine learning algorithm
TRAIN_Y={'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT'}';

% weighttaskcont=[0.3*ones(32,1); 0.6*ones(16,1)];
chrange=7;

TRAIN_X=[];
% Easy
for i=13:16
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end
% Hard
% for i=17:20
%     TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
% end
% Control
for i=21:24
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end

mdl=fitcsvm(TRAIN_X,TRAIN_Y,'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
cvmdl=crossval(mdl);
ValidateLoss=kfoldLoss(cvmdl);

TEST_Y={'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT'}';

TEST_X=[];
% Easy
for i=1:4
    TEST_X=[TEST_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end
% Hard
% for i=5:8
%     TEST_X=[TEST_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
% end
% Control
for i=9:12
    TEST_X=[TEST_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end

% Stardadize 
PREDICT_Y=predict(mdl,TEST_X);

Data.testy=TEST_Y;
Data.testx=TEST_X;
Data.predict_Y=PREDICT_Y;

%% Calculate the ACC and Confusion matrix
C=confusionmat(PREDICT_Y,TEST_Y);
ACC=trace(C)/length(TEST_Y);

end


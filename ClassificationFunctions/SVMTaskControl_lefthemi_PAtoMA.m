function [ACC, C, mdl, ValidateLoss,Data] = SVMTaskControl_lefthemi_PAtoMA(SubjStats,chrange,hbohbrswitch)
% Only Easy and Control conditions are selected for classification

% for i=1:length(SubjStats)
%     disp(SubjStats(i).description);
% end
%% Form up the feature matrix for machine learning algorithm
TRAIN_Y={'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT',...
    'CONT','CONT','CONT','CONT'}';

weighttaskcont=[(1/64)*ones(32,1); (2/64)*ones(16,1)];
chrange=chrange*2;

switch hbohbrswitch
    case 1
        chcount=2;
    case 2
        chcount=1;
end

TRAIN_X=[];
% Easy
for i=13:16
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:chcount:chrange)'; SubjStats(i).beta(end/4+1:chcount:end/4+chrange)'; SubjStats(i).beta(end/2+1:chcount:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:chcount:3*end/4+chrange)'];
end
% Hard
for i=17:20
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:chcount:chrange)'; SubjStats(i).beta(end/4+1:chcount:end/4+chrange)'; SubjStats(i).beta(end/2+1:chcount:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:chcount:3*end/4+chrange)'];
end
% Control
for i=21:24
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:chcount:chrange)'; SubjStats(i).beta(end/4+1:chcount:end/4+chrange)'; SubjStats(i).beta(end/2+1:chcount:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:chcount:3*end/4+chrange)'];
end

mdl=fitcsvm(TRAIN_X,TRAIN_Y,'Standardize',true,'KernelFunction','RBF','KernelScale','auto','RemoveDuplicates',true,'Weights',weighttaskcont);
cvmdl=crossval(mdl);
ScoreSVMmdl = fitSVMPosterior(cvmdl);
ValidateLoss=kfoldLoss(cvmdl);

TEST_Y={'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
    'TASK','TASK','TASK','TASK',...
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
    TEST_X=[TEST_X; SubjStats(i).beta(1:chcount:chrange)'; SubjStats(i).beta(end/4+1:chcount:end/4+chrange)'; SubjStats(i).beta(end/2+1:chcount:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:chcount:3*end/4+chrange)'];
end
% Hard
for i=5:8
    TEST_X=[TEST_X; SubjStats(i).beta(1:chcount:chrange)'; SubjStats(i).beta(end/4+1:chcount:end/4+chrange)'; SubjStats(i).beta(end/2+1:chcount:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:chcount:3*end/4+chrange)'];
end
% Control
for i=9:12
    TEST_X=[TEST_X; SubjStats(i).beta(1:chcount:chrange)'; SubjStats(i).beta(end/4+1:chcount:end/4+chrange)'; SubjStats(i).beta(end/2+1:chcount:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:chcount:3*end/4+chrange)'];
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


function [ACC, C, mdl, ValidateLoss] = SVMTaskControl_hbo_lefthemi_frontalch(SubjStats)

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

chrange=7;

TRAIN_X=[];
% Easy
for i=1:4
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end
% Hard
for i=5:8
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end
% Control
for i=9:12
    TRAIN_X=[TRAIN_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end

mdl=fitcsvm(TRAIN_X,TRAIN_Y,'Weights',weighttaskcont);
cvmdl=crossval(mdl);
ScoreSVMmdl = fitSVMPosterior(cvmdl);
ValidateLoss=kfoldLoss(cvmdl);

data.TRAIN_X=TRAIN_X;
data.TRAIN_Y=TRAIN_Y;

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
for i=13:16
    TEST_X=[TEST_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end
% Hard
for i=17:20
    TEST_X=[TEST_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end
% Control
for i=21:24
    TEST_X=[TEST_X; SubjStats(i).beta(1:2:chrange)'; SubjStats(i).beta(end/4+1:2:end/4+chrange)'; SubjStats(i).beta(end/2+1:2:end/2+chrange)'; SubjStats(i).beta(3*end/4+1:2:3*end/4+chrange)'];
end

% Stardadize 
PREDICT_Y=predict(mdl,TEST_X);

data.TEST_X=TEST_X;
data.TEST_Y=TEST_Y;
data.PREDICT_Y=PREDICT_Y;

%% Calculate the ACC and Confusion matrix
C=confusionmat(PREDICT_Y,TEST_Y);
ACC=trace(C)/length(TEST_Y);

end



mdltest=mdl{4};
mdltest=fitPosterior(mdltest);
[~,scoretest]=resubPredict(mdltest);
resp=strcmp(data{1}.testy,'TASK');
ClassNames=strcmp(mdltest.ClassNames,'TASK');
[Xsvm,Ysvm,Tsvm,AUCsvm] = perfcurve(resp,scoretest(:,ClassNames),'true');
plot(Xsvm,Ysvm)





% Example
% load ionosphere
% resp = strcmp(Y,'b'); % resp = 1, if Y = 'b', or 0 if Y = 'g' 
% pred = X(:,3:34);
% mdlSVM = fitcsvm(pred,resp,'Standardize',true);
% mdlSVM = fitPosterior(mdlSVM);
% [~,score_svm] = resubPredict(mdlSVM);
% [Xsvm,Ysvm,Tsvm,AUCsvm] = perfcurve(resp,score_svm(:,mdlSVM.ClassNames),'true');

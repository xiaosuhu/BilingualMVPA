% Check the correlation between PA and MA

% Averaged
for i=1:length(mdl)
    
    CORR(i)=corr(mean(mdl{i}.X,1)',mean(data{i}.testx,1)');
    
end

mean(abs(CORR))

% Individual trial
for i=1:length(data)
    for j=1:size(data{i}.testx,1)
        for k=1:size(mdl{i}.X,1)
            CORRin(j,k,i)=corr(mdl{i}.X(j,:)',mdl{i}.X(k,:)');
        end
    end
end

figure
for i=1:length(CORRin)
    subplot(7,10,i)
    imagesc(CORRin(:,:,i));
    xlabel('PA trials')
    ylabel('MA trials')
    
end

figure
imagesc(mean(CORRin,3))
xlabel('PA trials')
ylabel('MA trials')



for i=1:24
    disp(FirstLevelStats{1}(i).description)
end
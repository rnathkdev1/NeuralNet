function [accuracy,validation]=trainkfold(net, options, x, trainclass, alg, k)
%% Preparing a K-fold validation set

numsamples=size(x,1);
accuracy=zeros(1,k);
validation=0;

% Dividing it into k+1 sets, 
% k for cyclic training and testing and the
% final one for validation
indices=ceil(linspace(1,numsamples,k+2));

% Setting aside the last segment for validation 
validationset=[indices(end-1) indices(end)];
indices(end)=[];

%Setting the poitnters that do cross validation
ptr=k;
netfixed=net;
%% Starting the K-fold
for i=1:k
    net=netfixed;
    fprintf('Starting K fold... K=%f\n',i);
    row1=indices(i);
    if indices(ptr)-1 ~=0
        row2=indices(ptr)-1;
    else row2=indices(ptr);
    end
    
    if (row1<row2)
        trainX=x(row1:row2,:);
        trainclassK=trainclass(row1:row2,:);
        testX=x(row2+1:end,:);
        testclassX=trainclass(row2+1:end,:);
    else
        trainX=cat(1,x(row1:end,:),x(1:row2,:));
        trainclassK=cat(1,trainclass(row1:end,:),trainclass(1:row2,:));
        testX=x(row2+1:row1-1,:);
        testclassX=trainclass(row2+1:row1-1,:);
    end
    
    %Training with the K subset
    [net, options, ~] = netopt(net, options, trainX, trainclassK, alg);
    
    %Testing with the remaining
    [y, ~, ~] = mlpfwd(net, testX);
    
    accuracy(i)=findaccuracy(y,testclassX);
    fprintf('\nK= %f accuracy is %f\n',i,accuracy(i));
    
    ptr=rem((ptr),k+1)+1;
end
%% Validation
trainX=x(1:(validationset(1)-1),:);
trainclassK=trainclass(1:(validationset(1)-1),:);

testX=x(validationset(1):validationset(2),:);
testclassX=trainclass(validationset(1):validationset(2),:);

% Train validation set
[net, ~, ~] = netopt(net, options, trainX, trainclassK, alg);

%Test validation set
[y, ~, ~] = mlpfwd(net, testX);

validation=findaccuracy(y,testclassX);


end


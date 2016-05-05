clc
clear;
addpath('netlab/');
[training,testing] = setupMNIST();
%% Figuring out some of the parameters in the MNIST database [DO NOT BE ALTER]

% For the training samples
numtrain=size(training.data,2); %Num of training data
numtrainnodes=size(training.data,1); % Num of testing data
t=training.labels;
trainclass=zeros(numtrain,10);
nin=numtrainnodes;
nout=10; % for the 10 digits
outfunc='logistic';
options = zeros(1,18);
options(1) = 1; %display iteration values

for i=1:length(t)
    trainclass(i,training.labels(i)+1)=1;
end

%For the testing samples
numtest=size(testing.data,2);
numtestnodes=size(testing.data,1);
answer=testing.labels;

%% Defining parameters for the neural network [VALUES MAY BE TWEAKED]

nhidden=100; %Vary this parameter for changing number of hidden nodes
ntrainingsamples=100; % Vary this parameter for choosing the number of training samples
k=4; %This is the K for the K-fold cross validation
options(14) = 500; %maximum number of training cycles (epochs)
%% Processing the training class

x=training.data(:,1:ntrainingsamples)';
trainclass=trainclass(1:ntrainingsamples,:);
alg='scg';  

%% INITIALIZING the neural network

disp('Initializing the Neural Net')
net = mlp(nin, nhidden, nout, outfunc);

%% Training the neural network K-fold

disp('Training the network K-fold ...');
[accuracy,validation]=trainkfold(net, options, x, trainclass, alg, k);
avgacc=mean(accuracy);
%% Final training the neural network on required input data

[net, options, ~] = netopt(net, options, x, trainclass, alg);

%% Testing on unseen data

[y, z, a] = mlpfwd(net, testing.data');
unseen_accuracy=findaccuracy(y,answer);

%% Printing results

fprintf('-----------------------------------------------------------\n');
fprintf('Hidden Nodes: %d\nTraining Samples taken: %d\nEpochs: %d\nK-Folds: %d\n\n\n',nhidden,ntrainingsamples,options(14),k)
fprintf('Following are the accuracies of individual K-fold tests\n');
disp(accuracy');
fprintf ('Mean Accuracy of K fold test is %f\n',avgacc);
fprintf('The accuracy of validation set the K fold training is shown below:\n')
disp(validation);
fprintf('This neural net has an accuracy of %f percent\n',unseen_accuracy);

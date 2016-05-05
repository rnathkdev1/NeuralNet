clc; clear; close all;
%% Initializing the training data for the network
load('Q2ec.mat');
%tk(2,1:2601)=0;

rng('default');
nin=size(Xi,1);
nhidden=[4 4];
nout=size(tk,1);
net = patternnet(nhidden);
net.performFcn='sse'

net.divideFcn = ''; %do not divide the data into training/crossvalidation/testing subsets
net.trainParam.lr = 0.05; %learning rate
net.trainParam.epochs = 10000; %maximum number of iterations
%% Train the network
net = train(net,Xi,tk);
% view(net);

%% Test the network
yk = net(Xi); %feed the data through the network
doplot(yk(1,:),Xi,1)

%% Display the weights
wb=getwb(net);
[b,IW,LW] = separatewb(net,wb);

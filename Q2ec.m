clc;
clear;
%% Loading parameters for the first 4 parts of the question
load('parta.mat');

%% Feed forward
yk=feedforward(wji,wkj,Xi,a,b,J);

%% Plotting
figure(1)
doplot(yk,Xi,1);
hold on;

%Eliminating floating point error
Xi=round(Xi*10)/10;
Filter=find(yk>=0);
Xinew(1,:)=Xi(1,Filter);
Xinew(2,:)=Xi(2,Filter);
Xinew(3,:)=1;

%% This is with the new parameters
%clearvars except J

%% Loading parameters for the first 4 parts of the question
load('partb.mat');

%% Feed forward
yknew=feedforward(wji,wkj,Xinew,a,b,J);

%% Plotting
doplot2(yknew,Xinew,1);

%Eliminating floating point error
Xinew=round(Xi*10)/10;

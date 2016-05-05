clc;
clear;
%% Loading parameters for the first 4 parts of the question
load('parta.mat');

%% Feed forward
yk=feedforward(wji,wkj,Xi,a,b,J);

%% Plotting
doplot2(yk,Xi,1);

%Eliminating floating point error
Xi=round(Xi*10)/10;

[~,ind1]=ismember([2.2 -3.2 1],Xi','rows');
[~,ind2]=ismember([-3.2 2.2 1],Xi','rows');
val11=yk(ind1);
val12=yk(ind2);

%% This is with the new parameters
clearvars except var11 var12

%% Loading parameters for the first 4 parts of the question
load('partb.mat');

%% Feed forward
yk=feedforward(wji,wkj,Xi,a,b,J);

%% Plotting
doplot2(yk,Xi,2);

%Eliminating floating point error
Xi=round(Xi*10)/10;

[~,ind1]=ismember([2.2 -3.2 1],Xi','rows');
[~,ind2]=ismember([-3.2 2.2 1],Xi','rows');
val21=yk(ind1);
val22=yk(ind2);

%% Writing results
fprintf('For the first set of values, the outputs are:\ny = %f\ny=%f\n',val11,val12);
fprintf('\nFor the second set of values, the outputs are:\ny = %f\ny=%f\n',val21,val22);

%% Extra credits
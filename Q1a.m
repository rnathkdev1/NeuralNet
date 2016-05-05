clc
clear
%% THis is the training data
Xi=[0 0 0 0 1 1 1 1;0 0 1 1 0 0 1 1;0 1 0 1 0 1 0 1];
tk=[0 0 0 0 0 1 1 0];

I=size(Xi,1);
J=3;
K=1;
rate=0.02;
nIter=100000;

N=size(Xi,2);

%% This is the part where we initialize

wji=0.01*randn(J,I);
wkj=0.01*randn(K,J);


%% Training

for i=1:nIter
    % Back propagation
    aj=wji*Xi;
    zj=tanh(aj);
    
    yk=wkj*zj;
    
    deltak=yk-tk;
    deltaj=(ones(J,N)-zj.^2).*(wkj'*deltak);
    dEdWkj=deltak*zj';
    dEdWji=deltaj*Xi';
    
    wkj=wkj-rate*dEdWkj;
    wji=wji-rate*dEdWji;
    
    
end
%% Testing

XTi=[0 0 0 0 1 1 1 1;0 0 1 1 0 0 1 1;0 1 0 1 0 1 0 1];

aj=wji*XTi; 
zj=tanh(aj);
yk=wkj*zj;

yk=round(yk)
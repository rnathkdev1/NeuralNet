%% THis is the training data
Ai=logical([0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]);
Bi=logical([0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1]);
Ci=logical([0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1]);
Di=logical([0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]);

tk=and(xor(Ai,Bi),xor(Ci,Di));

Xi=[Ai;Bi;Ci;Di];

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

XTi=[Ai;Bi;Ci;Di];
aj=wji*XTi; 
zj=tanh(aj);
yk=round(wkj*zj)

round(yk)==tk
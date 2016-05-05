clc
clear
wji=[4 -4;-3 4.6];
wkj=[5 5.2];
Xi=[-0.5;1];
tk=0.9;
zj=logistic(wji*Xi);
yk=logistic(wkj*zj);

rate=0.1;
deltak=(yk-tk)*logistic(yk)*(1-logistic(yk));
dWkj=deltak*zj';
wkj=wkj-rate*dWkj;
dWji=((wkj'*deltak).*(zj.*(ones(size(zj))-zj)))*Xi';
wji=wji-rate*dWji;

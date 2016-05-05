function yk=feedforward(wji,wkj,Xi,a,b,J)
aj=wji*Xi;
zj=a*tanh(b*aj);
zj(J,:)=1; %Adding bias
ak=wkj*zj;
yk=a*tanh(b*ak);
end
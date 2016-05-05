function doplot2(yk,Xi,i)
I=find(yk<0);
J=find(yk>=0);

figure(i)
scatter(Xi(1,I),Xi(2,I),'red','o');
hold on;
scatter(Xi(1,J),Xi(2,J),'green','x');
end
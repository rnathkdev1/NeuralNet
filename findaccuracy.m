function accuracy=findaccuracy(y,answer)
numtest=length(y);
%% Decoding the bits
y=round(y);
decodemat=[0 1 2 3 4 5 6 7 8 9];
decodemat=repmat(decodemat,[length(y) 1]);
y=y.*decodemat;

if size(answer,2)==10
    answer=answer.*decodemat;
    answer=sum(answer')';
end

%% Calculating the error
result=sum(y')';
correct=sum(result==answer);
accuracy= correct/numtest*100;

end

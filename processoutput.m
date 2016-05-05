function result=processoutput(xs, ys)
addpath('netlab/');
% load tempimage.mat
xs=round(xs);
ys=round(ys);

%Adding a thickness of 4 pixels along X and Y

xs2=xs+1;
ys2=ys+1;

xs3=xs-1;
ys3=ys-1;


linind1=sub2ind([28 28],ys,xs);
linind2=sub2ind([28 28],ys,xs2);
linind3=sub2ind([28 28],ys,xs3);
linind4=sub2ind([28 28],ys2,xs);
linind5=sub2ind([28 28],ys3,xs);


newim=zeros(28,28);
newim=mat2gray(newim,[0 1]);

 newim(linind1)=1;
% newim(linind2)=1;
 newim(linind3)=1;
% newim(linind4)=1;
 newim(linind5)=1;
% 
%newim(1:100,1:100)=1;
imshow(newim);
vector=newim(:);
clearvars -except vector
load('traindesign.mat');

[y, ~, ~] = mlpfwd(net, vector');

y=round(y)
decodemat=[0 1 2 3 4 5 6 7 8 9];
decodemat=repmat(decodemat,[size(y,1) 1]);
y=y.*decodemat;
result=sum(y')';
if result>9
    result=unique(y);
    l=length(y);
 
    result=result(randperm(l,1));
end

end
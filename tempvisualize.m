clc
clear
load('traindesign.mat');
vector=testing.data(:,4);
image=reshape(vector,[28 28]);

imshow(image);
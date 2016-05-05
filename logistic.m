function y=logistic(x)

y=ones(size(x))./(ones(size(x))+exp(-x));
end
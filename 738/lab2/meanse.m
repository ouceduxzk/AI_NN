function [m, b] = meanse(n,c, p)
x = 0;
for i= 1:30
x1 = rand(n,p-1)';
x2 = ones(1,n);
X = [x1;x2]' ;
beta = ones(p,1);
elson = rand(n,1);
Y = X*beta + c* elson;
beta_hat = inv(X'*X) * X' * Y ;
x = x +  sqrt(sum((beta - beta_hat).^2));
end
m = x/30;
b = beta_hat;
end


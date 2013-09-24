n = 10;
x1 = rand(n,1)'
x2 = ones(1,n)
X = [x1;x2]'

beta = [1;1];

elson = rand(n,1);

c = 0.1;

Y = X*beta + c* elson


beta_hat = inv(X'*X) * X' * Y


p1=plot(X(:,1),Y,'o')

set(p1,'Color','red','LineWidth',2)

Y_hat = beta_hat(1) * X(:,1) + beta_hat(2);

hold on

p2=plot(X(:,1), Y_hat)

set(p2, 'Color', 'black', 'LineWidth',2)

xlabel('x')
ylabel('y')
title('linear regression of guassian random data')
pos = Legend('Guassain random data','Predictor')
set(pos,'Location','NorthWest')
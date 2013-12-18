%%%%hw5 EECS738

beta = [ 0.5, -0.3];
c = 0.04;
sigmasq = 0.5;
n = 1000;

x = unifrnd(-1,1, n,1);
x = [x, ones(n,1)];
noise = normrnd(0,1,n,1);

y = x * beta' + c * noise;
data = [x(:,1), y];
prior = mvnrnd([0,0],eye(2)*sigmasq, n);


choice = [1,2,3,4,5,6,8,10,15,20,100];

for m = 1:size(choice,2)
    h = blrplot(data, choice(m), c , sigmasq, n)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function h = blrplot(data,num, c, sigmasq, n)

[X Y] = meshgrid(-1:0.01:1, -1:0.01:1);
likeli = zeros(size(X));
logli = zeros(size(X));
Post = zeros(size(X));
sample =  data(datasample(1:n, num),:);

for i = 1:size(X,1)
    for j = 1:size(X,2)
        target = [sample(:,1), ones(size(sample,1),1)] * [Y(i,j); X(i,j)];
	 % the log likelihood function is the summation of each quadratic function
	 % evaluated at each point in the grid, constraining that those points on 
	 % the grid that close to the data points given have the higher probability.
        logli(i,j) = -0.5* sum( ((sample(:,2) - target )/c).^2 );
        %likeli(i,j) = normpdf( X(i,j), (sample(:,2) - target )/c , 1 );
        p_prior = mvnpdf( [X(i,j), Y(i,j)] ,[0,0], eye(2) * sigmasq );
        likelihood = 1;
	 % sequential update, where I simply multiply the likelihood function
	 % for each data point and then multiply the prior, which is equal to
	 % update new posterior to be the prior and then multiply one likelihood 
	 % for the next new data point.

        for t = 1:size(sample,1)
            likelihood = likelihood * normpdf( X(i,j), (sample(t,2) - target(t,1) )/(c), 1 );
        end
        Post(i,j) =  likelihood * p_prior;
    end
end
    


    
h = figure;
subplot(1,2,1)
image([-1 1], [-1 1], logli, 'CDataMapping', 'scaled');
xlabel('beta0');
ylabel('beta1');
str = sprintf('log likelihood function for %d data point', num);
title(str);
subplot(1,2,2)
image([-1 1], [ -1 1], Post, 'CDataMapping', 'scaled');
xlabel('beta0');
ylabel('beta1');
str = sprintf('Posterior distribution for %d data point',num);
title(str);

saveas(h, num2str(num) , 'pdf') 
end


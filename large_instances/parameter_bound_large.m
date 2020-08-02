% solve moment bound by yalmip
I = 3; %number of facilities
J = 6; %number of customers
K = 10;
facilities = zeros(I,2);
customers = zeros(J,2);
 
build_cost = 100*ones(I,1);
 
revenue = 100;
budget = 100;
capacity = 1000;
 
seed = 1;
rng(seed)
%construct facilities and customers on a 100*100 grid
facilities(:,1) = randperm(100,I);
facilities(:,2) = randperm(100,I);
customers(:,1) = randperm(100,J);
customers(:,2) = randperm(100,J);
 
distance = zeros(I,J);
lambda_mu = zeros(J,I);
for i = 1:I
    for j = 1:J
        distance(i,j) = abs(facilities(i,1)-customers(j,1)) + abs(facilities(i,2)-customers(j,2));
        lambda_mu(j,i) = exp(-distance(i,j)/25);
    end
end
lambda_mu = lambda_mu./sum(lambda_mu,2);
 
tran_cost = round(distance/4);
 
mu = randi([20,40],J,1);
sigma = rand(I,1); %effect on the covariance matrix
sigma = sigma ./sum(sigma,1);

 
demand_sample = zeros(K, J);
for k = 1:K
    rng(k)
    for j = 1:J
        pd = makedist('Normal', 'mu', mu(j), 'sigma', mu(j)*0.4);
        demand_sample(k,j) = round(random(truncate(pd,0,inf)));
    end
end
Sigma = cov(demand_sample);
 
 
gamma = 10;
eta= 100;
 
 
bigM=1e6;
lambda_t = 0;
alpha_t = 0.95;
 
 
 


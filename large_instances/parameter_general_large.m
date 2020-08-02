%DRO with moment inequalities ambiguity set -- large-scale instances
I=10; %number of facilities
J=20; %number of customers
K = 100;
facilities = zeros(I,2);
customers = zeros(J,2);
 
revenue=100;
budget=100;
capacity = 1000*ones(I,1);
build_cost = 100*ones(I,1);

 
seed = 1;
rng(seed)
%construct facilities and customers on a 100*100 grid
facilities(:,1) = randperm(100,I);
facilities(:,2) = randperm(100,I);
customers(:,1) = randperm(100,J);
customers(:,2) = randperm(100,J);
 
distance = zeros(I,J);
lambda_mu = zeros(I,J);
lambda_sigma = zeros(I,J);
for i = 1:I
    for j = 1:J
        distance(i,j) = abs(facilities(i,1)-customers(j,1)) + abs(facilities(i,2)-customers(j,2));
        lambda_mu(i,j) = exp(-distance(i,j)/25);
        lambda_sigma(i,j) = exp(-distance(i,j)/50);
    end
end
lambda_mu = lambda_mu./sum(lambda_mu,1);
lambda_sigma = lambda_sigma./sum(lambda_sigma,1);
 
tran_cost = round(distance/4);

 
mu = randi([20,40],J,1);
sigma=mu*0.8;
e_mu=25;
e_sigma_lower=0.1*ones(J,1);
e_sigma_upper=1.9*ones(J,1);
 
 
bigM=1e6;
Big_M=bigM;
 
lambda_t=0;
alpha_t=0.95;


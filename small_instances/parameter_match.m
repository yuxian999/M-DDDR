% generate parameters for multistage DRO-DD with Type-2 ambiguity set Pattern 2-1
I = 3 ;
J = 2 ;
tran_cost = 10;
build_cost = 100 * ones(I,1);
revenue = 100;
budget = 120;
capacity = 20 * ones(I,1);

mu = 10 * ones(J,1); %empirical mean
lambda_mu = [0.1,0.2,0.3;0.1,0.2,0.3]; %impact on the mean
sigma = [0.5,0.5,0.5]'; %impact on the covariance matrix
Sigma = [10,10;10,10]; %empirical covariance matrix

bigM = 1e9;

lambda_t = 0;
alpha_t = 0.95;

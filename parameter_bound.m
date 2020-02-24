% generate parameters for multistage DRO-DD with Type-3 ambiguity set Pattern 3-1
I = 3 ;
J = 2 ;
tran_cost = 10;
build_cost = 100 * ones(I,1);
revenue = 100;
budget = 120;
capacity = 10 * ones(I,1);

gamma = 1000;
eta = 500;

mu = 10 * ones(J,1);
lambda_mu = [0.1,0.5,0.9;0.1,0.5,0.9];
sigma = [0.5,0.5,0.5]';
Sigma = [0.1,0;0,0.9];

bigM = 1e9;

lambda_t = 0;
alpha_t = 0.95;
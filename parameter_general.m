% generate parameters for multistage DRO-DD with Type-1 ambiguity set Pattern 1-1 -- in matrix form
I = 3; %number of facilities
J = 1; %number of customers
tran_cost = 10; %transportation cost
build_cost = 100 * ones(I,1); %building cost
revenue = 100;
budget = 120;
capacity = 20;

mu = 10*ones(J,1);  %empirical first moment of demand
sigma = 0.1*ones(J,1);  %empirical second moment of demand
e_mu = 5*ones(J,1);  %scaling parameter of mean
e_sigma_lower = 0.5*ones(J,1); %scaling parameter of second moment
e_sigma_upper = 1.5*ones(J,1); %scaling parameter of second moment
lambda_mu = [0.9,0.5,0.1]'; %impact on the mean
lambda_sigma = [0.5,0.5,0.5]'; %impact on the second moment


bigM=1e9;

lambda_t=0;
alpha_t=0.95;


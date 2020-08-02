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
 
W=zeros(2*I+J+12*I*J+1,5*I*J+I+4*J+2);
W(1:I,1:I)=-diag(capacity); %By_t-x_t<= 0
A =ones(1,J);
a1 = repmat({A},I,1);
W(1:I,I+1:I+J*I) = blkdiag(a1{:});
W(I+1,1:I)=transpose(build_cost);        %f_tx_t<=f_tx_{t-1}+N
W(I+2:2*I+1, 1:I)=-eye(I);               %-x_t<=-x_{t-1}
W(2*I+2:2*I+J+1,I+1:I+I*J)=repmat(eye(J),1,I);              %Ay_t<=d_t
 
for i=1:4
    A =ones(J,1);
    a1 = repmat({A},I,1);
    W(2*I+J+2+3*I*J*(i-1):2*I+J+1+I*J+3*I*J*(i-1),      1:I)                                              = -Big_M* blkdiag(a1{:}); %z_{alpha_2}-Big_M(1)x_t<=0
    W(2*I+J+2+3*I*J*(i-1):2*I+J+1+I*J+3*I*J*(i-1),      I*J+I+4*J+2+1 + I*J*(i-1): 2*I*J+I+4*J +2+ I*J*(i-1))               = eye(I*J);
    W(2*I+J+2+I*J+3*I*J*(i-1):2*I+J+1+I*J*2+3*I*J*(i-1),  1:I)                                              = Big_M* blkdiag(a1{:});  %-z_{alpha_2}+Big_M(1)x_t+alpha_2<=Big_M(1)
    W(2*I+J+2+I*J+3*I*J*(i-1):2*I+J+1+I*J*2+3*I*J*(i-1),  I+I*J+1+1+(i-1)*J+(i>2):I+I*J+1+J+(i-1)*J+(i>2))  = repmat(eye(J),I,1);
    W(2*I+J+2+I*J+3*I*J*(i-1):2*I+J+1+I*J*2+3*I*J*(i-1),  I*J+I+4*J+2+1+ I*J*(i-1): 2*I*J+I+4*J+ 2+I*J*(i-1))               = -eye(I*J);
    W(2*I+J+2+I*J*2+3*I*J*(i-1):2*I+J+1+I*J*3+3*I*J*(i-1),I+I*J+1+1+(i-1)*J+(i>2):I+I*J+1+J+(i-1)*J+(i>2))  = -repmat(eye(J),I,1);       %z_{alpha_2}-alpha_2<=0
    W(2*I+J+2+I*J*2+3*I*J*(i-1):2*I+J+1+I*J*3+3*I*J*(i-1),I*J+I+4*J+2+1+ I*J*(i-1): 2*I*J+I+4*J+2+ I*J*(i-1))               = eye(I*J);
end
 

c=[zeros(I,1); reshape(tran_cost', I*J,1)-revenue*ones(I*J,1);...
    -1;-mu+e_mu;-(mu.^2+sigma.^2).*e_sigma_lower;...
    1;mu+e_mu;(mu.^2+sigma.^2).*e_sigma_upper;...
    -reshape(lambda_mu' .* repmat(mu,1,I),[I*J,1]);...
    -reshape(lambda_sigma'.* repmat(e_sigma_lower .*(mu.^2+sigma.^2),1,I),[I*J,1]);...
    reshape(lambda_mu' .* repmat(mu,1,I),[I*J,1]);...
    reshape(lambda_sigma'.* repmat(e_sigma_upper .*(mu.^2+sigma.^2),1,I),[I*J,1])];
 
h=zeros(2*I+J+12*I*J+1,1);
h(I+1)=budget;
h(2*I+J+2+I*J:2*I+J+1+I*J*2)=Big_M*ones(I*J,1);
h(2*I+J+2+I*J*4:2*I+J+1+I*J*5)=Big_M*ones(I*J,1);
h(2*I+J+2+I*J*7:2*I+J+1+I*J*8)=Big_M*ones(I*J,1);
h(2*I+J+2+I*J*10:2*I+J+1+I*J*11)=Big_M*ones(I*J,1);
 
 
T=zeros(2*I+J+12*I*J+1,I); %T is the matrix in b that in fromt of x_{t-1}
T(I+1,:)=build_cost';
T(I+2:2*I+1,:)=-eye(I);
 
W = sparse(W);
T = sparse(T);
h = sparse(h);
 
lambda_t=0;
alpha_t=0.95;


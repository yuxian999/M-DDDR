% generate data points in the support for the ucnertain demand in each stage
function out = demand_normal(t,i,K,mu)
J = size(mu,1);
out = zeros(J,1);
if t == 1
    out = mu ;
else
    rng(i)
    for j = 1:J
        pd = makedist('Normal', 'mu', mu(j), 'sigma', mu(j) * 0.8);
        out(j) = round(random(truncate(pd,0,inf)));
    end
end
end
 
 
 


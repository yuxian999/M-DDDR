% generate demand scenarios where demand(t,i) is the demand in stage t, scenario i
function out = demand(t,i)
if t == 1
    out = 10 ;
else
    if(i == 1)
        out = 5;
    elseif (i == 2)
        out = 10;
    elseif (i == 3)
        out = 15;
    end
end
end




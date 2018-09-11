seq(100);
seq2(100);

function s = seq(k)
    s = zeros(1:1);
    p0 = 1;
    p1 = 1/3;
    s(1) = p0;
    s(2) = p1;
    
    for i=0:k
        pn = (10/3) * p1 - p0;
        p1 = pn;
        p0 = p1;
        s(i+3) = pn;
        disp(pn)
    end
end

function s = seq2(k)
    s = zeros(1:1);
    p0 = 1;
    s(1) = p0;
    
    for i=0:k
        pn = (1/3) * p0;
        p0 = pn;
        s(i+2) = pn;
        disp(pn)
    end
end
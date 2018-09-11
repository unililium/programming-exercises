k = 8;
v = zeros(1,k+1);

for i = 0:k
    v(i+1) = (2 * i + 1)^2;
end

vk = [1:2:2*k+1].^2;

disp(v)
disp(vk)

vvk = cvk(11);
disp(vvk)

Mk = cmk(8);
disp(Mk)

function vk = cvk(k)
    vk = [1:2:2*k+1].^2;
end

function Mk = cmk(k)
    Mk = diag(2.^(1./[1:2*(k+1)]));
    Mk(2:2:end, end) = cvk(k);
    Mk(end, 1:2:end) = cvk(k);
    Mk(end, 2:2:end) = cvk(k);
end
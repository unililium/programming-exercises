% life expectation

% data
x = [7.5 8 8.5 9]; % 1975 1980 1985 1990
yw = [72.8 74.2 75.2 76.4]; % west eu
ye = [70.2 70.2 70.3 71.2]; % east eu
n = 3;
z = [7.7 8.3 8.8];

cw = polyfit(x, yw, n);
ce = polyfit(x, ye, n);

x1 = linspace(0,4*pi);
y1 = polyval(ce,x1);
y2 = polyval(cw,x1);
figure;
hold on;
plot(x,yw,'o');
plot(x,ye,'o');
plot(x1,y1,x1,y2);

rw = polyval(cw, z); % life expectancy in 1977 1983 1988 in west eu
re = polyval(ce, z); % same as above in east eu
plot(z, rw, 'x');
plot(z, re, 'x');
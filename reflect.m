function R = reflect(the0, n, k)
n0 = 1.000292;
N = n-1i*k;
the1=asind(n0*sind(the0)/N);
% u = real(N*cosd(the1));
% v = imag(N*cosd(the1));
% rs = (n0*cosd(the0)-(u+1i*v))/(n0*cosd(the0)+(u+1i*v));
% rp = (n0*(u+1i*v)-((u+1i*v)^2+n0^2*sind(the0)^2)*cosd(the0))/(n0*(u+1i*v)+((u+1i*v)^2+n0^2*sind(the0)^2)*cosd(the0));
M = N*cosd(the1);
rs = (n0*cosd(the0)-M)/(n0*cosd(the0)+M);
rp = (n0*M-(M^2+n0^2*sind(the0)^2)*cosd(the0))/(n0*M+(M^2+n0^2*sind(the0)^2)*cosd(the0));
R(1) = abs(rs)^2;
R(2) = abs(rp)^2;
end
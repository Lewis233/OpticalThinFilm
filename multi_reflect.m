function [h,R,T] = multi_reflect(material,lambs,lambe,dlamb,layers,d,datum,polar,theta0)%remove datum
% datum = preread();%test:multi_reflect({'TiSi2' 'W' 'Pt'},380,780,2,3,[1 2 3],true)
group = importdata('film.list')';
if lambs<lambe && dlamb<(lambe-lambs)
    h = lambs:dlamb:lambe;
    R = zeros(1,size(h,1));
    T = zeros(1,size(h,1));
    a = 0;
    for j = lambs:dlamb:lambe
        a = a + 1;
        A=raw_result(material,j,layers,d,datum,polar,theta0,group);
        B=A(1);
        C=A(2);
        yita0=A(3);
        yitas=A(4);
        Y = C/B;
        r = (yita0-Y)/(yita0+Y);
        R(a) = abs(r)^2;
        if imag(r)~=0
            ksai = abs(real(yitas)/real(B*conj(C)));
            T(a) = (1-R(a))*ksai;
        else
            T(a) = 1-R(a);
        end
    end
%     plot(h,R);
end
        
function res = raw_result(material,lambda,layers,d,datum,polar,theta0,group)
n = zeros(layers+1,1);
k = zeros(layers+1,1);
theta = zeros(layers+1,1);
uv = zeros(layers+1,1);
yita = zeros(layers+1,1);
delta = zeros(layers,1);
n0 = 1.000292;
k0 = 0;
theta0 = theta0*pi/180;
if polar == true%pÆ«Õñ
    yita0 = (n0-1i*k0)/cos(theta0);
else%sÆ«Õñ
    yita0 = (n0-1i*k0)*cos(theta0);
end
for j = 1:layers+1
    if j < 1+layers
        data = cell2mat(datum(trans(material(j),group)));
        n(j) = interp1(data(:,1),data(:,2),lambda,'linear');
        k(j) = interp1(data(:,1),data(:,3),lambda,'linear');
    else
        n(j) = 1.000292;
        k(j) = 0;
    end
    if j == 1
        theta(j) = asin(n0*sin(theta0)/(n(j)-1i*k(j)));
    else
        theta(j) = asin(n(j-1)*sin(theta(j-1))/(n(j)-1i*k(j)));
    end
    uv(j) = (n(j)-1i*k(j))*cos(theta(j));
    if polar%pÆ«Õñ
        yita(j) = (n(j)-1i*k(j))/cos(theta(j));
    else%sÆ«Õñ
        yita(j) = (n(j)-1i*k(j))*cos(theta(j));
    end
    if j < layers+1
        delta(j)=2*pi/lambda*uv(j)*cell2mat(d(j));
    end
end
bc = [1 0;0 1];
for l = 1:layers
    bc = bc*single_matrix(delta(l),yita(l));
end
bc = bc*[1;yita(layers+1)];
res = [bc(1),bc(2),yita(1),yita(layers+1)];

function a = single_matrix(delta,yita)
a = [0 0;0 0];
a(1,1) = cos(delta);
a(1,2) = 1i*sin(delta)/yita;
a(2,1) = 1i*yita*sin(delta);
a(2,2) = cos(delta);

function numb = trans(name,group)
for j = 1:size(group,2)
    if strcmp(name,group(j))
        numb = j;
        break
    end
end

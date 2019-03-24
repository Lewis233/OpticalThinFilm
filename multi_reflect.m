function [R,h] = multi_reflect(material,lambs,lambe,dlamb,layers,d)
datum = preread();%test:multi_reflect({'TiSi2' 'W' 'Pt'},380,780,2,3,[1 2 3])
if lambs<lambe && dlamb<(lambe-lambs)
    h = lambs:dlamb:lambe;
    R = zeros(1,size(h,1));
    a = 0;
    for j = lambs:dlamb:lambe
        a = a + 1;
        A=raw_result(material,j,layers,d,datum);
        B=A(1);
        C=A(2);
        yita0=A(3);
        yitas=A(4);
        Y = C/B;
        r = (yita0-Y)/(yita0+Y);
        R(a) = r*conj(r);
    end
%     plot(h,R);
end
        
function res = raw_result(material,lambda,layers,d,datum)
n = zeros(layers+1,1);
k = zeros(layers+1,1);
theta = zeros(layers+1,1);
uv = zeros(layers+1,1);
yita = zeros(layers+1,1);
delta = zeros(layers-1,1);
n(1) = 1.000292;
k(1) = 0;
theta(1) = 60*pi/180;
uv(1) = n(1)*cos(theta(1));
yita(1) = (n(1)-1i*k(1))/cos(theta(1));

for j = 1:layers
    data = cell2mat(datum(trans(char(material(j)))));
    n(j+1) = interp1(data(:,1),data(:,2),lambda,'linear');
    k(j+1) = interp1(data(:,1),data(:,3),lambda,'linear');
    theta(j+1) = asin(n(j)*sin(theta(j))/(n(j+1)-1i*k(j+1)));
    uv(j+1) = (n(j+1)-1i*k(j+1))*cos(theta(j+1));
    yita(j+1) = (n(j+1)-1i*k(j+1))/cos(theta(j+1));
    if j < layers
        delta(j)=2*pi/lambda*uv(j)*cell2mat(d(j));
    end
end
result = [1 0;0 1];
for l = 1:layers-1
    result = result*single_matrix(delta(l),yita(l+1));
end
result = result*[1;yita(layers)+1];
res = [result(1),result(2),yita(1),yita(layers+1)];

function a = single_matrix(delta,yita)
a = [0 0;0 0];
a(1,1) = cos(delta);
a(1,2) = 1i*sin(delta)/yita;
a(2,1) = 1i*yita*sin(delta);
a(2,2) = cos(delta);

function numb = trans(name)
switch name
    case 'Acrylic'
        numb = 1;
    case 'Pt'
        numb = 2;
    case 'TiSi2'
        numb = 3;
    case 'W'
        numb = 4;
end
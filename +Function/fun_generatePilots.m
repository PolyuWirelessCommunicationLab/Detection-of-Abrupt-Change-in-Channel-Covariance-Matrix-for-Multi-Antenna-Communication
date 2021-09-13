function T_MTX = fun_generatePilots(M,Tr)

T = exp(-1i*2*pi*(0:1:Tr-1)/Tr).';
T_MTX = zeros(Tr,M);
T_MTX1 = ones(Tr,1);

for m = 1:M
    T_MTX(:,m) = T_MTX1;
    T_MTX1 = T_MTX1.*T;
end

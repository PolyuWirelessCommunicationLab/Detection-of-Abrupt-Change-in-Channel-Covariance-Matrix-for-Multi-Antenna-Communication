function h = fun_Generateh(C,M)
%% generate h
h_bo = sqrt(1/2)*(randn(M,1)+randn(M,1)*1j);
h = C^(1/2)*h_bo;
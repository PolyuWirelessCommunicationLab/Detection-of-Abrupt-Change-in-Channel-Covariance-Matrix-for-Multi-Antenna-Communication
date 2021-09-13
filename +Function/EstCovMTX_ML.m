function Ch_Est = EstCovMTX_ML(H_hat,K,T,SNR_dB,SIGMA_B,KAPPA,M)
SNR_1 = 10^(SNR_dB/10);
noise_PW = 1/SNR_1/T;

%% sample covariance matrix
S = 1/K*(H_hat*H_hat');

% sample eigen
[Phi_s,Eig_s] = eig(S);
Eig_c_Vac = 1./diag(abs(Eig_s)); % initialization the estimated eigenvalues

%% upper and lower bound
Eig_Up_I = (SIGMA_B+noise_PW)*ones(M,1);
Eig_Low_I = (KAPPA*SIGMA_B+noise_PW)*ones(M,1);
Comp_num_Up = 1./Eig_Up_I;
Comp_num_Low = 1./Eig_Low_I;

% comp and get the estimated eigenvalues
for i = 1:M
    if Eig_c_Vac(i) > Comp_num_Up(i)
        Eig_c_Vac(i) = Comp_num_Up(i);
    elseif Eig_c_Vac(i) < Comp_num_Low(i)
        Eig_c_Vac(i) = Comp_num_Low(i);
    end
end
% time
Eig_c_MTX = diag(1./Eig_c_Vac);
C2_MTX = Phi_s*Eig_c_MTX*Phi_s';

Ch_Est = C2_MTX - noise_PW*eye(M);

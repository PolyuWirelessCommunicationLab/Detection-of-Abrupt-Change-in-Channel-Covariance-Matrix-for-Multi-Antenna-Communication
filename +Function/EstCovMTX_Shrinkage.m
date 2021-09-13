function Ch_MTX = EstCovMTX_Shrinkage(H_hat,K,T,snr,M)
% Estimate covariance matrix by shrinkage algorithm in TSP 2010
SNR_1 = 10^(snr/10);
noise_PW = 1/SNR_1/T;


S = 1/K *(H_hat*H_hat');
F = trace(S)/M*eye(M);

Tr_S = trace(S);
Tr_S2 = trace(S*S);

rau_Num = -1/T*Tr_S2+Tr_S^2;
rau_Den = (K-1)/T*(Tr_S2-Tr_S^2/T);

rau_OAS =rau_Num/rau_Den;

 if rau_OAS > 1
    rau_OAS = 1;
end

CYhat_MTX = (1-rau_OAS)*S + rau_OAS*F;
Ch_MTX = CYhat_MTX - noise_PW*eye(M);

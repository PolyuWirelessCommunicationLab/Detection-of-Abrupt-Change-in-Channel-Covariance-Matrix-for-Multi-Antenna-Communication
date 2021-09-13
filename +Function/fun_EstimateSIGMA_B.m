function SIGMA_B = fun_EstimateSIGMA_B(C)

SIGMA_Low = 0;
SIGMA_Hig = 1;
dis_SIGMA = SIGMA_Hig - SIGMA_Low;
Threshold = 1e-2;

while dis_SIGMA > Threshold
    SIGMA = (SIGMA_Hig + SIGMA_Low)/2;
    if min(eig(C-SIGMA*eye(size(C)))) < 0
        SIGMA_Hig = SIGMA;
    else
        SIGMA_Low = SIGMA;
    end
    dis_SIGMA = SIGMA_Hig - SIGMA_Low;
end
SIGMA_B = SIGMA_Low;

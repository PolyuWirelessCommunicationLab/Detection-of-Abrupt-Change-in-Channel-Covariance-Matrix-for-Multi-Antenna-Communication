clear
clc
tic

%% Parameters %%%%%%%%%%
% 1- Enanled Parameters
en_EstimateMethod = 1; % Estimation Method (1:Shrinkage; 2:ML)

% 2- System Parameters
T = 32; % training length
M = 32; % number of TX antennas
K = 30; % number of blocks
SNR_dB = 0; % range of the transmit signal-to-noise ratio
SNR_1  = 10^(SNR_dB/10);
MC_Times = 10000; % Monte Carlo simulation times
KAPPA = 4; % Upper bound of the condition number (ML estimation)
CarrFreq_GHz = 80;
CarrFreq_Hz=CarrFreq_GHz * 1e9;
THETA = 9.5:0.1:10.5; % Threshold (NOTE: Need to be carefully selected)

% 3- Channel Parameters
PSI_degree = 20; % multipath parameters —— Angle spread parameters (0.1,1,5) degree
PSI_pi = PSI_degree /360*2*pi;
dPer_timesLamda = 2;
delta_THETA_degree = 0.75; % How much channel changed

% 4- Matrix Used in Channel Cov Generation
D = zeros(M);
for p = 1:M
    for q = 1:M
        if p>=q
            D(p,q) = p-q;
        end
    end
end


%% Main part %%%%%%%%%%
% New Noise Power
SIGMA_New = 1/SNR_1/T;

% Pilot
PILOT_MTX = Function.fun_generatePilots(M,T);

% generate channel
Theta_degree_1 = 0;
Theta_degree_2 = Theta_degree_1 + delta_THETA_degree;
[h_0,C_0] = Function.fun_generateCovH(M,PSI_pi,CarrFreq_Hz,Theta_degree_1,dPer_timesLamda,D); % Channel covariance MTX in the previous frame
[h_1,C_1] = Function.fun_generateCovH(M,PSI_pi,CarrFreq_Hz,Theta_degree_2,dPer_timesLamda,D); % Channel covariance MTX in the current frame (if changed)
C0_MTX = C_0 + SIGMA_New*eye(M);
C0_det = abs(det(C0_MTX));

% Initialization
P_MissDetect = zeros(length(THETA),1);
P_FalseAlarm = zeros(length(THETA),1);
for en_Changed = [0,1] % 0: Not Changed; 1:Changed
    for tTheta = 1:length(THETA)
        Err_MissDetect = 0;
        Err_FalseAlarm = 0;
        parfor tT = 1:MC_Times
            H_hat = zeros(M,K);
            
            for nb = 1:K
                noise = Function.fun_GenerateNoise(SNR_dB,T);
                
                % get channel
                if en_Changed == 0 % no change
                    h_0 = Function.fun_Generateh(C_0,M);
                    y = PILOT_MTX * h_0 + noise;
                else % change
                    h_1 = Function.fun_Generateh(C_1,M);
                    y = PILOT_MTX * h_1 + noise;
                end
                h_hat = 1/T*PILOT_MTX'*y;
                H_hat(:,nb) = h_hat;
            end
            
            % estimate CovMTX C
            if en_Changed == 0
                SIGMA_B = Function.fun_EstimateSIGMA_B(C_0);
            else
                SIGMA_B = Function.fun_EstimateSIGMA_B(C_1);
            end
            
            % choose estimation method
            switch en_EstimateMethod
                case 1
                    C_est = Function.EstCovMTX_Shrinkage(H_hat,K,T,SNR_dB,M); % Shrinkage-based estimation algorithm
                case 2
                    C_est = Function.EstCovMTX_ML(H_hat,K,T,SNR_dB,SIGMA_B,KAPPA,M); % ML estimation algorithm
            end
            
            C2_est = C_est + SIGMA_New*eye(M);
            C_det_est = abs(det(C2_est));
            
            % calculate the LLR2
            LLR1 = -K*log(C0_det) - trace(C0_MTX\(H_hat*H_hat'));
            LLR2 = -K*log(C_det_est) - trace(C2_est\(H_hat*H_hat'));
            
            
            S = (LLR2-LLR1)/K;
            
            %% count the error time
            if S < THETA(tTheta)
                Judgement = 0;
            else
                Judgement = 1;
            end
            
            if Judgement ~= en_Changed
                if en_Changed == 0
                    Err_FalseAlarm = Err_FalseAlarm + 1;
                else
                    Err_MissDetect = Err_MissDetect + 1;
                end
            end
            
        end
        display(strcat('en_Chg=',num2str(en_Changed),'; THETA=',num2str(THETA(tTheta))));
        
        if en_Changed == 0
            P_FalseAlarm(tTheta) = Err_FalseAlarm/MC_Times;
        else
            P_MissDetect(tTheta) = Err_MissDetect/MC_Times;
        end
        
    end
end

linewidth = 2;
markersize = 10;

%% Plot %%%%%%%%%%
figure

loglog(P_FalseAlarm,P_MissDetect,'r--o','LineWidth',linewidth,'MarkerSize',markersize)
xlabel('P_{FA}')
ylabel('P_{MD}')
grid on
toc

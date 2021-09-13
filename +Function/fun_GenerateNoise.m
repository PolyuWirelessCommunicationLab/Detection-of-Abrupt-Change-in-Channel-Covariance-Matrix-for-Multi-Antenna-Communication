function [noise] = fun_GenerateNoise(SNR_dB,T)
SNR_1 = 10^(SNR_dB/10);
noise_PW = 1/SNR_1;
noise = sqrt(noise_PW/2)*(randn(T, 1)+1j*randn(T, 1));
end
# Detection-of-Abrupt-Change-in-Channel-Covariance-Matrix-for-Multi-Antenna-Communication
This code is for paper: [R. Liu, L. Liu, D. He, W. Zhang, and E. G. Larsson, "Detection of abrupt change in channel covariance matrix for multi-antenna communication," to appear in IEEE Global Communications Conference (Globecom), 2021.](https://arxiv.org/abs/2109.04192)
# Abstract
The knowledge of channel covariance matrices is of paramount importance to the estimation of instantaneous channels and the design of beamforming vectors in multi-antenna systems. In practice, an abrupt change in channel covariance matrices may occur due to the change in the environment and the user location. Although several works have proposed efficient algorithms to estimate the channel covariance matrices after any change occurs, how to detect such a change accurately and quickly is still an open problem in the literature. In this paper, we focus on channel covariance change detection between a multi-antenna base station (BS) and a single-antenna user equipment (UE). To provide theoretical performance limit, we first propose a genie-aided change detector based on the log-likelihood ratio (LLR) test assuming the channel covariance matrix after change is known, and characterize the corresponding missed detection and false alarm probabilities. Then, this paper considers the practical case where the channel covariance matrix after change is unknown. The maximum likelihood (ML) estimation technique is used to predict the covariance matrix based on the received pilot signals over a certain number of coherence blocks, building upon which the LLR-based change detector is employed. Numerical results show that our proposed scheme can detect the change with low error probability even when the number of channel samples is small such that the estimation of the covariance matrix is not that accurate. This result verifies the possibility to detect the channel covariance change both accurately and quickly in practice.
# Readme
ChgDet_ChannelCov.m is the main function.
# Citation
@article{liu2021detection,<br>
  title={Detection of Abrupt Change in Channel Covariance Matrix for Multi-Antenna Communication},<br>
  author={Liu, Runnan and Liu, Liang and He, Dazhi and Zhang, Wenjun and Larsson, Erik G.},<br>
  journal={arXiv preprint arXiv:2109.04192},<br>
  year={2021}<br>
}
# Note
The code is provided for the benefit of better understanding the results, and is not meant to be used in production.

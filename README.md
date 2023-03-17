# Detecting Abrupt Change in Channel Covariance Matrix for MIMO Communication
This code is for paper: [R. Liu, L. Liu, D. He, W. Zhang, and E. G. Larsson, "Detecting abrupt changes in channel covariance matrix for MIMO communication," to appear in IEEE Trans. Wireless Commun.. ](https://arxiv.org/abs/2207.01984)
# Abstract
The acquisition of the channel covariance matrix is of paramount importance to many strategies in multiple-input-multiple-output (MIMO) communications, such as the minimum mean-square error (MMSE) channel estimation. Therefore, plenty of efficient channel covariance matrix estimation schemes have been proposed in the literature. However, an abrupt change in the channel covariance matrix may happen occasionally in practice due to the change in the scattering environment and the user location. Our paper aims to adopt the classic change detection theory to detect the change in the channel covariance matrix as accurately and quickly as possible such that the new covariance matrix can be re-estimated in time. Specifically, this paper first considers the technique of on-line change detection (also known as quickest/sequential change detection), where we need to detect whether a change in the channel covariance matrix occurs at each channel coherence time interval. Next, because the complexity of detecting the change in a high-dimension covariance matrix at each coherence time interval is too high, we devise a low-complexity off-line strategy in massive MIMO systems, where change detection is merely performed at the last channel coherence time interval of a given time period. Numerical results show that our proposed on-line and off-line schemes can detect the channel covariance change with a small delay and a low false alarm rate. Therefore, our paper theoretically and numerically verifies the feasibility of detecting the channel covariance change accurately and quickly in practice.
# Readme
ANA_Known_MIMO_Online.m and SIM_Known_MIMO_Online.m are the main function for Fig. 5.
SIM_Known_MIMO_Online.m is also the main function for Fig. 6.
SIM_UnKnown_MIMO_Online_WLGLR.m is the main function for Fig. 7.
SIM_Unknown_MassiveMIMO.m is the main function for Fig. 8 and Fig. 9.


# Citation
@article{liu2021detection,<br>
  title={Detecting abrupt changes in channel covariance matrix for MIMO communication},<br>
  author={Liu, Runnan and Liu, Liang and He, Dazhi and Zhang, Wenjun and Larsson, Erik G.},<br>
  journal={arXiv preprint arXiv:2207.01984},<br>
  year={2023}<br>
}
# Note
The code is provided for the benefit of better understanding the results, and is not meant to be used in production.

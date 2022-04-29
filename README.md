# NPS measurement properties
This repository contains codes for the analyses and figures in the paper which has been published on *NeuroImage* titled ["Effect sizes and test-retest reliability of the fMRI-based neurologic pain signature"](https://www.sciencedirect.com/science/article/pii/S1053811921011150). In this paper, we systematically examined the effect sizes and test-retest reliabiliy of a well-established multivariate brain measure that tracks pain induced by nociceptive input, the Neurologic Pain Signature (NPS), across __ten__ studies and __444__ participants. 

### Code
* Each folder named by figure names (e.g., `Figure1B_NPS_four_effect_size`) contains codes to plot the corresponding figures and the underlying data analyses.
* The folder named by `More_analyses_codes` contains codes to do the corresponding data analyses without figure ploting.
* The folder named by `Utils` contains customized functions for this repository.
* __Dependecies__: Before running codes in this repository, you need to add [CanlabCore Toolbox](https://github.com/canlab/CanlabCore) to your path with subfolders.

### Source data
* The source data for all analyses and figures is available [here on the osf](https://osf.io/v9px7/). After downloading these files, you could save them in a folder named by `Osf_data` and run the codes.
* The NPS maps, including `weights_NSF_grouppred_cvpcr.img` and `weights_NSF_grouppred_cvpcr_FDR05.img`, are available in the repository of [MaskPrivate](https://github.com/canlab/MasksPrivate) or by request to Prof. Tor D. Wager (Tor.D.Wager@Dartmouth.edu).

### Authors
* Correspondence: Tor D. Wager (Tor.D.Wager@Dartmouth.edu)
* You could also contact with Xiaochun Han (xiaochun.han@bnu.edu.cn)

library(psych)
setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D03_OLP4CBP/P01_Extract_data')
wd<-getwd()
time1 <- read.csv('Time1_data.csv',header=TRUE,sep=",")
time2 <- read.csv('Time2_data.csv',header=TRUE,sep=",")
## test-retest thumb: Waitlies ##
Wait1 <- time1[time1$group == 3,]
Wait2 <- time2[time2$group == 3,]
#dotproduct#
x1 = data.frame(Wait1$thumb_lo_nps_dotprod, Wait2$thumb_lo_nps_dotprod)
ICC(x1)
x2 = data.frame(Wait1$thumb_hi_nps_dotprod, Wait2$thumb_hi_nps_dotprod)
ICC(x2)
x3 = data.frame(Wait1$thumb_hi_vs_lo_nps_dotprod, Wait2$thumb_hi_vs_lo_nps_dotprod)
ICC(x3)
x4 = data.frame(Wait1$thumb_mean_nps_dotprod, Wait2$thumb_mean_nps_dotprod)
ICC(x4)

#cossim#
x1 = data.frame(Wait1$thumb_lo_nps_cossim, Wait2$thumb_lo_nps_cossim)
ICC(x1)
x2 = data.frame(Wait1$thumb_hi_nps_cossim, Wait2$thumb_hi_nps_cossim)
ICC(x2)
x3 = data.frame(Wait1$thumb_hi_vs_lo_nps_cossim, Wait2$thumb_hi_vs_lo_nps_cossim)
ICC(x3)
x4 = data.frame(Wait1$thumb_mean_nps_cossim, Wait2$thumb_mean_nps_cossim)
ICC(x4)

#corr#
x1 = data.frame(Wait1$thumb_lo_nps_corr, Wait2$thumb_lo_nps_corr)
ICC(x1)
x2 = data.frame(Wait1$thumb_hi_nps_corr, Wait2$thumb_hi_nps_corr)
ICC(x2)
x3 = data.frame(Wait1$thumb_hi_vs_lo_nps_corr, Wait2$thumb_hi_vs_lo_nps_corr)
ICC(x3)
x4 = data.frame(Wait1$thumb_mean_nps_corr, Wait2$thumb_mean_nps_corr)
ICC(x4)

#pain rating#
x1 = data.frame(Wait1$thumb_lo_meanpain, Wait2$thumb_lo_meanpain)
ICC(x1)
x2 = data.frame(Wait1$thumb_hi_meanpain, Wait2$thumb_hi_meanpain)
ICC(x2)
x3 = data.frame(Wait1$thumb_hi_vs_lo_meanpain, Wait2$thumb_hi_vs_lo_meanpain)
ICC(x3)
x4 = data.frame(Wait1$thumb_mean_meanpain, Wait2$thumb_mean_meanpain)
ICC(x4)


## test-retest thumb: Placebo ##
Placebo1 <- time1[time1$group == 2,]
Placebo2 <- time2[time2$group == 2,]
#dotproduct#
x1 = data.frame(Placebo1$thumb_lo_nps_dotprod, Placebo2$thumb_lo_nps_dotprod)
ICC(x1)
x2 = data.frame(Placebo1$thumb_hi_nps_dotprod, Placebo2$thumb_hi_nps_dotprod)
ICC(x2)
x3 = data.frame(Placebo1$thumb_hi_vs_lo_nps_dotprod, Placebo2$thumb_hi_vs_lo_nps_dotprod)
ICC(x3)
x4 = data.frame(Placebo1$thumb_mean_nps_dotprod, Placebo2$thumb_mean_nps_dotprod)
ICC(x4)

#cossim#
x1 = data.frame(Placebo1$thumb_lo_nps_cossim, Placebo2$thumb_lo_nps_cossim)
ICC(x1)
x2 = data.frame(Placebo1$thumb_hi_nps_cossim, Placebo2$thumb_hi_nps_cossim)
ICC(x2)
x3 = data.frame(Placebo1$thumb_hi_vs_lo_nps_cossim, Placebo2$thumb_hi_vs_lo_nps_cossim)
ICC(x3)
x4 = data.frame(Placebo1$thumb_mean_nps_cossim, Placebo2$thumb_mean_nps_cossim)
ICC(x4)

#corr#
x1 = data.frame(Placebo1$thumb_lo_nps_corr, Placebo2$thumb_lo_nps_corr)
ICC(x1)
x2 = data.frame(Placebo1$thumb_hi_nps_corr, Placebo2$thumb_hi_nps_corr)
ICC(x2)
x3 = data.frame(Placebo1$thumb_hi_vs_lo_nps_corr, Placebo2$thumb_hi_vs_lo_nps_corr)
ICC(x3)
x4 = data.frame(Placebo1$thumb_mean_nps_corr, Placebo2$thumb_mean_nps_corr)
ICC(x4)

#pain rating#
x1 = data.frame(Placebo1$thumb_lo_nps_meanpain, Placebo2$thumb_lo_nps_meanpain)
ICC(x1)
x2 = data.frame(Placebo1$thumb_hi_nps_meanpain, Placebo2$thumb_hi_nps_meanpain)
ICC(x2)
x3 = data.frame(Placebo1$thumb_hi_vs_lo_nps_meanpain, Placebo2$thumb_hi_vs_lo_nps_meanpain)
ICC(x3)
x4 = data.frame(Placebo1$thumb_mean_nps_meanpain, Placebo2$thumb_mean_nps_meanpain)
ICC(x4)



## test-retest thumb: Therapy ##
Therapy1 <- time1[time1$group == 1,]
Therapy2 <- time2[time2$group == 1,]
#dotproduct#
x1 = data.frame(Therapy1$thumb_lo_nps_dotprod, Therapy2$thumb_lo_nps_dotprod)
ICC(x1)
x2 = data.frame(Therapy1$thumb_hi_nps_dotprod, Therapy2$thumb_hi_nps_dotprod)
ICC(x2)
x3 = data.frame(Therapy1$thumb_hi_vs_lo_nps_dotprod, Therapy2$thumb_hi_vs_lo_nps_dotprod)
ICC(x3)
x4 = data.frame(Therapy1$thumb_mean_nps_dotprod, Therapy2$thumb_mean_nps_dotprod)
ICC(x4)

#cossim#
x1 = data.frame(Therapy1$thumb_lo_nps_cossim, Therapy2$thumb_lo_nps_cossim)
ICC(x1)
x2 = data.frame(Therapy1$thumb_hi_nps_cossim, Therapy2$thumb_hi_nps_cossim)
ICC(x2)
x3 = data.frame(Therapy1$thumb_hi_vs_lo_nps_cossim, Therapy2$thumb_hi_vs_lo_nps_cossim)
ICC(x3)
x4 = data.frame(Therapy1$thumb_mean_nps_cossim, Therapy2$thumb_mean_nps_cossim)
ICC(x4)

#corr#
x1 = data.frame(Therapy1$thumb_lo_nps_corr, Therapy2$thumb_lo_nps_corr)
ICC(x1)
x2 = data.frame(Therapy1$thumb_hi_nps_corr, Therapy2$thumb_hi_nps_corr)
ICC(x2)
x3 = data.frame(Therapy1$thumb_hi_vs_lo_nps_corr, Therapy2$thumb_hi_vs_lo_nps_corr)
ICC(x3)
x4 = data.frame(Therapy1$thumb_mean_nps_corr, Therapy2$thumb_mean_nps_corr)
ICC(x4)

#pain rating#
x1 = data.frame(Therapy1$thumb_lo_nps_meanpain, Therapy2$thumb_lo_nps_meanpain)
ICC(x1)
x2 = data.frame(Therapy1$thumb_hi_nps_meanpain, Therapy2$thumb_hi_nps_meanpain)
ICC(x2)
x3 = data.frame(Therapy1$thumb_hi_vs_lo_nps_meanpain, Therapy2$thumb_hi_vs_lo_nps_meanpain)
ICC(x3)
x4 = data.frame(Therapy1$thumb_mean_nps_meanpain, Therapy2$thumb_mean_nps_meanpain)
ICC(x4)
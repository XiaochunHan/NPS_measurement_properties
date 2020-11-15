library(psych)
setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior')
wd<-getwd()
Data <- read.csv('mean12_nps_rating.csv',header=TRUE,sep=",")
## study ##
bmrk3 <- Data[Data$studyName == 'bmrk3pain',]
bmrk4 <- Data[Data$studyName == 'bmrk4',]
bmrk5 <- Data[Data$studyName == 'bmrk5pain_xc',]
exp <- Data[Data$studyName == 'exp',]
ie <- Data[Data$studyName == 'ie',]
ie2 <- Data[Data$studyName == 'ie2',]
ilcp <- Data[Data$studyName == 'ilcp',]
nsf <- Data[Data$studyName == 'nsf',]
scebl <- Data[Data$studyName == 'scebl',]

#bmrk3#
nps1 = data.frame(bmrk3$nps1, bmrk3$nps2)
ICC(nps1)
pain1 = data.frame(bmrk3$pain1, bmrk3$pain2)
ICC(pain1)

#bmrk4#
nps2 = data.frame(bmrk4$nps1, bmrk4$nps2)
ICC(nps2)
pain2 = data.frame(bmrk4$pain1, bmrk4$pain2)
ICC(pain2)

#bmrk5#
nps3 = data.frame(bmrk5$nps1, bmrk5$nps2)
ICC(nps3)
pain3 = data.frame(bmrk5$pain1, bmrk5$pain2)
ICC(pain3)

#exp#
nps4 = data.frame(exp$nps1, exp$nps2)
ICC(nps4)
pain4 = data.frame(exp$pain1, exp$pain2)
ICC(pain4)

#ie#
nps5 = data.frame(ie$nps1, ie$nps2)
ICC(nps5)
pain5 = data.frame(ie$pain1, ie$pain2)
ICC(pain5)

#ie2#
nps6 = data.frame(ie2$nps1, ie2$nps2)
ICC(nps6)
pain6 = data.frame(ie2$pain1, ie2$pain2)
ICC(pain6)

#ilcp#
nps7 = data.frame(ilcp$nps1, ilcp$nps2)
ICC(nps7)
pain7 = data.frame(ilcp$pain1, ilcp$pain2)
ICC(pain7)

#nsf#
nps8 = data.frame(nsf$nps1, nsf$nps2)
ICC(nps8)
pain8 = data.frame(nsf$pain1, nsf$pain2)
ICC(pain8)

#scebl#
nps9 = data.frame(scebl$nps1, scebl$nps2)
ICC(nps9)
pain9 = data.frame(scebl$pain1, scebl$pain2)
ICC(pain9)
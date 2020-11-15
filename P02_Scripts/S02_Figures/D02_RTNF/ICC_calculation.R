library(psych)
setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D02_RTNF/P05_result')
wd<-getwd()
Data <- read.csv('RTNF_NPS_Rating_three_times.csv',header=TRUE,sep=",")
## test-retest ##
Time1 <- Data[Data$sesID == 1,]
Time2 <- Data[Data$sesID == 2,]
Time3 <- Data[Data$sesID == 3,]

#dotproduct#
x1 = data.frame(Time1$dotProduct, Time2$dotProduct, Time3$dotProduct)
ICC(x1)

#cossim#
x2 = data.frame(Time1$cossim, Time2$cossim, Time3$cossim)
ICC(x2)

#corr#
x3 = data.frame(Time1$corr, Time2$corr, Time3$corr)
ICC(x3)

#pain rating#
x4 = data.frame(Time1$rating, Time2$rating, Time3$rating)
ICC(x4)
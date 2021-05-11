library(psych)
library(ggplot2)
library(ggpubr)
setwd('/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D02_RTNF')
wd<-getwd()
Data <- read.csv('RTNF_NPS_Rating_select_three_times_all_trial.csv',header=TRUE,sep=",")
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

#######correlation#############
#Time1 & Time2
col=rgb(50/255,50/255,50/255)
ds1 <- data.frame(Time1$dotProduct,Time2$dotProduct,Time3$dotProduct)
p1<-ggplot(ds1,aes(x=Time1.dotProduct,y=Time2.dotProduct)) + geom_point(alpha = 0.8, size = 2, colour = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("RTNF_Correlation_Time1_Time2.tiff",units="in",width = 3.5,height = 3,res = 300)
p1+stat_cor(method="pearson")
dev.off()

#Time1 & Time3
p2<-ggplot(ds1,aes(x=Time1.dotProduct,y=Time3.dotProduct)) + geom_point(alpha = 0.8, size = 2, colour = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("RTNF_Correlation_Time1_Time3.tiff",units="in",width = 3.5,height = 3,res = 300)
p2+stat_cor(method="pearson")
dev.off()

#Time2 & Time3
p3<-ggplot(ds1,aes(x=Time2.dotProduct,y=Time3.dotProduct)) + geom_point(alpha = 0.8, size = 2, colour = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("RTNF_Correlation_Time2_Time3.tiff",units="in",width = 3.5,height = 3,res = 300)
p3+stat_cor(method="pearson")
dev.off()

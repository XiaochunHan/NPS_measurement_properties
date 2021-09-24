library(psych)
library(ggplot2)
library(ggpubr)
#setwd('./Osf_data')
Data <- read.csv('Study9.csv',header=TRUE,sep=",")
## test-retest ##
Time1 <- Data[Data$ses_id == 1,]
Time2 <- Data[Data$ses_id == 2,]
Time3 <- Data[Data$ses_id == 3,]

#dotproduct#
x1 = data.frame(Time1$nps, Time2$nps, Time3$nps)
ICC(x1)

#######correlation#############
#Time1 & Time2
col=rgb(50/255,50/255,50/255)
ds <- data.frame(Time1$nps,Time2$nps,Time3$nps)
p1<-ggplot(ds,aes(x=Time1.nps,y=Time2.nps)) + geom_point(alpha = 0.8, size = 2, colour = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p1+stat_cor(method="pearson")

#Time1 & Time3
p2<-ggplot(ds,aes(x=Time1.nps,y=Time3.nps)) + geom_point(alpha = 0.8, size = 2, colour = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p2+stat_cor(method="pearson")

#Time2 & Time3
p3<-ggplot(ds,aes(x=Time2.nps,y=Time3.nps)) + geom_point(alpha = 0.8, size = 2, colour = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p3+stat_cor(method="pearson")




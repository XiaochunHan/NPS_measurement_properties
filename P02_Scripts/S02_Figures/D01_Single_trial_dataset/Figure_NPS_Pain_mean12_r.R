library(readxl)
library(ggplot2)
library(plotrix)
library(ggpubr)
setwd('/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset')
wd<-getwd()
Data <- read.csv('scaled_mean12_nps_rating_exclude_nsf.csv',header=TRUE,sep=",")
## study ##
bmrk3 <- Data[Data$studyName == 'bmrk3pain',]
bmrk4 <- Data[Data$studyName == 'bmrk4',]
bmrk5 <- Data[Data$studyName == 'bmrk5pain_xc',]
exp <- Data[Data$studyName == 'exp',]
ie <- Data[Data$studyName == 'ie',]
ie2 <- Data[Data$studyName == 'ie2',]
ilcp <- Data[Data$studyName == 'ilcp',]
scebl <- Data[Data$studyName == 'scebl',]

setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
col=rgb(50/255,50/255,50/255)
#bmrk3#
tiff("Pain_mean12_r_1.tiff",units="in",width = 3.5,height = 3,res = 300)
p1<-ggplot(bmrk3,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color = col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p1+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_1.tiff",units="in",width = 3.5,height = 3,res = 300)
b1<-ggplot(bmrk3,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b1+stat_cor(method="pearson")
dev.off()

#bmrk4#
tiff("Pain_mean12_r_2.tiff",units="in",width = 3.5,height = 3,res = 300)
p2<-ggplot(bmrk4,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p2+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_2.tiff",units="in",width = 3.5,height = 3,res = 300)
b2<-ggplot(bmrk4,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b2+stat_cor(method="pearson")
dev.off()

#bmrk5#
tiff("Pain_mean12_r_3.tiff",units="in",width = 3.5,height = 3,res = 300)
p3<-ggplot(bmrk5,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p3+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_3.tiff",units="in",width = 3.5,height = 3,res = 300)
b3<-ggplot(bmrk5,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b3+stat_cor(method="pearson")
dev.off()

#exp#
tiff("Pain_mean12_r_4.tiff",units="in",width = 3.5,height = 3,res = 300)
p4<-ggplot(exp,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p4+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_4.tiff",units="in",width = 3.5,height = 3,res = 300)
b4<-ggplot(exp,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b4+stat_cor(method="pearson")
dev.off()

#ie#
tiff("Pain_mean12_r_5.tiff",units="in",width = 3.5,height = 3,res = 300)
p5<-ggplot(ie,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p5+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_5.tiff",units="in",width = 3.5,height = 3,res = 300)
b5<-ggplot(ie,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b5+stat_cor(method="pearson")
dev.off()

#ie2#
tiff("Pain_mean12_r_6.tiff",units="in",width = 3.5,height = 3,res = 300)
p6<-ggplot(ie2,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p6+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_6.tiff",units="in",width = 3.5,height = 3,res = 300)
b6<-ggplot(ie2,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b6+stat_cor(method="pearson")
dev.off()

#ilcp#
tiff("Pain_mean12_r_7.tiff",units="in",width = 3.5,height = 3,res = 300)
p7<-ggplot(ilcp,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p7+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_7.tiff",units="in",width = 3.5,height = 3,res = 300)
b7<-ggplot(ilcp,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b7+stat_cor(method="pearson")
dev.off()

#scebl#
tiff("Pain_mean12_r_8.tiff",units="in",width = 3.5,height = 3,res = 300)
p8<-ggplot(scebl,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p8+stat_cor(method="pearson")
dev.off()
tiff("NPS_mean12_r_8.tiff",units="in",width = 3.5,height = 3,res = 300)
b8<-ggplot(scebl,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b8+stat_cor(method="pearson")
dev.off()




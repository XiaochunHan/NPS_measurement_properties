library(readxl)
library(ggplot2)
library(plotrix)
library(ggpubr)
#setwd('./FigureS3_Correlation_NPS_Pain_rating_1st_and_2nd_half_trials')
Data <- read.csv('mean12_nps_rating.csv',header=TRUE,sep=",")
## Studies ##
Study1 <- Data[Data$studyName == 'Study1',]
Study2 <- Data[Data$studyName == 'Study2',]
Study3 <- Data[Data$studyName == 'Study3',]
Study4 <- Data[Data$studyName == 'Study4',]
Study5 <- Data[Data$studyName == 'Study5',]
Study6 <- Data[Data$studyName == 'Study6',]
Study7 <- Data[Data$studyName == 'Study7',]
Study8 <- Data[Data$studyName == 'Study8',]

col=rgb(50/255,50/255,50/255)
#####Study1#####
#Pain rating#
p1<-ggplot(Study1,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color = col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p1+stat_cor(method="pearson")
#NPS#
b1<-ggplot(Study1,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b1+stat_cor(method="pearson")

#####Study2#####
#Pain rating#
p2<-ggplot(Study2,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p2+stat_cor(method="pearson")
#NPS#
b2<-ggplot(Study2,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b2+stat_cor(method="pearson")

#####Study3#####
#Pain rating#
p3<-ggplot(Study3,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p3+stat_cor(method="pearson")
#NPS#
b3<-ggplot(Study3,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b3+stat_cor(method="pearson")

#####Study4#####
#Pain rating#
p4<-ggplot(Study4,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p4+stat_cor(method="pearson")
#NPS#
b4<-ggplot(Study4,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b4+stat_cor(method="pearson")

#####Study5#####
#Pain rating#
p5<-ggplot(Study5,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p5+stat_cor(method="pearson")
#NPS#
b5<-ggplot(Study5,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b5+stat_cor(method="pearson")

#####Study6#####
#Pain rating#
p6<-ggplot(Study6,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p6+stat_cor(method="pearson")
#NPS#
b6<-ggplot(Study6,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b6+stat_cor(method="pearson")

#####Study7#####
#Pain rating#
p7<-ggplot(Study7,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p7+stat_cor(method="pearson")
#NPS#
b7<-ggplot(Study7,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b7+stat_cor(method="pearson")

#####Study8#####
#Pain rating#
p8<-ggplot(Study8,aes(x=pain1,y=pain2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p8+stat_cor(method="pearson")
#NPS#
b8<-ggplot(Study8,aes(x=nps1,y=nps2)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
b8+stat_cor(method="pearson")

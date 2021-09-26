library(readxl)
library(ggplot2)
library(plotrix)
library(ggpubr)

#setwd('./FigureS1D_NPS_between_r_pain_rating')
file = 'NPS_between_r_pain.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
col=rgb(119/255,159/255,209/255)

# Correlation Study1
ds1 <- my_data[my_data$study == "Study1",]
p1<-ggplot(ds1,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p1+stat_cor(method="pearson")

# Correlation Study2
ds2 <- my_data[my_data$study == "Study2",]
p2<-ggplot(ds2,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p2+stat_cor(method="pearson")

# Correlation Study3
ds3 <- my_data[my_data$study == "Study3",]
p3<-ggplot(ds3,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p3+stat_cor(method="pearson")

# Correlation Study4
ds4 <- my_data[my_data$study == "Study4",]
p4<-ggplot(ds4,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p4+stat_cor(method="pearson")

# Correlation Study5
ds5 <- my_data[my_data$study == "Study5",]
p5<-ggplot(ds5,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p5+stat_cor(method="pearson")

# Correlation Study6
ds6 <- my_data[my_data$study == "Study6",]
p6<-ggplot(ds6,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p6+stat_cor(method="pearson")

# Correlation Study7
ds7 <- my_data[my_data$study == "Study7",]
p7<-ggplot(ds7,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p7+stat_cor(method="pearson")

# Correlation Study8
ds8 <- my_data[my_data$study == "Study8",]
p8<-ggplot(ds8,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
p8+stat_cor(method="pearson")


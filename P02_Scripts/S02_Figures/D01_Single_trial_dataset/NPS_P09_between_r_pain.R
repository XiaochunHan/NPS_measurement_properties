library(readxl)
library(ggplot2)
library(plotrix)
library(ggpubr)

file = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior/NPS_between_r_pain_nsf.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
col=rgb(119/255,159/255,209/255)

ds1 <- my_data[my_data$study == "bmrk3pain",]
p1<-ggplot(ds1,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds2 <- my_data[my_data$study == "bmrk4",]
p2<-ggplot(ds2,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, size = 2, color = col) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds3 <- my_data[my_data$study == "bmrk5pain_xc",]
p3<-ggplot(ds3,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds4 <- my_data[my_data$study == "exp",]
p4<-ggplot(ds4,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds5 <- my_data[my_data$study == "ie",]
p5<-ggplot(ds5,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds6 <- my_data[my_data$study == "ie2",]
p6<-ggplot(ds6,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds7 <- my_data[my_data$study == "ilcp",]
p7<-ggplot(ds7,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
#ds8 <- my_data[my_data$study == "nsf",]
#p8<-ggplot(ds8,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
ds9 <- my_data[my_data$study == "scebl",]
p9<-ggplot(ds9,aes(x=pain,y=nps)) + geom_point(alpha = 0.8, color = col, size = 2) + geom_smooth(method=lm , size = 1, color=col, se=TRUE) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))


setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_1_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p1#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_2_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p2#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_3_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p3#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_4_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p4#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_5_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p5#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_6_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p6#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_7_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p7#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_8_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p8#+stat_cor(method="pearson")
dev.off()

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain_9_no.tiff",units="in",width = 3.5,height = 3,res = 300)
p9#+stat_cor(method="pearson")
dev.off()

theme_set(
  theme_classic()
)
figure <- ggarrange(p1, p2, p3, p4, p5, p6, p7, p8, p9,
                    #labels = c("bmrk3pain", "bmrk4", "bmrk5pain", "exp", "ie", "ie2", "ilcp", "nsf", "scebl"),
                    labels = "auto",
                    ncol = 3, nrow = 3)
setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_between_r_pain.tiff",units="in",width = 9,height = 8,res = 300)

figure
dev.off()



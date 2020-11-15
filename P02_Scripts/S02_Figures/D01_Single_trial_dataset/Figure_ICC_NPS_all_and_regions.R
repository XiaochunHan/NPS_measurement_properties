library(readxl)
library(ggplot2)
library(plotrix)

file = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior/ICC_all_and_regions.csv'
my_data = read.csv(file,header=TRUE)
my_data = my_data[1:9,]

# colors settings
pain <- rgb(60/255,60/255,60/255)
nps <- rgb(204/255,48/255,115/255)
npspos <- rgb(212/255,147/255,183/255)
npsneg <- rgb(147/255,149/255,152/255)

# Orgnized data format
Org <- data.frame(matrix(nrow = 153))
Org$brain<-rep(c("Ratings","NPS","vermis","rIns","rV1","rThal","lIns","rdpIns","rS2","dAcc","rLOC","lLOC","rpLOC","pgACC","lSTS","rIPL","PCC"),each = 9)
Org$icc <- c(my_data$rating,my_data$NPS,my_data$vermis,my_data$rIns,my_data$rV1,my_data$rThal,my_data$lIns,my_data$rdpIns,my_data$rS2,my_data$dACC,my_data$rLOC,my_data$lLOC,my_data$rpLOC,my_data$pgACC,my_data$lSTS,my_data$rIPL,my_data$PCC)
Org$brain <- factor(Org$brain, level = c("Ratings","NPS","rIns","rV1","rS2","rdpIns","dAcc","lIns","vermis","rThal","lSTS","PCC","rpLOC","lLOC","rIPL","rLOC","pgACC"))

# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_ICC_subregions.tiff",units="in",width = 12,height = 8,res = 300)
p<-ggplot(Org,aes(x=brain,y=icc, colour = factor(brain))) + geom_hline(yintercept=0.4,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.6,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.75,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(pain,nps,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+coord_cartesian(ylim=c(0,1))+scale_y_continuous(breaks = c(0,0.4,0.6,0.75,1))
dev.off()

# Orgnized data format
OrgPos <- data.frame(matrix(nrow = 90))
OrgPos$brain<-rep(c("Ratings","NPS","vermis","rIns","rV1","rThal","lIns","rdpIns","rS2","dAcc"),each = 9)
OrgPos$icc <- c(my_data$rating,my_data$NPS,my_data$vermis,my_data$rIns,my_data$rV1,my_data$rThal,my_data$lIns,my_data$rdpIns,my_data$rS2,my_data$dACC)
OrgPos$brain <- factor(OrgPos$brain, level = c("Ratings","NPS","rIns","rV1","rS2","rdpIns","dAcc","lIns","vermis","rThal"))

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_ICC_subregions_positive.tiff",units="in",width = 12,height = 8,res = 300)
p<-ggplot(OrgPos,aes(x=brain,y=icc, colour = factor(brain))) + geom_hline(yintercept=0.4,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.6,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.75,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(pain,pain,pain,pain,pain,pain,pain,pain,pain,pain)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1.5) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+coord_cartesian(ylim=c(0,1))+scale_y_continuous(breaks = c(0,0.4,0.6,0.75,1))
dev.off()

# T-test
# NPS and Rating
t0 <- Org[(Org$brain == 'NPS' | Org$brain == 'Ratings'),]
test0<-t.test(icc~brain,data = t0, paired = TRUE)

# NPS and rIns
t1 <- Org[(Org$brain == 'NPS' | Org$brain == 'rIns'),]
test1<-t.test(icc~brain,data = t1, paired = TRUE)

# NPS and rV1
t2 <- Org[(Org$brain == 'NPS' | Org$brain == 'rV1'),]
test2<-t.test(icc~brain,data = t2, paired = TRUE)

# NPS and rS2
t3 <- Org[(Org$brain == 'NPS' | Org$brain == 'rS2'),]
test3<-t.test(icc~brain,data = t3, paired = TRUE)

# NPS and rdpIns
t4 <- Org[(Org$brain == 'NPS' | Org$brain == 'rdpIns'),]
test4<-t.test(icc~brain,data = t4, paired = TRUE)

# NPS and dAcc
t5 <- Org[(Org$brain == 'NPS' | Org$brain == 'dAcc'),]
test5<-t.test(icc~brain,data = t5, paired = TRUE)

# NPS and lIns
t6 <- Org[(Org$brain == 'NPS' | Org$brain == 'lIns'),]
test6<-t.test(icc~brain,data = t6, paired = TRUE)

# NPS and vermis
t7 <- Org[(Org$brain == 'NPS' | Org$brain == 'vermis'),]
test7<-t.test(icc~brain,data = t7, paired = TRUE)

# NPS and rThal
t8 <- Org[(Org$brain == 'NPS' | Org$brain == 'rThal'),]
test8<-t.test(icc~brain,data = t8, paired = TRUE)

# NPS and lSTS
t9 <- Org[(Org$brain == 'NPS' | Org$brain == 'lSTS'),]
test9<-t.test(icc~brain,data = t9, paired = TRUE)

# NPS and PCC
t10 <- Org[(Org$brain == 'NPS' | Org$brain == 'PCC'),]
test10<-t.test(icc~brain,data = t10, paired = TRUE)

# NPS and rpLOC
t11 <- Org[(Org$brain == 'NPS' | Org$brain == 'rpLOC'),]
test11<-t.test(icc~brain,data = t11, paired = TRUE)

# NPS and lLOC
t12 <- Org[(Org$brain == 'NPS' | Org$brain == 'lLOC'),]
test12<-t.test(icc~brain,data = t12, paired = TRUE)

# NPS and rIPL
t13 <- Org[(Org$brain == 'NPS' | Org$brain == 'rIPL'),]
test13<-t.test(icc~brain,data = t13, paired = TRUE)

# NPS and rLOC
t14 <- Org[(Org$brain == 'NPS' | Org$brain == 'rLOC'),]
test14<-t.test(icc~brain,data = t14, paired = TRUE)

# NPS and pgACC
t15 <- Org[(Org$brain == 'NPS' | Org$brain == 'pgACC'),]
test15<-t.test(icc~brain,data = t15, paired = TRUE)

t_value <- c(test1$statistic,test2$statistic,test3$statistic,test4$statistic,test5$statistic,test6$statistic,test7$statistic,test8$statistic,test9$statistic,test10$statistic,test11$statistic,test12$statistic,test13$statistic,test14$statistic,test15$statistic)
p_value <- c(test1$p.value,test2$p.value,test3$p.value,test4$p.value,test5$p.value,test6$p.value,test7$p.value,test8$p.value,test9$p.value,test10$p.value,test11$p.value,test12$p.value,test13$p.value,test14$p.value,test15$p.value)

p.adjust(p_value,'fdr')



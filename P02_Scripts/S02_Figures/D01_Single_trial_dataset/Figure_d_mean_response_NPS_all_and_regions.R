library(readxl)
library(ggplot2)
library(plotrix)

file = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior/NPS_local_mean_response_effect_size.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
pain <- rgb(60/255,60/255,60/255)
nps <- rgb(204/255,48/255,115/255)
npspos <- rgb(212/255,147/255,183/255)
npsneg <- rgb(147/255,149/255,152/255)

# Orgnized data format
Org <- data.frame(matrix(nrow = 144))
Org$brain<-rep(c("NPS","vermis","rIns","rV1","rThal","lIns","rdpIns","rS2","dACC","rLOC","lLOC","rpLOC","pgACC","lSTS","rIPL","PCC"),each = 9)
Org$d <- c(my_data$nps,my_data$pos_vermis,my_data$pos_rIns,my_data$pos_rV1,my_data$pos_rThal,my_data$pos_lIns,my_data$pos_rdpIns,my_data$pos_rS2,my_data$pos_dACC,my_data$neg_rLOC,my_data$neg_lLOC,my_data$neg_rpLOC,my_data$neg_pgACC,my_data$neg_lSTS,my_data$neg_rIPL,my_data$neg_PCC)
Org$brain <- factor(Org$brain, level = c("NPS","rIns","rdpIns","rS2","lIns","dACC","rThal","vermis","rV1","rIPL","lLOC","rpLOC","rLOC","pgACC","PCC","lSTS"))

# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_d_mean_response_subregions.tiff",units="in",width = 12,height = 8,res = 300)
p<-ggplot(Org,aes(x=brain,y=d, colour = factor(brain)))+ geom_hline(yintercept=0,size=0.5,linetype = "dashed")+ geom_hline(yintercept=0.2,size=0.5,linetype = "dashed")+ geom_hline(yintercept=0.5,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.8,size=0.5,linetype = "dashed") + geom_hline(yintercept=1.2,size=0.5,linetype = "dashed") + geom_hline(yintercept=2,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(nps,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+scale_y_continuous(breaks = c(0,0.2,0.5,0.8,1.2,2))
dev.off()

# T-test
summary_value = data.frame(matrix(nrow = 16))
for (b in 1:16){
  summary_value$mean[b] = mean(Org$d[((b-1)*9+1):((b-1)*9+9)])
  summary_value$se[b] = sd(Org$d[((b-1)*9+1):((b-1)*9+9)])/3
}
sum_pos<-summary_value[2:9,]
sum_neg<-summary_value[10:16,]
sort_pos<-sum_pos[with(sum_pos, order(-mean)), ]
sort_neg<-sum_neg[with(sum_neg, order(-mean)), ]

# NPS and rIns
t1 <- Org[(Org$brain == 'NPS' | Org$brain == 'rIns'),]
test1<-t.test(d~brain,data = t1, paired = TRUE)

# NPS and rdpIns
t2 <- Org[(Org$brain == 'NPS' | Org$brain == 'rdpIns'),]
test2<-t.test(d~brain,data = t2, paired = TRUE)

# NPS and rS2
t3 <- Org[(Org$brain == 'NPS' | Org$brain == 'rS2'),]
test3<-t.test(d~brain,data = t3, paired = TRUE)

# NPS and lIns
t4 <- Org[(Org$brain == 'NPS' | Org$brain == 'lIns'),]
test4<-t.test(d~brain,data = t4, paired = TRUE)

# NPS and dACC
t5 <- Org[(Org$brain == 'NPS' | Org$brain == 'dACC'),]
test5<-t.test(d~brain,data = t5, paired = TRUE)

# NPS and rThal
t6 <- Org[(Org$brain == 'NPS' | Org$brain == 'rThal'),]
test6<-t.test(d~brain,data = t6, paired = TRUE)

# NPS and vermis
t7 <- Org[(Org$brain == 'NPS' | Org$brain == 'vermis'),]
test7<-t.test(d~brain,data = t7, paired = TRUE)

# NPS and rV1
t8 <- Org[(Org$brain == 'NPS' | Org$brain == 'rV1'),]
test8<-t.test(d~brain,data = t8, paired = TRUE)

# NPS and rIPL
t9 <- Org[(Org$brain == 'NPS' | Org$brain == 'rIPL'),]
test9<-t.test(d~brain,data = t9, paired = TRUE)

# NPS and lLOC
t10 <- Org[(Org$brain == 'NPS' | Org$brain == 'lLOC'),]
test10<-t.test(d~brain,data = t10, paired = TRUE)

# NPS and rpLOC
t11 <- Org[(Org$brain == 'NPS' | Org$brain == 'rpLOC'),]
test11<-t.test(d~brain,data = t11, paired = TRUE)

# NPS and rLOC
t12 <- Org[(Org$brain == 'NPS' | Org$brain == 'rLOC'),]
test12<-t.test(d~brain,data = t12, paired = TRUE)

# NPS and pgACC
t13 <- Org[(Org$brain == 'NPS' | Org$brain == 'pgACC'),]
test13<-t.test(d~brain,data = t13, paired = TRUE)

# NPS and PCC
t14 <- Org[(Org$brain == 'NPS' | Org$brain == 'PCC'),]
test14<-t.test(d~brain,data = t14, paired = TRUE)

# NPS and lSTS
t15 <- Org[(Org$brain == 'NPS' | Org$brain == 'lSTS'),]
test15<-t.test(d~brain,data = t15, paired = TRUE)

t_value <- c(test1$statistic,test2$statistic,test3$statistic,test4$statistic,test5$statistic,test6$statistic,test7$statistic,test8$statistic,test9$statistic,test10$statistic,test11$statistic,test12$statistic,test13$statistic,test14$statistic,test15$statistic)
p_value <- c(test1$p.value,test2$p.value,test3$p.value,test4$p.value,test5$p.value,test6$p.value,test7$p.value,test8$p.value,test9$p.value,test10$p.value,test11$p.value,test12$p.value,test13$p.value,test14$p.value,test15$p.value)

p.adjust(p_value,'fdr')



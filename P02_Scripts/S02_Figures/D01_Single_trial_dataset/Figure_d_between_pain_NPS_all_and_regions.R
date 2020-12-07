library(readxl)
library(ggplot2)
library(plotrix)
library(tidyr)

file = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior/NPS_local_between_pain_effect_size_exclude_nsf.csv'
my_data = read.csv(file,header=TRUE)

# Reorder data based on mean of columns and reorganize data
pos_data = my_data[1:8,3:10]
neg_data = my_data[1:8,12:18]
mean_region <- colMeans(my_data[1:8,])
order_pos <- order(mean_region[3:10],decreasing = TRUE)
order_neg <- order(mean_region[12:18],decreasing = TRUE)

order_data <- cbind(my_data[1:8,1],pos_data[1:8,order_pos],neg_data[1:8,order_neg])

Org <- order_data %>% gather(brain, d, `my_data[1:8, 1]`:neg_rIPL)
Org$brain <- factor(Org$brain, level = c('my_data[1:8, 1]',"pos_rdpIns","pos_rIns","pos_vermis","pos_rThal","pos_lIns","pos_dACC","pos_rS2","pos_rV1","neg_pgACC","neg_rLOC","neg_rpLOC","neg_lLOC","neg_lSTS","neg_PCC","neg_rIPL"))


# colors settings
pain <- rgb(60/255,60/255,60/255)
nps <- rgb(204/255,48/255,115/255)
npspos <- rgb(212/255,147/255,183/255)
npsneg <- rgb(147/255,149/255,152/255)


# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

setwd('/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/Manuscript/Figures')
tiff("NPS_d_between_pain_subregions_exclude_nsf.tiff",units="in",width = 12,height = 8,res = 300)
p<-ggplot(Org,aes(x=brain,y=d, colour = factor(brain))) + geom_hline(yintercept=0,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.2,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.5,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.8,size=0.5,linetype = "dashed") + geom_hline(yintercept=1.2,size=0.5,linetype = "dashed") + geom_hline(yintercept=2,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(nps,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+scale_y_continuous(breaks = c(0,0.2,0.5,0.8,1.2,2))
dev.off()

# T-test
summary_value = data.frame(matrix(nrow = 16))
for (b in 1:16){
  summary_value$mean[b] = mean(Org$d[((b-1)*8+1):((b-1)*8+8)])
  summary_value$se[b] = sd(Org$d[((b-1)*8+1):((b-1)*8+8)])/sqrt(8)
}
sum_pos<-summary_value[2:9,]
sum_neg<-summary_value[10:16,]
sort_pos<-sum_pos[with(sum_pos, order(-mean)), ]
sort_neg<-sum_neg[with(sum_neg, order(-mean)), ]

# NPS and rdIns
t1 <- Org[(Org$brain == 'NPS' | Org$brain == 'rdpIns'),]
test1<-t.test(d~brain,data = t1, paired = TRUE)

# NPS and rIns
t2 <- Org[(Org$brain == 'NPS' | Org$brain == 'rIns'),]
test2<-t.test(d~brain,data = t2, paired = TRUE)

# NPS and rThal
t3 <- Org[(Org$brain == 'NPS' | Org$brain == 'rThal'),]
test3<-t.test(d~brain,data = t3, paired = TRUE)

# NPS and dACC
t4 <- Org[(Org$brain == 'NPS' | Org$brain == 'dACC'),]
test4<-t.test(d~brain,data = t4, paired = TRUE)

# NPS and vermis
t5 <- Org[(Org$brain == 'NPS' | Org$brain == 'vermis'),]
test5<-t.test(d~brain,data = t5, paired = TRUE)

# NPS and rS2
t6 <- Org[(Org$brain == 'NPS' | Org$brain == 'rS2'),]
test6<-t.test(d~brain,data = t6, paired = TRUE)

# NPS and lIns
t7 <- Org[(Org$brain == 'NPS' | Org$brain == 'lIns'),]
test7<-t.test(d~brain,data = t7, paired = TRUE)

# NPS and rV1
t8 <- Org[(Org$brain == 'NPS' | Org$brain == 'rV1'),]
test8<-t.test(d~brain,data = t8, paired = TRUE)

# NPS and pgACC
t9 <- Org[(Org$brain == 'NPS' | Org$brain == 'pgACC'),]
test9<-t.test(d~brain,data = t9, paired = TRUE)

# NPS and rLOC
t10 <- Org[(Org$brain == 'NPS' | Org$brain == 'rLOC'),]
test10<-t.test(d~brain,data = t10, paired = TRUE)

# NPS and rpLOC
t11 <- Org[(Org$brain == 'NPS' | Org$brain == 'rpLOC'),]
test11<-t.test(d~brain,data = t11, paired = TRUE)

# NPS and lLOC
t12 <- Org[(Org$brain == 'NPS' | Org$brain == 'lLOC'),]
test12<-t.test(d~brain,data = t12, paired = TRUE)

# NPS and lSTS
t13 <- Org[(Org$brain == 'NPS' | Org$brain == 'lSTS'),]
test13<-t.test(d~brain,data = t13, paired = TRUE)

# NPS and rIPL
t14 <- Org[(Org$brain == 'NPS' | Org$brain == 'rIPL'),]
test14<-t.test(d~brain,data = t14, paired = TRUE)

# NPS and PCC
t15 <- Org[(Org$brain == 'NPS' | Org$brain == 'PCC'),]
test15<-t.test(d~brain,data = t15, paired = TRUE)

t_value <- c(test1$statistic,test2$statistic,test3$statistic,test4$statistic,test5$statistic,test6$statistic,test7$statistic,test8$statistic,test9$statistic,test10$statistic,test11$statistic,test12$statistic,test13$statistic,test14$statistic,test15$statistic)
p_value <- c(test1$p.value,test2$p.value,test3$p.value,test4$p.value,test5$p.value,test6$p.value,test7$p.value,test8$p.value,test9$p.value,test10$p.value,test11$p.value,test12$p.value,test13$p.value,test14$p.value,test15$p.value)

p.adjust(p_value,'fdr')


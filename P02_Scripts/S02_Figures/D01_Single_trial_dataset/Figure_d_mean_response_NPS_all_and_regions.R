library(readxl)
library(ggplot2)
library(plotrix)
library(tidyr)

file = '/Users/spring/Dropbox (Dartmouth College)/NPS_Reliability/D01_Single_trial_dataset/behavior/NPS_local_mean_response_effect_size_exclude_nsf.csv'
my_data = read.csv(file,header=TRUE)

# Reorder data based on mean of columns and reorganize data
pos_data = my_data[,3:10]
neg_data = my_data[,12:18]
mean_region <- colMeans(my_data)
order_pos <- order(mean_region[3:10],decreasing = TRUE)
order_neg <- order(mean_region[12:18],decreasing = TRUE)

order_data <- cbind(my_data[,1],pos_data[,order_pos],neg_data[,order_neg])

Org <- order_data %>% gather(brain, d, `my_data[, 1]`:neg_lSTS)
Org$brain <- factor(Org$brain, level = c('my_data[, 1]',"pos_rIns","pos_rdpIns","pos_rS2","pos_lIns","pos_dACC","pos_rThal","pos_vermis","pos_rV1","neg_rIPL","neg_pgACC","neg_PCC","neg_lLOC","neg_rpLOC","neg_rLOC","neg_lSTS"))


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
tiff("NPS_d_mean_response_subregions_exclude_nsf.tiff",units="in",width = 12,height = 8,res = 300)
p<-ggplot(Org,aes(x=brain,y=d, colour = factor(brain)))+ geom_hline(yintercept=0,size=0.5,linetype = "dashed")+ geom_hline(yintercept=0.2,size=0.5,linetype = "dashed")+ geom_hline(yintercept=0.5,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.8,size=0.5,linetype = "dashed") + geom_hline(yintercept=1.2,size=0.5,linetype = "dashed") + geom_hline(yintercept=2,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(nps,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+scale_y_continuous(breaks = c(0,0.2,0.5,0.8,1.2,2))
dev.off()

# T-test
summary_value = data.frame(matrix(nrow = 16))
for (b in 1:16){
  summary_value$mean[b] = mean(Org$d[((b-1)*8+1):((b-1)*8+8)])
  summary_value$se[b] = sd(Org$d[((b-1)*8+1):((b-1)*8+8)])/sqrt(8)
}

Region <- data.frame(unique(Org$brain))
t_value <- data.frame()
p_value <- data.frame()
for (r in 2:length(Region$unique.Org.brain.)){
  t <- Org[(Org$brain == Region$unique.Org.brain.[1] | Org$brain == Region$unique.Org.brain.[r]),]
  test<-t.test(d~brain,data = t, paired = TRUE)
  t_value <- c(t_value, test$statistic)
  p_value <- c(p_value, test$p.value)
}

p_adjust <- data.frame(p.adjust(p_value,'fdr'))



library(readxl)
library(ggplot2)
library(plotrix)
library(tidyr)

file = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/ICC_all_and_regions_exclude_nsf.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
pain <- rgb(60/255,60/255,60/255)
nps <- rgb(204/255,48/255,115/255)
npspos <- rgb(212/255,147/255,183/255)
npsneg <- rgb(147/255,149/255,152/255)

# Reorder data based on mean of columns and reorganize data
pos_data = my_data[,4:11]
neg_data = my_data[,13:19]
mean_region <- colMeans(my_data)
order_pos <- order(mean_region[4:11],decreasing = TRUE)
order_neg <- order(mean_region[13:19],decreasing = TRUE)

order_data <- cbind(my_data[,c(2,1)],pos_data[,order_pos],neg_data[,order_neg])

Org <- order_data %>% gather(brain, icc, rating:pgACC)
Org$brain <- factor(Org$brain, level = c("rating","NPS","rS2","rIns","rV1","rdpIns","dACC","lIns","rThal","vermis","lSTS","PCC","lLOC","rpLOC","rIPL","rLOC","pgACC"))

# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
png("NPS_ICC_subregions_exclude_nsf.png",units="in",width = 12,height = 8,res = 300)
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

summary_value = data.frame(matrix(nrow = 17))
for (b in 1:17){
  summary_value$mean[b] = mean(Org$icc[((b-1)*8+1):((b-1)*8+8)])
  summary_value$se[b] = sd(Org$icc[((b-1)*8+1):((b-1)*8+8)])/sqrt(8)
}

Region <- data.frame(unique(Org$brain))
t_value <- data.frame()
p_value <- data.frame()
for (r in 3:length(Region$unique.Org.brain.)){
  t <- Org[(Org$brain == Region$unique.Org.brain.[2] | Org$brain == Region$unique.Org.brain.[r]),]
  test<-t.test(icc~brain,data = t, paired = TRUE)
  t_value <- c(t_value, test$statistic)
  p_value <- c(p_value, test$p.value)
}

p_adjust <- data.frame(p.adjust(p_value,'fdr'))

t_rating <- Org[(Org$brain == Region$unique.Org.brain.[2] | Org$brain == Region$unique.Org.brain.[1]),]
test_rating<-t.test(icc~brain,data = t_rating, paired = TRUE)


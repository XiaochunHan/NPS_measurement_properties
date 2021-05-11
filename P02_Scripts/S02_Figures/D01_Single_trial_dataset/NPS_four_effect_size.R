library(readxl)
library(ggplot2)
library(plotrix)

file = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/Four_effect_size_exclude_nsf.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
nps.mean <- rgb(191/255,196/255,158/255)
nps.inTemp <- rgb(200/255,135/255,115/255)
npspos.inPain <- rgb(209/255,150/255,64/255)
npsneg.betPain <- rgb(119/255,159/255,209/255)

# Orgnized data format
Org <- data.frame(matrix(nrow = 32))
Org$brain<-rep(c("Mean","inTemp","inPain","betPain"),each = 8)
Org$es <- c(my_data$mean_response,my_data$withinSub_corr_temp,my_data$withinSub_corr_pain,my_data$betweenSub_corr_pain)
Org$brain <- factor(Org$brain, level = c("Mean","inTemp","inPain","betPain"))

# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
png("NPS_four_effect_size_exclude_nsf.png",units="in",width = 9,height = 8,res = 300)
p<-ggplot(Org,aes(x=brain,y=es, colour = factor(brain))) + geom_hline(yintercept=0,size=0.5,linetype = "dashed")+ geom_hline(yintercept=0.2,size=0.5,linetype = "dashed")+ geom_hline(yintercept=0.5,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.8,size=0.5,linetype = "dashed") + geom_hline(yintercept=1.2,size=0.5,linetype = "dashed")+ geom_hline(yintercept=2.0,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(nps.mean,nps.inTemp,npspos.inPain,npsneg.betPain)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1.5) + geom_point(alpha = 0.9, size = 2.5, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+scale_y_continuous(breaks = c(0,0.2,0.5,0.8,1.2,2))
dev.off()

# data_summary
mean_response <- data_summary(my_data[,1])
within_r_temp <- data_summary(my_data[,2])
within_r_pain <- data_summary(my_data[,3])
between_r_pain <- data_summary(my_data[,4])


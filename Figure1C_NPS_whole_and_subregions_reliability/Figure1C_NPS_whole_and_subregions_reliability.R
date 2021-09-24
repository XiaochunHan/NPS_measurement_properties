library(readxl)
library(ggplot2)
library(plotrix)
library(tidyr)

#setwd('./Figure1C_NPS_whole_and_subregions_reliability')
file = './ICC_all_and_regions.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
pain <- rgb(60/255,60/255,60/255)
nps <- rgb(204/255,48/255,115/255)
npspos <- rgb(212/255,147/255,183/255)
npsneg <- rgb(147/255,149/255,152/255)

# Reorder data based on mean of columns and reorganize data
pos_data = my_data[,3:10]
neg_data = my_data[,11:17]
mean_region <- colMeans(my_data)
order_pos <- order(mean_region[3:10],decreasing = TRUE)
order_neg <- order(mean_region[11:17],decreasing = TRUE)

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

p<-ggplot(Org,aes(x=brain,y=icc, colour = factor(brain))) + geom_hline(yintercept=0.4,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.6,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.75,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(pain,nps,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+coord_cartesian(ylim=c(0,1))+scale_y_continuous(breaks = c(0,0.4,0.6,0.75,1))

# Mean values of ICC
summary_value = data.frame(matrix(nrow = 17))
for (b in 1:17){
  summary_value$mean[b] = mean(Org$icc[((b-1)*8+1):((b-1)*8+8)])
}


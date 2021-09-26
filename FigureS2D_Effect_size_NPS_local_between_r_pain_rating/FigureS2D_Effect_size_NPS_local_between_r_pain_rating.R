library(readxl)
library(ggplot2)
library(plotrix)
library(tidyr)

# setwd('./FigureS2D_Effect_size_NPS_local_between_r_pain_rating')
file = 'NPS_local_between_pain_effect_size.csv'
my_data = read.csv(file,header=TRUE)

# Reorder data based on mean of columns and reorganize data
nps = my_data[,1]
pos_data = my_data[,2:9]
neg_data = my_data[,10:16]
mean_region <- colMeans(my_data)
order_pos <- order(mean_region[2:9],decreasing = TRUE)
order_neg <- order(mean_region[10:16],decreasing = TRUE)

order_data <- cbind(nps,pos_data[,order_pos],neg_data[,order_neg])

Org <- order_data %>% gather(brain, d, nps:neg_rIPL)
Org$brain <- factor(Org$brain, level = c("nps","pos_rdpIns","pos_rIns","pos_vermis","pos_rThal","pos_lIns","pos_dACC","pos_rS2","pos_rV1","neg_pgACC","neg_rLOC","neg_rpLOC","neg_lLOC","neg_lSTS","neg_PCC","neg_rIPL"))


# colors settings
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

p<-ggplot(Org,aes(x=brain,y=d, colour = factor(brain))) + geom_hline(yintercept=0,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.2,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.5,size=0.5,linetype = "dashed") + geom_hline(yintercept=0.8,size=0.5,linetype = "dashed") + geom_hline(yintercept=1.2,size=0.5,linetype = "dashed") + geom_hline(yintercept=2,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = c(nps,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npspos,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg,npsneg)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 1) + geom_point(alpha = 0.8, size = 2, position=position_jitterdodge(jitter.width = 1,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))+scale_y_continuous(breaks = c(0,0.2,0.5,0.8,1.2,2))

# Summary of mean values
summary_value = data.frame(matrix(nrow = 16))
for (b in 1:16){
  summary_value$mean[b] = mean(Org$d[((b-1)*8+1):((b-1)*8+8)])
}
print(summary_value$mean)


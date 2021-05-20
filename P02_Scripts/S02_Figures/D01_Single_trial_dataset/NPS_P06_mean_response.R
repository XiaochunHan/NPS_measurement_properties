library(readxl)
library(ggplot2)
library(plotrix)

file = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/NPS_mean_response_exclude_nsf_bmrk5pain_93.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
#col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E31A1C", "#E5D8BD")
#col=c("#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E")
col=c("#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E", "#BFC49E")

# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("NPS_mean_response_exclude_nsf_bmrk5pain_93.tiff",units="in",width = 8,height = 5,res = 300)
p<-ggplot(my_data,aes(x=study,y=rescale_mean, colour = rgb(191/255,196/255,158/255))) + geom_hline(yintercept=0,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = col) + geom_violin(scale = "width", width = 0.6, position=position_dodge(0.7)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 0.6) + geom_point(alpha = 0.4, size = 1, position=position_jitterdodge(jitter.width = 0.6,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))
dev.off()

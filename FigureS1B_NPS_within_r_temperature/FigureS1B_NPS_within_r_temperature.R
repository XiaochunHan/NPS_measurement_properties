library(readxl)
library(ggplot2)
library(plotrix)

#setwd('./FigureS1B_NPS_within_r_temperature')
file = 'NPS_within_r_temp.csv'
my_data = read.csv(file,header=TRUE)

# colors settings
col=c("#C88773")

# Generating figure
data_summary <- function(x) {
  mu <- mean(x, na.rm=TRUE)
  sigma1 <- mu-std.error(x, na.rm=TRUE)
  sigma2 <- mu+std.error(x, na.rm=TRUE)
  return(c(y=mu,ymin=sigma1,ymax=sigma2))
}

p<-ggplot(my_data,aes(x=study,y=within_r_temp, colour = col)) + geom_hline(yintercept=0,size=0.5,linetype = "dashed")
p + scale_colour_manual(values = col) + geom_violin(scale = "width", width = 0.6, position=position_dodge(0.7)) + stat_summary(fun.data = data_summary,position=position_dodge(0.7),size = 0.6) + geom_point(alpha = 0.4, size = 1, position=position_jitterdodge(jitter.width = 0.6,dodge.width = 0.7)) + theme(panel.background = element_rect(fill = "transparent"), axis.line = element_line(size = 0.5, colour = "black"), axis.ticks = element_line(size = 0.5, colour = "black"))

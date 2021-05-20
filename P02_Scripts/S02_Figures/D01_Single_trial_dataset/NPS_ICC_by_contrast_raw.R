library(RColorBrewer)
library(scales)
# select 9 colors
n <- 9
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E31A1C", "#E5D8BD")
#pie(rep(1,n), col=sample(col_vector, n))

#
file_single = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/NPS_ICC_single.csv'
Data_single = read.csv(file_single,header=TRUE)
file_contrast = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/NPS_ICC_contrast.csv'
Data_contrast = read.csv(file_contrast,header=TRUE)
Data_contrast[Data_contrast<0] = 0

setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("NPS_ICC_by_contrast_exclude_nsf.tiff",units="in",width = 10,height = 12,res = 300)

x = Data_single$temp
# bmrk3 ICC
x.bmrk3 = x[Data_single$bmrk3pain!=0]
y.bmrk3_single = Data_single$bmrk3pain[Data_single$bmrk3pain!=0]
y.bmrk3_contrast = Data_contrast$bmrk3pain[Data_single$bmrk3pain!=0]
data_single <- data.frame(x.bmrk3, y.bmrk3_single)
data_contrast <- data.frame(x.bmrk3, y.bmrk3_contrast)
plot(data_single, frame.plot=FALSE, xlab="temperature", ylab="ICC", col=alpha(col[1],0.4), lwd=1.5, xlim = c(46,50), ylim=c(0,1), pch = 19, cex = 4, yaxt='n')
axis(side = 2, at=c(-1,0,0.4,0.6,0.75,1))
points(data_contrast, col=alpha(col[1],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x.bmrk3[1],x.bmrk3[1]), c(y.bmrk3_single[1],y.bmrk3_contrast[1]), col=alpha(col[1],1), lwd=2,lty = 2)
lines(c(x.bmrk3[2],x.bmrk3[2]), c(y.bmrk3_single[2],y.bmrk3_contrast[2]), col=alpha(col[1],1), lwd=2,lty = 2)
lines(c(x.bmrk3[3],x.bmrk3[3]), c(y.bmrk3_single[3],y.bmrk3_contrast[3]), col=alpha(col[1],1), lwd=2,lty = 2)
#text(locator(), labels = "1")
#text(locator(), labels = "1")
#text(locator(), labels = "1")

# bmrk4 ICC
x.bmrk4 = x[Data_single$bmrk4!=0]
y.bmrk4_single = Data_single$bmrk4[Data_single$bmrk4!=0]
y.bmrk4_contrast = Data_contrast$bmrk4[Data_single$bmrk4!=0]
data_single <- data.frame(x.bmrk4-0.1, y.bmrk4_single)
data_contrast <- data.frame(x.bmrk4-0.1, y.bmrk4_contrast)
points(data_single, col=alpha(col[2],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[2],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x.bmrk4[1]-0.1,x.bmrk4[1]-0.1), c(y.bmrk4_single[1],y.bmrk4_contrast[1]), col=alpha(col[2],1), lwd=2,lty = 2)
lines(c(x.bmrk4[2]-0.1,x.bmrk4[2]-0.1), c(y.bmrk4_single[2],y.bmrk4_contrast[2]), col=alpha(col[2],1), lwd=2,lty = 2)
#text(locator(), labels = "2")
#text(locator(), labels = "2")

# bmrk5 ICC
x.bmrk5 = x[Data_single$bmrk5pain_xc!=0]
y.bmrk5_single = Data_single$bmrk5pain_xc[Data_single$bmrk5pain_xc!=0]
y.bmrk5_contrast = Data_contrast$bmrk5pain_xc[Data_single$bmrk5pain_xc!=0]
data_single <- data.frame(x.bmrk5+0.1, y.bmrk5_single)
data_contrast <- data.frame(x.bmrk5+0.1, y.bmrk5_contrast)
points(data_single, col=alpha(col[3],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[3],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x.bmrk5[1]+0.1,x.bmrk5[1]+0.1), c(y.bmrk5_single[1],y.bmrk5_contrast[1]), col=alpha(col[3],1), lwd=2,lty = 2)
lines(c(x.bmrk5[2]+0.1,x.bmrk5[2]+0.1), c(y.bmrk5_single[2],y.bmrk5_contrast[2]), col=alpha(col[3],1), lwd=2,lty = 2)
#text(locator(), labels = "3")
#text(locator(), labels = "3")

# ie ICC
x.ie = x[Data_single$ie!=0]
y.ie_single = Data_single$ie[Data_single$ie!=0]
y.ie_contrast = Data_contrast$ie[Data_single$ie!=0]
data_single <- data.frame(x.ie, y.ie_single)
data_contrast <- data.frame(x.ie, y.ie_contrast)
points(data_single, col=alpha(col[5],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[5],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x.ie[1],x.ie[1]), c(y.ie_single[1],y.ie_contrast[1]), col=alpha(col[5],1), lwd=2,lty = 2)
lines(c(x.ie[2],x.ie[2]), c(y.ie_single[2],y.ie_contrast[2]), col=alpha(col[5],1), lwd=2,lty = 2)
#text(locator(), labels = "5")
#text(locator(), labels = "5")

# ie2 ICC
x.ie2 = x[Data_single$ie2!=0]
y.ie2_single = Data_single$ie2[Data_single$ie2!=0]
y.ie2_contrast = Data_contrast$ie2[Data_single$ie2!=0]
data_single <- data.frame(x.ie2, y.ie2_single)
data_contrast <- data.frame(x.ie2, y.ie2_contrast)
points(data_single, col=alpha(col[6],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[6],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x.ie2[1],x.ie2[1]), c(y.ie2_single[1],y.ie2_contrast[1]), col=alpha(col[6],1), lwd=2,lty = 2)
#text(locator(), labels = "6")

# scebl ICC
x.scebl = x[Data_single$scebl!=0]
y.scebl_single = Data_single$scebl[Data_single$scebl!=0]
y.scebl_contrast = Data_contrast$scebl[Data_single$scebl!=0]
data_single <- data.frame(x.scebl-0.1, y.scebl_single)
data_contrast <- data.frame(x.scebl-0.1, y.scebl_contrast)
points(data_single, col=alpha(col[9],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[9],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x.scebl[1]-0.1,x.scebl[1]-0.1), c(y.scebl_single[1],y.scebl_contrast[1]), col=alpha(col[9],1), lwd=2,lty = 2)
lines(c(x.scebl[2]-0.1,x.scebl[2]-0.1), c(y.scebl_single[2],y.scebl_contrast[2]), col=alpha(col[9],1), lwd=2,lty = 2)
#text(locator(), labels = "9")
#text(locator(), labels = "9")

# add legend
#legend(x=49.2,y=0.3,c("1-bmrk3pain","2-bmrk4","3-bmrk5pain","5-ie","6-ie2","9-scebl"),bty = "n")

dev.off()

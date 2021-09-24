library(RColorBrewer)
library(scales)
#setwd('./Figure2C_Reliability_and contrast_type')
# select 8 colors
col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E5D8BD")

#
file_baseline = 'rating_ICC_baseline.csv'
Data_baseline = read.csv(file_baseline,header=TRUE)
file_contrast = 'rating_ICC_contrast.csv'
Data_contrast = read.csv(file_contrast,header=TRUE)
Data_contrast[Data_contrast<0] = 0

x = Data_baseline$temp
# Study1 ICC
x1 = x[Data_baseline$Study1!=0]
y1_baseline = Data_baseline$Study1[Data_baseline$Study1!=0]
y1_contrast = Data_contrast$Study1[Data_baseline$Study1!=0]
data_single <- data.frame(x1, y1_baseline)
data_contrast <- data.frame(x1, y1_contrast)
plot(data_single, frame.plot=FALSE, xlab="temperature", ylab="ICC", col=alpha(col[1],0.4), lwd=1.5, xlim = c(46,50), ylim=c(0,1), pch = 19, cex = 4, yaxt='n')
axis(side = 2, at=c(-1,0,0.4,0.6,0.75,1))
points(data_contrast, col=alpha(col[1],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x1[1],x1[1]), c(y1_baseline[1],y1_contrast[1]), col=alpha(col[1],1), lwd=2,lty = 2)
lines(c(x1[2],x1[2]), c(y1_baseline[2],y1_contrast[2]), col=alpha(col[1],1), lwd=2,lty = 2)
lines(c(x1[3],x1[3]), c(y1_baseline[3],y1_contrast[3]), col=alpha(col[1],1), lwd=2,lty = 2)

# Study2 ICC
x2 = x[Data_baseline$Study2!=0]
y2_baseline = Data_baseline$Study2[Data_baseline$Study2!=0]
y2_contrast = Data_contrast$Study2[Data_baseline$Study2!=0]
data_single <- data.frame(x2-0.1, y2_baseline)
data_contrast <- data.frame(x2-0.1, y2_contrast)
points(data_single, col=alpha(col[2],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[2],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x2[1]-0.1,x2[1]-0.1), c(y2_baseline[1],y2_contrast[1]), col=alpha(col[2],1), lwd=2,lty = 2)
lines(c(x2[2]-0.1,x2[2]-0.1), c(y2_baseline[2],y2_contrast[2]), col=alpha(col[2],1), lwd=2,lty = 2)

# Study3 ICC
x3 = x[Data_baseline$Study3!=0]
y3_baseline = Data_baseline$Study3[Data_baseline$Study3!=0]
y3_contrast = Data_contrast$Study3[Data_baseline$Study3!=0]
data_single <- data.frame(x3+0.1, y3_baseline)
data_contrast <- data.frame(x3+0.1, y3_contrast)
points(data_single, col=alpha(col[3],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[3],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x3[1]+0.1,x3[1]+0.1), c(y3_baseline[1],y3_contrast[1]), col=alpha(col[3],1), lwd=2,lty = 2)
lines(c(x3[2]+0.1,x3[2]+0.1), c(y3_baseline[2],y3_contrast[2]), col=alpha(col[3],1), lwd=2,lty = 2)

# Study5 ICC
x5 = x[Data_baseline$Study5!=0]
y5_baseline = Data_baseline$Study5[Data_baseline$Study5!=0]
y5_contrast = Data_contrast$Study5[Data_baseline$Study5!=0]
data_single <- data.frame(x5, y5_baseline)
data_contrast <- data.frame(x5, y5_contrast)
points(data_single, col=alpha(col[5],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[5],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x5[1],x5[1]), c(y5_baseline[1],y5_contrast[1]), col=alpha(col[5],1), lwd=2,lty = 2)
lines(c(x5[2],x5[2]), c(y5_baseline[2],y5_contrast[2]), col=alpha(col[5],1), lwd=2,lty = 2)

# Study6 ICC
x6 = x[Data_baseline$Study6!=0]
y6_baseline = Data_baseline$Study6[Data_baseline$Study6!=0]
y6_contrast = Data_contrast$Study6[Data_baseline$Study6!=0]
data_single <- data.frame(x6, y6_baseline)
data_contrast <- data.frame(x6, y6_contrast)
points(data_single, col=alpha(col[6],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[6],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x6[1],x6[1]), c(y6_baseline[1],y6_contrast[1]), col=alpha(col[6],1), lwd=2,lty = 2)

# Study8 ICC
x8 = x[Data_baseline$Study8!=0]
y8_baseline = Data_baseline$Study8[Data_baseline$Study8!=0]
y8_contrast = Data_contrast$Study8[Data_baseline$Study8!=0]
data_single <- data.frame(x8-0.1, y8_baseline)
data_contrast <- data.frame(x8-0.1, y8_contrast)
points(data_single, col=alpha(col[8],0.6), lwd=1.5, pch = 19,cex=4)
points(data_contrast, col=alpha(col[8],0.6), lwd=1.5, pch = 19,cex=2)
lines(c(x8[1]-0.1,x8[1]-0.1), c(y8_baseline[1],y8_contrast[1]), col=alpha(col[8],1), lwd=2,lty = 2)
lines(c(x8[2]-0.1,x8[2]-0.1), c(y8_baseline[2],y8_contrast[2]), col=alpha(col[8],1), lwd=2,lty = 2)


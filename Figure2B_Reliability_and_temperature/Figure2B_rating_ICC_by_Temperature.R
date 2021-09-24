library(RColorBrewer)
library(scales)
#setwd('./Figure2B_Reliability_and_temperature')
# select 8 colors
col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E5D8BD")

file = 'rating_ICC_by_temperature.csv'
Data = read.csv(file,header=TRUE)

x = Data$temp

# Study1 ICC
x1 = x[Data$Study1!=0]
y1 = Data$Study1[Data$Study1!=0]
data <- data.frame(x1, y1)
plot(data, frame.plot=FALSE, xlab="temperature", ylab="ICC", col=alpha(col[1],0.6), lwd=1.5, xlim = c(45,50), ylim=c(0.4,1), pch = 19, cex = 3, yaxt='n')
axis(side = 2, at=c(0.4,0.6,0.75,1))
lines(x1, y1, col=alpha(col[1],1), lwd=3)

# Study2 ICC
x2 = x[Data$Study2!=0]
y2 = Data$Study2[Data$Study2!=0]
data <- data.frame(x2, y2)
points(data, col=alpha(col[2],0.6), lwd=1.5, pch = 19,cex=3)
lines(x2, y2, col=alpha(col[2],1), lwd=3)

# Study3 ICC
x3 = x[Data$Study3!=0]
y3 = Data$Study3[Data$Study3!=0]
data <- data.frame(x3, y3)
points(data, col=alpha(col[3],0.6), lwd=1.5, pch = 19,cex=3)
lines(x3, y3, col=alpha(col[3],1), lwd=3)

# Study5 ICC
x5 = x[Data$Study5!=0]
y5 = Data$Study5[Data$Study5!=0]
data <- data.frame(x5, y5)
points(data, col=alpha(col[5],0.6), lwd=1.5, pch = 19,cex=3)
lines(x5, y5, col=alpha(col[5],1), lwd=3)

# Study6 ICC
x6 = x[Data$Study6!=0]
y6 = Data$Study6[Data$Study6!=0]
data <- data.frame(x6, y6)
points(data, col=alpha(col[6],0.6), lwd=1.5, pch = 19,cex=3)
lines(x6, y6, col=alpha(col[6],1), lwd=3)

# Study8 ICC
x8 = x[Data$Study8!=0]
y8 = Data$Study8[Data$Study8!=0]
data <- data.frame(x8, y8)
points(data, col=alpha(col[8],0.6), lwd=1.5, pch = 19,cex=3)
lines(x8, y8, col=alpha(col[8],1), lwd=3)


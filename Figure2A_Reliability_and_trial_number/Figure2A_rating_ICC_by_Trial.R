library(RColorBrewer)
library(scales)
#setwd('./Figure2A_Reliability_and_trial_number')
# select 8 colors
col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E5D8BD")

file = 'rating_ICC_by_Trial.csv'
Data = read.csv(file,header=TRUE)

x = 1:48
# Study1 ICC
y1 = Data$Study1[1:28]
data <- data.frame(x[1:28], y1)
plx1<-predict(loess(y1 ~ x[1:28], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
plot(data, type = "n", frame.plot=FALSE, xlab="Observation Number", ylab="ICC", col=alpha(col[1],0.4), lwd=1.5, xlim = c(1,40), ylim=c(0,1), pch = 1, yaxt='n')
axis(side = 2, at=c(0,0.4,0.6,0.75,1))
lines(x[1:28],plx1$fit, col=alpha(col[1],1), lwd=3)

# Study2 ICC
y2 = Data$Study2[1:39]
data <- data.frame(x[1:39], y2)
plx2<-predict(loess(y2 ~ x[1:39], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[1:39],plx2$fit, col=alpha(col[2],1), lwd=3)

# Study3 ICC
y3 = Data$Study3[1:18]
data <- data.frame(x[1:18], y3)
plx3<-predict(loess(y3 ~ x[1:18], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[1:18],plx3$fit, col=alpha(col[3],1), lwd=3)

# Study4 ICC
y4 = Data$Study4[1:31]
data <- data.frame(x[1:31], y4)
plx4<-predict(loess(y4 ~ x[1:31], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[1:31],plx4$fit, col=alpha(col[4],1), lwd=3)

# Study5 ICC
y5 = Data$Study5[1:24]
data <- data.frame(x[1:24], y5)
plx5<-predict(loess(y5 ~ x[1:24], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[1:24],plx5$fit, col=alpha(col[5],1), lwd=3)

# Study6 ICC
y6 = Data$Study6[1:35]
data <- data.frame(x[1:35], y6)
plx6<-predict(loess(y6 ~ x[1:35], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[1:35],plx6$fit, col=alpha(col[6],1), lwd=3)

# Study7 ICC
y7 = Data$Study7[1:32]
data <- data.frame(x[1:32], y7)
plx7<-predict(loess(y7 ~ x[1:32], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[1:32],plx7$fit, col=alpha(col[7],1), lwd=3)

# Study8 ICC
y8 = Data$Study8[2:48]
data <- data.frame(x[2:48], y8)
plx8<-predict(loess(y8 ~ x[2:48], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
lines(x[2:48],plx8$fit, col=alpha(col[8],1), lwd=3)

# mean and se ICC
y.mean = Data$mean[1:40]
y.se = Data$se[1:40]
data <- data.frame(x[1:40], y.mean)
plx.mean<-predict(loess(y.mean ~ x[1:40], span=3/3, degree=1, family="symmetric", iterations=4), se=T)
plx.se<-predict(loess(y.se ~ x[1:40], span=3/3, degree=1, family="symmetric", iterations=4), se=T)
polygon(c(x[1:40], rev(x[1:40])), c(plx.mean$fit + plx.se$fit, rev(plx.mean$fit - plx.se$fit)), col=alpha("#99999977",0.2))
lines(x[1:40], plx.mean$fit, col="black", lwd=5)
abline(h = 0.75, col = "black",lty = 2, lwd = 3)

# dot of RTNF
points(x=15, y = 0.88, col = "#BF7FBA", pch = 16,cex=5)

# dot of OLP4CBP
points(x=2.5, y = 0.26, col = "#96AFCC", pch = 16,cex=5)



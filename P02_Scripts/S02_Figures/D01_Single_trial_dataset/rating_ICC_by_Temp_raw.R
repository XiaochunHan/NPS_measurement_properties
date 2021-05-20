library(RColorBrewer)
library(scales)
# select 9 colors
n <- 9
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E31A1C", "#E5D8BD")
#pie(rep(1,n), col=sample(col_vector, n))

#
file = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/rating_ICC_temp.csv'
Data = read.csv(file,header=TRUE)

setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("Rating_ICC_by_temp_exclude_nsf.tiff",units="in",width = 10,height = 12,res = 300)
x = Data$temp
# bmrk3 ICC
x.bmrk3 = x[Data$bmrk3pain!=0]
y.bmrk3 = Data$bmrk3pain[Data$bmrk3pain!=0]
data <- data.frame(x.bmrk3, y.bmrk3)
#plx.bmrk3<-predict(loess(y.bmrk3 ~ x.bmrk3, span=1, degree=1, family="symmetric", iterations=4), se=T)
plx.bmrk3 <- lowess(y.bmrk3 ~ x.bmrk3, f=1)
plot(data, frame.plot=FALSE, xlab="temperature", ylab="ICC", col=alpha(col[1],0.6), lwd=1.5, xlim = c(45,50), ylim=c(0.4,1), pch = 19, cex = 3, yaxt='n')
axis(side = 2, at=c(0.4,0.6,0.75,1))
#lines(x.bmrk3, plx.bmrk3$y, col=alpha(col[1],0.3), lwd=3)
lines(x.bmrk3, y.bmrk3, col=alpha(col[1],1), lwd=3)
#text(locator(), labels = "1")

# bmrk4 ICC
x.bmrk4 = x[Data$bmrk4!=0]
y.bmrk4 = Data$bmrk4[Data$bmrk4!=0]
data <- data.frame(x.bmrk4, y.bmrk4)
#plx.bmrk4<-predict(loess(y.bmrk4 ~ x.bmrk4, span=1, degree=1, family="symmetric", iterations=4), se=T)
plx.bmrk4 <- lowess(y.bmrk4 ~ x.bmrk4, f=1)
points(data, col=alpha(col[2],0.6), lwd=1.5, pch = 19,cex=3)
#lines(x.bmrk4, plx.bmrk4$y, col=alpha(col[2],0.3), lwd=3)
lines(x.bmrk4, y.bmrk4, col=alpha(col[2],1), lwd=3)
#text(locator(), labels = "2")

# bmrk5 ICC
x.bmrk5 = x[Data$bmrk5pain_xc!=0]
y.bmrk5 = Data$bmrk5pain_xc[Data$bmrk5pain_xc!=0]
data <- data.frame(x.bmrk5, y.bmrk5)
plx.bmrk5 <- lowess(y.bmrk5 ~ x.bmrk5, f=1)
#plx.bmrk5<-predict(loess(y.bmrk5 ~ x[1:18], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
points(data, col=alpha(col[3],0.6), lwd=1.5, pch = 19,cex=3)
#lines(x.bmrk5,plx.bmrk5$y, col=alpha(col[3],0.3), lwd=3)
lines(x.bmrk5, y.bmrk5, col=alpha(col[3],1), lwd=3)
#text(locator(), labels = "3")

# ie ICC
x.ie = x[Data$ie!=0]
y.ie = Data$ie[Data$ie!=0]
data <- data.frame(x.ie, y.ie)
plx.ie <- lowess(y.ie ~ x.ie, f=1)
#plx.ie<-predict(loess(y.ie ~ x[1:24], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
points(data, col=alpha(col[5],0.6), lwd=1.5, pch = 19,cex=3)
#lines(x.ie, plx.ie$y, col=alpha(col[5],0.3), lwd=3)
lines(x.ie, y.ie, col=alpha(col[5],1), lwd=3)
#text(locator(), labels = "5")

# ie2 ICC
x.ie2 = x[Data$ie2!=0]
y.ie2 = Data$ie2[Data$ie2!=0]
data <- data.frame(x.ie2, y.ie2)
plx.ie2 <- lowess(y.ie2 ~ x.ie2, f=1)
#plx.ie2<-predict(loess(y.ie2 ~ x[1:35], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
points(data, col=alpha(col[6],0.6), lwd=1.5, pch = 19,cex=3)
#lines(x.ie2, plx.ie2$y, col=alpha(col[6],0.3), lwd=3)
lines(x.ie2, y.ie2, col=alpha(col[6],1), lwd=3)
#text(locator(), labels = "6")

# scebl ICC
x.scebl = x[Data$scebl!=0]
y.scebl = Data$scebl[Data$scebl!=0]
data <- data.frame(x.scebl, y.scebl)
plx.scebl <- lowess(y.scebl ~ x.scebl, f=1)
#plx.scebl<-predict(loess(y.scebl ~ x[2:48], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
points(data, col=alpha(col[9],0.6), lwd=1.5, pch = 19,cex=3)
#lines(x.scebl, plx.scebl$y, col=alpha(col[9],0.3), lwd=3)
lines(x.scebl, y.scebl, col=alpha(col[9],1), lwd=3)
#text(locator(), labels = "9")

# add legend
#legend(x=49,y=0.6,c("1-bmrk3pain","2-bmrk4","3-bmrk5pain","5-ie","6-ie2","9-scebl"),bty = "n")
dev.off()


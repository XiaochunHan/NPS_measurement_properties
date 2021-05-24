library(RColorBrewer)
library(scales)
# select 9 colors
n <- 8
#qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
#col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
#col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E31A1C", "#E5D8BD")
col=c("#6A3D9A", "#8DA0CB", "#BEAED4", "#B3DE69", "#BC80BD", "#FDBF6F", "#B15928", "#E5D8BD")
#pie(rep(1,n), col=sample(col_vector, n))

#
file = '/Users/spring/Documents/Research/Reliability_NPS/P00_Raw/D01_Single_trial_dataset/NPS_ICC_exclude_nsf.csv'
Data = read.csv(file,header=TRUE)
setwd('/Users/spring/Documents/Research/Reliability_NPS/P03_Figures')
tiff("NPS_ICC_by_trial_exclude_nsf.tiff",units="in",width = 10,height = 12,res = 300)
x = 1:48
# bmrk3 ICC
y.bmrk3 = Data$bmrk3pain[1:28]
data <- data.frame(x[1:28], y.bmrk3)
plx.bmrk3<-predict(loess(y.bmrk3 ~ x[1:28], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
plot(data, type = "n", frame.plot=FALSE, xlab="Observation Number", ylab="ICC", col=alpha(col[1],0.4), lwd=1.5, xlim = c(1,40), ylim=c(0,1), pch = 1, yaxt='n')
axis(side = 2, at=c(0,0.4,0.6,0.75,1))
lines(x[1:28],plx.bmrk3$fit, col=alpha(col[1],1), lwd=3)
#text(locator(), labels = "1")

# bmrk4 ICC
y.bmrk4 = Data$bmrk4[1:39]
data <- data.frame(x[1:39], y.bmrk4)
plx.bmrk4<-predict(loess(y.bmrk4 ~ x[1:39], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[2],0.4), lwd=1.5, pch = 2,cex=.8)
lines(x[1:39],plx.bmrk4$fit, col=alpha(col[2],1), lwd=3)
#text(locator(), labels = "2")

# bmrk5 ICC
y.bmrk5 = Data$bmrk5pain_xc[1:18]
data <- data.frame(x[1:18], y.bmrk5)
plx.bmrk5<-predict(loess(y.bmrk5 ~ x[1:18], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[3],0.4), lwd=1.5, pch = 3,cex=.8)
lines(x[1:18],plx.bmrk5$fit, col=alpha(col[3],1), lwd=3)
#text(locator(), labels = "3")

# exp ICC
y.exp = Data$exp[1:31]
data <- data.frame(x[1:31], y.exp)
plx.exp<-predict(loess(y.exp ~ x[1:31], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[4],0.4), lwd=1.5, pch = 4,cex=.8)
lines(x[1:31],plx.exp$fit, col=alpha(col[4],1), lwd=3)
#text(locator(), labels = "4")

# ie ICC
y.ie = Data$ie[1:24]
data <- data.frame(x[1:24], y.ie)
plx.ie<-predict(loess(y.ie ~ x[1:24], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[5],0.4), lwd=1.5, pch = 5,cex=.8)
lines(x[1:24],plx.ie$fit, col=alpha(col[5],1), lwd=3)
#text(locator(), labels = "5")

# ie2 ICC
y.ie2 = Data$ie2[1:35]
data <- data.frame(x[1:35], y.ie2)
plx.ie2<-predict(loess(y.ie2 ~ x[1:35], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[6],0.4), lwd=1.5, pch = 6,cex=.8)
lines(x[1:35],plx.ie2$fit, col=alpha(col[6],1), lwd=3)
#text(locator(), labels = "6")

# ilcp ICC
y.ilcp = Data$ilcp[1:32]
data <- data.frame(x[1:32], y.ilcp)
plx.ilcp<-predict(loess(y.ilcp ~ x[1:32], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[7],0.4), lwd=1.5, pch = 7,cex=.8)
lines(x[1:32],plx.ilcp$fit, col=alpha(col[7],1), lwd=3)
#text(locator(), labels = "7")

# nsf ICC
#y.nsf = Data$nsf[1:23]
#data <- data.frame(x[1:23], y.nsf)
#plx.nsf<-predict(loess(y.nsf ~ x[1:23], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[8],0.4), lwd=1.5, pch = 8,cex=.8)
#lines(x[1:23],plx.nsf$fit, col=alpha(col[8],0.6), lwd=3)
#text(locator(), labels = "8")

# scebl ICC
y.scebl = Data$scebl[2:48]
data <- data.frame(x[2:48], y.scebl)
plx.scebl<-predict(loess(y.scebl ~ x[2:48], span=2/3, degree=1, family="symmetric", iterations=4), se=T)
#points(data, col=alpha(col[9],0.4), lwd=1.5, pch = 9,cex=.8)
lines(x[2:48],plx.scebl$fit, col=alpha(col[8],1), lwd=3)
#text(locator(), labels = "9")

# mean and se ICC
y.mean = Data$mean[1:40]
y.se = Data$se[1:40]
data <- data.frame(x[1:40], y.mean)
plx.mean<-predict(loess(y.mean ~ x[1:40], span=3/3, degree=1, family="symmetric", iterations=4), se=T)
plx.se<-predict(loess(y.se ~ x[1:40], span=3/3, degree=1, family="symmetric", iterations=4), se=T)
polygon(c(x[1:40], rev(x[1:40])), c(plx.mean$fit + plx.se$fit, rev(plx.mean$fit - plx.se$fit)), col=alpha("#99999977",0.2))
lines(x[1:40], plx.mean$fit, col="black", lwd=5)
abline(h = 0.75, col = "black",lty = 2, lwd = 3)
#abline(v = 20, col = "grey",lty = 2, lwd = 1.5)
abline(v = 30, col = "black",lty = 2, lwd = 3)
#abline(h = 0.6, col = "grey",lty = 2, lwd = 1.5)
#abline(h = 0.4, col = "grey",lty = 2, lwd = 1.5)
#lines(1:48, matrix(0.75,1,48), col="black", lwd=3)
#lines(c(5,5,5,5), c(-0.5,0,0.5,1),col="black", lwd=3)

# dot of RTNF
points(x=15, y = 0.73, col = "#BF7FBA", pch = 16,cex=10)
#text(locator(), labels = "RTNF")
# dot of OLP4CBP
points(x=2.5, y = 0.46, col = "#96AFCC", pch = 16,cex=10)
#text(locator(), labels = "OLP4CBP")

# add legend
#legend(x=31,y=0.35,c("1-bmrk3pain","2-bmrk4","3-bmrk5pain","4-exp","5-ie","6-ie2","7-ilcp","8-nsf","9-scebl"),bty = "n")

#legend(x=30,y=0.05,c("RTNF","OLP4CBP"),cex=1,col=c("#BF7FBA","#96AFCC"), pch = 16 ,bty = "n")

dev.off()

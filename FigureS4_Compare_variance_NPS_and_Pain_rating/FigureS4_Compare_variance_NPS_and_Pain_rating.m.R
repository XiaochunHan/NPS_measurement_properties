library(ggplot2)
library(patchwork)
#setwd('./FigureS_Compare_variance_NPS_and_Pain_rating')

# colors settings
pain <- rgb(60/255,60/255,60/255)
nps <- rgb(255/255,48/255,115/255)

file = 'Variance_all.csv'
Data = read.csv(file,header=TRUE)

png("Variance_all.png",units="in",width = 6,height = 8,res = 300)
p<-ggplot(Data, aes(x=studynames, y=sd, group=measure)) +
  geom_line(aes(color=measure))+
  geom_point(aes(color=measure),size = 6)+ theme_classic()
p + scale_colour_manual(values = c(nps,pain))
dev.off()

file_2 = 'Variance_temp_by_study.csv'
Data_2 = read.csv(file_2,header=TRUE)

Study1 <- Data_2[Data_2$studynames=='study1',]
p1<-ggplot(Study1, aes(x=temperature, y=sd, group=measure)) +
  geom_line(aes(color=measure))+ ggtitle("Study 1")+
  geom_point(aes(color=measure),size = 6)+ theme_classic()+ theme(legend.position="none")+ scale_colour_manual(values = c(nps,pain))

Study2 <- Data_2[Data_2$studynames=='study2',]
p2<-ggplot(Study2, aes(x=temperature, y=sd, group=measure)) +
  geom_line(aes(color=measure))+ggtitle("Study 2")+
  geom_point(aes(color=measure),size = 6)+ theme_classic()+ theme(legend.position="none") + scale_colour_manual(values = c(nps,pain))

Study3 <- Data_2[Data_2$studynames=='study3',]
p3<-ggplot(Study3, aes(x=temperature, y=sd, group=measure)) +
  geom_line(aes(color=measure))+ggtitle("Study 3")+
  geom_point(aes(color=measure),size = 6)+ theme_classic() + scale_colour_manual(values = c(nps,pain))

Study5 <- Data_2[Data_2$studynames=='study5',]
p5<-ggplot(Study5, aes(x=temperature, y=sd, group=measure)) +
  geom_line(aes(color=measure))+ggtitle("Study 5")+
  geom_point(aes(color=measure),size = 6)+ theme_classic()+ theme(legend.position="none") + scale_colour_manual(values = c(nps,pain))

Study6 <- Data_2[Data_2$studynames=='study6',]
p6<-ggplot(Study6, aes(x=temperature, y=sd, group=measure)) +
  geom_line(aes(color=measure))+ggtitle("Study 6")+
  geom_point(aes(color=measure),size = 6)+ theme_classic()+ theme(legend.position="none") + scale_colour_manual(values = c(nps,pain))

Study8 <- Data_2[Data_2$studynames=='study8',]
p8<-ggplot(Study8, aes(x=temperature, y=sd, group=measure)) +
  geom_line(aes(color=measure))+ggtitle("Study 8")+
  geom_point(aes(color=measure),size = 6)+ theme_classic() + theme(legend.position="none") + scale_colour_manual(values = c(nps,pain))

png("Variance_temp_by_study.png",units="in",width = 12,height = 8,res = 300)
p1 + p2 + p3 + p5 + p6 + p8 + plot_layout(ncol = 3)
dev.off()
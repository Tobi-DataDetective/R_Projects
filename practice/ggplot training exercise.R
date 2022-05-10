setwd("C:/Users/Folayan Tobi/Documents/videos/udemy 2/practice")
library(ggplot2)
library(ggthemes)

theme_set(theme_dark())
head(mpg)
pl1<-ggplot(data = mpg, aes(x= hwy))
plot1<-pl1 + geom_histogram(col="red", fill="red")+ggtitle("HISTOGRAM FOR HIGH WAY")+xlab("HIGH WAY")
plot1

head(mpg)
pl2<- ggplot(data = mpg, aes(x=manufacturer))
plot2<-pl2 + geom_bar(aes(fill=factor(cyl)))+ theme_bw()+theme(axis.text.x =element_text(angle = 90,hjust = 1))+ ggtitle("BARPLOT OF MANUFACTURE WIHT COLOUR FILL CYL ")
plot2
?theme

head(txhousing)
pl3<- ggplot(data = txhousing,aes(x=sales,y= volume))
plot3<-pl3 + geom_point(col="blue",alpha=0.3, size= 2)+theme_bw()

pl4<- ggplot(data = txhousing,aes(x=sales,y= volume))
plot4<-pl4 + geom_point(col="blue",alpha=0.3, size= 2)+geom_smooth(col="red")+theme_bw()
plot4

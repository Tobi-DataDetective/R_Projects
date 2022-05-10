setwd("C:/Users/Folayan Tobi/Documents/videos/udemy 2/practice")
?read.csv
economist<-read.csv("C:/Users/Folayan Tobi/Documents/videos/udemy 2/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Data Visualization Project/Economist_Assignment_Data.csv")
head(economist)

library(ggplot2)
library(plotly)
library(ggthemes)
theme_set(theme_bw())

pl<- ggplot(data = economist,aes(x=CPI,y=HDI, col=Region))
pl<-pl + geom_point(shape = 21, size= 5)
#pl+ geom_point(size=2)
pl+ geom_smooth(aes(group=1))
pl2<-pl+geom_smooth(method = 'lm',
               formula = y ~ log(x),
               se = FALSE,
               color = 'red')
pl2

pl2+ geom_text(aes(label=Country))

#creating a subset to label
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(economist, Country %in% pointsToLabel),check_overlap = TRUE)

pl3
pl4<- pl3 + theme_economist_white() + scale_x_continuous(name = "Corruption Perception Index, 2011 (10=least corrupt)",
                                           limits = c(0.9,10.5),
                                           breaks = 1:10)+ scale_y_continuous(name = "Human Development Index, 2011 (1=Best)"
                                                                              #,
                                                                              #limits = 1.3,
                                                                              #breaks = 0.35:8.5
                                                                              )
final_plot<-pl4 + ggtitle("Corruption and Human development")
final_plot
ggplotly(final_plot)
install.packages("ggplot2")
#C:\Users\Folayan Tobi\AppData\Local\Temp\RtmpIdwR0D\downloaded_packages
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)
setwd("C:/Users/Folayan Tobi/Documents/videos/sentiment project")
jumia<-read.csv("C:/Users/Folayan Tobi/Documents/videos/sentiment project/jumia/jumia.csv")

tweets<- iconv(jumia$text)
sent<- get_nrc_sentiment(tweets)
sent[300:400,]
tweets[46]# trust
tweets[174]# negativity
tweets[34]# negative not interested in a quiz without the known reward 
tweets[91]# negativity an error in food delivery 
tweets[60]# negativity poor response to customer
tweets[198]# negativity office chair ordered not good

#####barplot#######
sentscore<-barplot(colSums(sent),
        las = 2,
        col = rainbow(20),
        ylab = 'Count',
        main = 'JUMIA SENTIMENT SCORES')

sentscore

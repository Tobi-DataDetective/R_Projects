install.packages("rtweet")
install.packages("tidytext")
# load twitter library - the rtweet library is recommended now over twitteR
library(rtweet)
# plotting and pipes - tidyverse!
library(ggplot2)
library(dplyr)
# text mining library
library(tidytext)
library(twitteR) #load package
library(twitteR)
library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(httr)
library(wordcloud)
library(SnowballC)
library(RColorBrewer)
#library(sentiment)
library(RCurl)
library(tm)

# whatever name you assigned to your created app


key18 <- "z30fX3NmiEBnfKaaLjTbV2vgm" #put the Consumer Key from Twitter Application
secret18 <- "KolMICQJXJRrpwXHl6Pgy6RGZR9y9CR6NhP0lEqqZr1Q9D5CLk"#put the Consumer Secret from Twitter Application
access_token18<-"1097788168655523841-cqX16VSmF7Az391Sy9MHjNF3m4uoRP"#put the access token from Twitter Application
access_secret18<-"HnJ1n4G2gAnrknwUb7HpRA7MwvHwziEciD7WbOKcEA4JR" #put the access secret from Twitter Application



setup_twitter_oauth(key18, secret18, access_token18, access_secret18)

tweets18<- searchTwitter('#ENDSARS',n=10000, since='2018-01-01', lang="en")

n.endsars18 <- length(tweets18)
endsars18df<- twListToDF(tweets18)  #converting to dataframe format
write.csv(endsars18df,file = "C:/Users/Folayan Tobi/Documents/videos/sentiment project/ENDSARS/endsars18.csv",row.names = F)
endsars18<-read.csv("C:/Users/Folayan Tobi/Documents/videos/sentiment project/ENDSARS/endsars18.csv")
View(endsars18)


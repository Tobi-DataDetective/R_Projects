#set working directory
setwd("C:/Users/Folayan Tobi/Documents/videos/sentiment project/jumia")
# load library
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

oauth_endpoint(authorize = "https://api.twitter.com/oauth",access ="https://api.twitter.com/oauth/access_token" )

#connect to API
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile='cacert.pem')
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

####twitter application
consumerKey <- "z30fX3NmiEBnfKaaLjTbV2vgm" #put the Consumer Key from Twitter Application
consumerSecret <- "KolMICQJXJRrpwXHl6Pgy6RGZR9y9CR6NhP0lEqqZr1Q9D5CLk"#put the Consumer Secret from Twitter Application
accesstoken<-"1097788168655523841-cqX16VSmF7Az391Sy9MHjNF3m4uoRP"#put the access token from Twitter Application
accesssecret<-"HnJ1n4G2gAnrknwUb7HpRA7MwvHwziEciD7WbOKcEA4JR" #put the access secret from Twitter Application

Cred <- OAuthFactory$new(consumerKey=consumerKey,
                         consumerSecret=consumerSecret,
                         requestURL=reqURL,
                         accessURL=accessURL,
                         authURL=authURL)
Cred$handshake(cainfo=system.file('curlssL','cacert.pem',package = 'RCurl'))
#There is URL in Console. You need to go to it, get code and enter it on Console

#authentication of pin

#once this is lauched you can start from here in future

save(Cred, file = 'twitter authentication.Rdata')
load('twitter authentication.Rdata')
setup_twitter_oauth(consumer_key =consumerKey ,consumer_secret =consumerSecret ,
                    access_token =accesstoken ,access_secret =accesssecret )


#getting tweets
tweets<- searchTwitter("jumia", n=1000, since = "2018-01-01",lang="en")
n.tweets <- length(tweets)
tweetsdf<- twListToDF(tweets)  #converting to dataframe format
write.csv(tweetsdf,file = "C:/Users/Folayan Tobi/Documents/videos/sentiment project/jumia/jumia.csv",row.names = F)
jumia<-read.csv("C:/Users/Folayan Tobi/Documents/videos/sentiment project/jumia/jumia.csv")
View(jumia)
#building corpus
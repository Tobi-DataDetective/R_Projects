setwd("C:/Users/Folayan Tobi/Documents/videos/sentiment project")
jumia<-read.csv("C:/Users/Folayan Tobi/Documents/videos/sentiment project/jumia/jumia.csv")
View(jumia)
str(jumia)


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

library(tm)
library(twitteR)
##########building corpus########
corpus<- iconv(jumia$text)
#remove retweets
corpus[1:5]
corpus<- gsub("(RT|via)((?:\\b\\w*@\\w+)+)"," ",corpus)
#remove people
corpus<- gsub("@\\w+"," ",corpus)
corpus<- gsub("\n.*"," ",corpus) #removes every \n pattern
corpus[1:5]

#removing html link
#corpus<- gsub("http\\w+","",corpus)

######creating a corpus###############
corpus<- Corpus(VectorSource(corpus))
inspect(corpus[1:5])
corpus<- tm_map(corpus,PlainTextDocument)


################cleaning text#####################
corpus<-tm_map(corpus,tolower)
inspect(corpus[1:5])
corpus<-tm_map(corpus,removePunctuation)
corpus<-tm_map(corpus,removeNumbers)
cleanset<- tm_map(corpus, removeWords,stopwords('english'))
cleanset<- tm_map(cleanset,stemDocument)
inspect(cleanset[1:5])
removeURL <- function(x) gsub('http[[:alnum:]]*','',x)
cleanset<- tm_map(cleanset,content_transformer(removeURL))
cleanset<- tm_map(cleanset,removeWords,c('jumia','rt','leggend'))


cleanset<- tm_map(cleanset, gsub,
                  pattern ='.',
                  replace = '')
cleanset<- tm_map(cleanset, gsub,
                  pattern ='deliveryeri',
                  replace = 'delivery')
cleanset<- tm_map(cleanset, gsub,
                  pattern ='deliv',
                  replace = 'delivery')
cleanset<- tm_map(cleanset, gsub,
                 pattern ='delivered',
                 replace = 'delivery')
cleanset<- tm_map(cleanset, gsub,
                  pattern ='delivering',
                  replace = 'delivery')

cleanset<-tm_map(cleanset,stripWhitespace)
inspect(cleanset[1:5])

###########Term document matrix##########
tdm<- TermDocumentMatrix(cleanset)
tdm
tdm<- as.matrix(tdm)
tdm[1:10,1:20]


#########Bar plot########
freq<-rowSums(tdm)
freq<-subset(freq,freq>=25)
freq
barplot(freq,
        las = 2,
        col = rainbow(40),ylab = 'tweet frequency')
?barplot


##########wordcloud2##########
library(wordcloud2)
w <- sort(rowSums(tdm), decreasing = TRUE)
head(w)
w <- data.frame(names(w), w)
w
colnames(w) <- c('word','freq')
head(w)
wordcloud2(w,
           size = 0.5,
           shape = 'circle', 
           rotateRatio = 0.5,
           minSize = 1)


############positve neg normal##########
setwd("C:/Users/Folayan Tobi/Documents/videos/sentiment project/jumia")

opinion.lexicon.pos<- scan('positive-words.txt',what = 'character', comment.char = ';')

opinion.lexicon.neg<- scan('negative-words.txt',what = 'character', comment.char = ';')
jj<- str_split(corpus,pattern = "\\s+")
jj
u<- lapply(jj, function(x){sum(!is.na(match(jj,opinion.lexicon.pos)))})
v<- lapply(jj, function(x){sum(!is.na(match(jj,opinion.lexicon.neg)))})
u
v
score<- u-v
score<- unlist(score)
score
hist(score)
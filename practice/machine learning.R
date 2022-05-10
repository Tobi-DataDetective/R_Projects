#########MACHINE LEARNING############
######getting the data#####
setwd("C:/Users/Folayan Tobi/Documents/videos/udemy 2/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R")
read.csv('student-mat.csv')
df<- read.csv('student-mat.csv', sep=';')
View(df)
head(df)
summary(df)
str(df)
##########cleaning the data########
any(is.na(df))

#########exploratory data#######
library(ggplot2)
library(ggthemes)
library(dplyr)

#coorelation and cooplots
# grabbing the numerical data
num.cols<- sapply(df,is.numeric)
#filter to numeric columns for correlation
cor.data<- cor(df[,num.cols])
cor.data
#install.packages('corrgram')
#install.packages('corrplot')
library(corrplot)
library(corrgram)
corrplot(cor.data,method = 'color')
corrgram(df, order = T, lower.panel = panel.shade,
         upper.panel = panel.pie,text.panel = panel.txt)
ggplot(df,aes(x=G3))+geom_histogram(bins = 20,
alpha=0.5,fill='blue')+theme_minimal()


########BUILDING A MODEL############
# general fom is model<- lm(y~x1+x2)  or model<-lm(y~. , data) # uses all the features
########splitting into training set and test data
library(caTools)
#set a seed to get the same result  after random selection
set.seed(101)
sample<- sample.split(df$age, SplitRatio = 0.70)
sample
#####training data#############
train=subset(df, sample == TRUE)

######test data#######
test=subset(df,sample== FALSE)
train
head(train)
head(test)
model<- lm(G3 ~.,train)
summary(model)


#########visualizing our model###########
res<- residuals(model)

res
res<- as.data.frame(res)
res
head(res)
ggplot(res,aes(res)) +  geom_histogram(fill='blue',alpha=0.5)
plot(model)
  

#########prediction########
G3.predictions<- predict(model, test)
results<- cbind(G3.predictions,test$G3)
colnames(results)<-c('pred','real')
results<-as.data.frame(results)

plot(results$real,type = "l",lty=1.8, col="red")
lines(results$pred, type= "l",  col="blue")


head(results)
# taking care of the negative results 
to_zero<- function(x){
  if (x<0){
    return(0)
  }else{
    return(x)
  }
}
#applying to the predicted column
results$pred<-sapply(results$pred, to_zero)
head(results)
#calculating the mean squared error
mse<- mean((results$real- results$pred)^2)
mse
#root mean squared
mse^0.5
#R squared value
sse= sum((results$real- results$pred)^2)
sst= sum((mean(df$G3)- results$pred)^2)
R2 = 1-sse/sst
R2


   ##########PROJECT############
setwd("C:/Users/Folayan Tobi/Documents/videos/udemy 2/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Machine Learning Projects/CSV files for ML Projects")
bike<- read.csv('bikeshare.csv')
head(bike)

#exploring the data
library(ggplot2)
ggplot(bike,aes(temp,count))+geom_point(alpha=0.2, aes(color= temp))+theme_bw()
bike$datetime<- as.POSIXct(bike$datetime)
ggplot(bike,aes(datetime,count)) + geom_point(aes(color=temp),alpha=0.5)  + scale_color_continuous(low='#55D8CE',high='#FF6E2E') +theme_bw()
cor(bike[,c('temp','count')])

# explore the seasonality using boxplot
ggplot(bike,aes(factor(season),count)) + geom_boxplot(aes(color=factor(season))) +theme_bw()
###feature engineering
# creating an hour column that takes hours from datatime
bike$hour <- sapply(bike$datetime,function(x){format(x,"%H")})
head(bike)

##scatterplot for working days
library(dplyr)
pl <- ggplot(filter(bike,workingday==1),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.5)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()

##scatterplot for non working days
pl <- ggplot(filter(bike,workingday==0),aes(hour,count)) 
pl <- pl + geom_point(position=position_jitter(w=1, h=0),aes(color=temp),alpha=0.8)
pl <- pl + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red'))
pl + theme_bw()


#####building a model#######
temp.model <- lm(count~temp,bike)
summary(temp.model)

#predicting number of rentals when temperature is 25
6.0462 + 9.17*25
temp=c(25)
temp.test<-data.frame(temp)
predict(temp.model,temp.test)
bike$hour <- sapply(bike$hour,as.numeric)


model <- lm(count ~ . -casual - registered -datetime -atemp,bike )
summary(model)



###########LOGISTIC REGRESSION#######
setwd("C:/Users/Folayan Tobi/Documents/videos/udemy 2/R-Course-HTML-Notes/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R")
df.train<-read.csv('titanic_train.csv')
head(df.train)
#######exploratory
#install.packages('Amelia')
library(Amelia)
library(Amelia)
missmap(df.train, main="Titanic Training Data - Missings Map", 
        col=c("yellow", "black"), legend=FALSE)
library(ggplot2)
ggplot(df.train,aes(Survived)) + geom_bar()

ggplot(df.train,aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)),alpha=0.5)
ggplot(df.train,aes(Sex)) + geom_bar(aes(fill=factor(Sex)),alpha=0.5)
ggplot(df.train,aes(Age)) + geom_histogram(fill='blue',bins=20,alpha=0.5)
ggplot(df.train,aes(SibSp)) + geom_bar(fill='red',alpha=0.5)
ggplot(df.train,aes(Fare)) + geom_histogram(fill='green',color='black',alpha=0.5)


########cleaning data
pl <- ggplot(df.train,aes(Pclass,Age)) + geom_boxplot(aes(group=Pclass,fill=factor(Pclass),alpha=0.4)) 
pl + scale_y_continuous(breaks = seq(min(0), max(80), by = 2))
impute_age <- function(age,class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}
fixed.ages <- impute_age(df.train$Age,df.train$Pclass)
df.train$Age <- fixed.ages
missmap(df.train, main="Titanic Training Data - Missings Map", 
        col=c("yellow", "black"), legend=FALSE)
#######building logistic regression
str(df.train)
head(df.train,3)
#######selecting relevant columns we need 
library(dplyr)
df.train <- select(df.train,-PassengerId,-Name,-Ticket,-Cabin)
head(df.train,3)
str(df.train)
df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$Parch <- factor(df.train$Parch)
df.train$SibSp <- factor(df.train$SibSp)
#########training the momdel
log.model <- glm(formula=Survived ~ . , family = binomial(link='logit'),data = df.train)

summary(log.model)

########predicting using test cases
#install.packages('caTools')
library(caTools)
set.seed(101)

split = sample.split(df.train$Survived, SplitRatio = 0.70)

final.train = subset(df.train, split == TRUE)
final.test = subset(df.train, split == FALSE)
final.log.model <- glm(formula=Survived ~ . , family = binomial(link='logit'),data = final.train)
summary(final.log.model)
#checking prediction accuracy
fitted.probabilities <- predict(final.log.model,newdata=final.test,type='response')
fitted.results <- ifelse(fitted.probabilities > 0.5,1,0)
misClasificError <- mean(fitted.results != final.test$Survived)
print(paste('Accuracy',1-misClasificError))
table(final.test$Survived, fitted.probabilities > 0.5)



###############K NEAREST NEIGHBORS #########
#install.packages('ISLR')
library(ISLR)
str(Caravan)
summary(Caravan$Purchase)
#removing any NA value
any(is.na(Caravan))
#######standardize variables
#check the variance of 2 features
var(Caravan[,1])
var(Caravan[,2])
# save the purchase column in a separate variable
purchase <- Caravan[,86]

#standardize the data using scale()
std.Carvan <- scale(Caravan[,-86])

# checking the variance again
var(std.Carvan[,1])

var(std.Carvan[,2])
# first 100 rows for test set
test.index<- 1: 1000
test.data<- std.Carvan[test.index,]
test.purchase<- purchase[test.index]

# rest of the data
train.data<- std.Carvan[-test.index,]
train.purchase<- purchase[-test.index]

#########USING KNN#########
library(class)
set.seed(101)
predict.purchase <- knn(train.data,test.data,train.purchase, k=1)
head(predict.purchase)
mean(test.purchase!= predict.purchase)


#####################CHOOSING K VALUE #############
predict.purchase<- knn(train.data, test.data, train.purchase, k =3)
mean(test.purchase!= predict.purchase)
predicted.purchase <- knn(train.data,test.data,train.purchase,k=5)
mean(test.purchase != predicted.purchase)


# automating the value of K
predicted.purchase = NULL
error.rate = NULL

for(i in 1:20){
  set.seed(101)
  predicted.purchase = knn(train.data,test.data,train.purchase,k=i)
  error.rate[i] = mean(test.purchase != predicted.purchase)
}
print(error.rate)

# using the elbow method
library(ggplot2)
k.values <- 1:20
error.df <- data.frame(error.rate,k.values)
error.df
# ploting the graph 
ggplot(error.df,aes(x=k.values,y=error.rate)) + geom_point()+ geom_line(lty="dotted",color='red')
############### DECISION TREES AND RANDOM FOREST#########
#install.packages('rpart')
#install.packages('rpart.plot')


########### SUPPORT VECTOR MACHINES##########
#install.packages('e1071')

############K MEANS CLUSTERING#############


############# NATURAL LANGUAGE PROCESSING #############
#install.packages('tm')
#install.packages('twitteR')
#install.packages('wordcloud')
#install.packages('RColorBrewer')
#install.packages('e1017')
#install.packages('class')


########### NEURAL NETWORK###########
#install.packages('neuralnet')

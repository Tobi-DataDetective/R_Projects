setwd("C:/Users/Folayan Tobi/Documents/videos/udemy 2/practice")
########Indexing and Slicing###########
v <- c(1,2,3,4,5,6,7,8,9,10)
names(v) <- c('a','b','c','d','e','f','g','h','i','j')
v>2
my.filter<- v>2
v[my.filter]

########creating matrix#########
matrix(v, nrow = 2)
matrix(1:12, nrow = 4, byrow = F)
google<-c(240,270,261,230,256)
msft<- c(203,279,267,234,290)
stocks<- c(google,msft)
stocks
mat<-matrix(stocks,ncol = 2,byrow = FALSE)
colnames(mat)<- c('google','msft')
mat
rownames(mat)<- c(1:5)
mat
days<-c('mon','tue','wed','thurs','fri')
rownames(mat)<-NULL
mat
rownames(mat)<- days
mat
subset(mat,google>=270)
mat[mat>240]
colSums(mat)
rowSums(mat)
FB<- c(239,257,280,275,278)
mat2<-cbind(mat,FB)
daily.avg<-colMeans(mat2)
rowMeans(mat2)
rbind(mat2,daily.avg)

########Factors & categorical matrix#########
animal<- c('d','c','d','c','c')
id<- c(1:5)
factor(animal)
fact.ani<-factor(animal)
ord.cat<-c('cold','warm','hot')
temp<- c('cold','warm','hot','hot','hot','cold','warm')
fact.temp<-factor(temp,ordered = T,levels = ord.cat)
fact.temp
summary(fact.temp)


#########dataframe basics#########
days<- c('mon','tue','wed','thur','fri')
temps<-c(22.2,21,23,24.3,25)
rain<- c(T,T,F,F,T)
df<-data.frame(days,temps,rain)
df
str(df)
summary(df)
df$rain # note that the $ sign gives a vector result 
df['rain'] # gives a data frame result
df[1:5,c('days','temps')]
df[1:5,1:2]
subset(df,rain==T)
df[df$rain==T,]
subset(df,rain==T & temps>=22)#filtering a dataframe
asc.order<-order(df['rain'])
df[asc.order,]
desc.order<- order(-df['temps'])
df[desc.order,]
df[5,2]#for picking out a single value from a dataframe use double brackets
df
df[5,'days']
mtcars
colnames(mtcars)
mtcars$mpg
mtcars[,'mpg']
mtcars[['mpg']]
mtcars['mpg']
df2<- data.frame(col.name.1=2000,col.name.2='new')
df2
df
df$newcol<-2*df$temps
colnames(df)[1]<- 'new.name' #rename a column
colnames(df)
colnames(df)
colnames(df)<-c('new','tem','rai','col')#naming more than 1 column
df


#########dealing with missing value##########
is.na(mtcars)
is.na(df)
any(is.na(df))
any(is.na(mtcars$mpg))
mtcars$mpg[is.na(mtcars$mpg)]<- mean(mtcars$mpg)

######## lists basics #######
# list allows us to store varities of data structure in a single variable 
v <- c(1,2,3)
m <- matrix(1:10, nrow = 2)
df<- mtcars
my.list<- list(v,m,df)
my.list[[1]]

######## csv files#########
######## excel files#########
###### sql with R ########
###### web scraping ########

######## logical operation########
# and &, or |, not !
x<-20
(x < 20) & (x > 5) & (x==9)
mtcars
mtcars[mtcars$mpg>20,]
subset(mtcars, mpg >20)
mtcars[(mtcars$mpg >20)  & (mtcars$hp > 100),]
subset(mtcars,mpg>20 & hp>100)

####### if else statement ########
######## while loop ########
###### for loop ########
####### functions ########

######### advanced R programming#########
seq(0,10, by=2)
v<-c(1,4,2,5,7,4,7)
sort(v)
sort(v,decreasing = T)
cv<-c('b','d','a')
sort(cv)
rev(v)
v2<-35:41
append(v,v2)
is.vector(v)


########apply########
print(sample(x=1:100,3))
v<-c(1:5)
addrand<-function(x){
  ran<- sample(1:100,1)
  return(x+ran)
}
print(addrand(x))
print(lapply(v,addrand))
print(sapply(v,addrand))

v<-1:5
times2<-function(num){
  return(num*2)
}
print(v)
result<-lapply(v,times2)
result<-sapply(v,times2)
result

#####regular expression########
text<-"hi there do you know who you are voting for?"
grepl('voting',text)
grepl('dog',text)
v<- c('a','b','c','d','d')
grep('b',v)
grep('d',v)

########date and timestamps#######
Sys.Date()
Sys.time()
c<-"1990-01-01"
class(c)
my.date<- as.Date(c)
my.date<-as.Date("NOV-03-90", format="%b-%d-%y")
my.date
as.Date("june,01,2002", format="%b,%d,%Y")
as.POSIXct("11:02:03", format="%H:%M:%S")
strptime("11:02:03", format="%H:%M:%S")

#########guide to using Dplyr#####  [[[[[[[[[[[[[[[[[[[DATA CLEANING]]]]]]]]]]]]]]]]]]]
library("dplyr")
library("nycflights13")
head(flights)
#filter()
head(filter(flights,month==11,day==3,carrier=='AA'))
#slice()
slice(flights,1:10)
#arrange()  reorder rows
head(arrange(flights,year,month,day,desc(arr_time)))
#select()
head(select(flights,carrier,arr_time))
#rename()
head(rename(flights,nnn=carrier))
colnames(flights)[10]<-'car'#naming 1 column, whichh is the same as the above
flights
#distinct()
distinct(flights,carrier)
#mutate() adding a new column
rr<-(mutate(flights,new_col=arr_delay - dep_delay))  #including a new column
View(rr)
rr$new_col<-NULL
rr$new<-rr$dep_time - rr$dep_delay   #another way of including a new column 
rr$new<-NULL                    #removing column
head(transmute(flights,newcol=arr_delay + dep_delay))
View(rr)
ss<-c("emp","xyz","jkl")
bb<-c(12,"",100)
a<-data.frame(ss,bb)
a
a$ss<- replace(as.vector(a$ss),a$ss=="emp",12) #replacing a value in a data frame which is part of data cleaning 
a$bb<- replace(as.character(a$bb),a$bb=="","fte")
rm(a)
a
rm(a$ss)
a$ss<-NULL # deleting a column from a dataframe which is also part of data cleaning
a
summarise(flights,avg_air_time= mean(air_time,na.rm = T)) #finding the avarage value of a column and not including the na values
sample_n(flights,10)
sample_frac(flights, 0.2)


#######pipe operator %>%###########
library(dplyr)
df<-mtcars
#nesting
result<- arrange(sample_n(filter(df,mpg>20),size = 5),desc(mpg))
result
#repetition using the multiple assignment 
a<- filter(df,mpg>20)
b<- sample_n(a,size=5)
rere<- arrange(b, desc(mpg))
rere
#using the pipe operator to the same above
result<- df %>% filter(mpg>20) %>% sample_n(size = 5) %>% arrange(desc(mpg))
result

########Guide to using tidyr########
library(tidyr)
library(data.table)
comp<- c(1,1,1,2,2,2,3,3,3)
yr<- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9,min=0, max = 100)
q2 <- runif(9,min=0, max = 100)
q3 <- runif(9,min=0, max = 100)
q4 <- runif(9,min=0, max = 100)
df<- data.frame(comp = comp, year=yr, qtr1=q1, qtr2=q2, qtr3=q3, qtr4=q4)
df
gather(df, quarter, revenue, qtr1:qtr4) #cleaning data mostly involving time series
df<-df %>% gather(quarter, revenue, qtr1:qtr4)
df %>% spread(quarter, revenue)
spread(df, quarter, revenue)
df<- data.frame(new.col=c(NA,'a.x','b.y','c.z'))
df
separate(df,new.col,c('abc','xyz'))
df<- data.frame(new.col=c(NA,'a-x','b-y','c-z'))
df
df<-separate(df,new.col,c('abc','xyz'),sep = '-')
df
unite(df,new.joined.col,abc,xyz, sep = '---')



#[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[DATA VISUALIZTION]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
#######Grammar of Graphics with ggplot2##########
# DATA, AESTHETICS, GEOMETRICS
library(ggplot2)
library(ggplot2movies)
ggplot(data = mtcars) # data
pl<- ggplot(data = mtcars,aes(x=mpg,y=hp)) #data and aesthetics
pl2<-pl + geom_point()  # geometrics
pl3<-pl2+facet_grid(cyl~.)  #facets
pl4<- pl3 + facet_grid(cyl~.)+ stat_smooth() #statistics
pl5<-pl4+coord_cartesian(xlim = c(15,25))    # coordinate
pl6<-pl5 + theme_bw()  #theme
pl6
head(mtcars,6)

#google rstudio ggplot cheat sheet download the pdf
#######data & aesthetics (histogram) #########

ggplot(movies,aes(x=rating))
head(movies,5)
pl<-ggplot(movies,aes(x=rating))
pl+geom_histogram()
pl+geom_histogram(binwidth = 0.1)
pl2<-pl+geom_histogram(binwidth = 0.1,color='red',fill='purple',alpha=0.2)
pl2+xlab('movies_rating')+ylab('COUNT')+ggtitle('DITRIBUTION OF MOVIE RATING')


#########scatterplot#######

mtcars
df<- mtcars
pl<-ggplot(data = df, aes(x=wt,y=mpg))
pl+geom_point(alpha=0.5,size=3)
pl+geom_point(aes(size=hp)) #shows that a car with higher wt has less mph and higher hp
pl+geom_point(aes(size=factor(cyl)))
pl+geom_point(aes(shape=factor(cyl),size=5,color=factor(cyl)))

#using the hex color code
pl2<-pl+geom_point(size=3,color='#56ea29')
pl2<-pl+geom_point(aes(color=hp),size=5)
pl2+scale_color_gradient(low = 'blue',high = 'red')

##########Barplot######
df<-mpg
df
pl<-ggplot(data=df,aes(x=class))
pl+geom_bar(aes(fill=drv))
pl2<-pl+geom_bar(aes(fill=drv),position = "dodge")
pl+geom_bar(aes(fill=drv),position = "fill")
#########theme()######
theme_set(theme_minimal())  #global theme
pl2
library(ggthemes)
pl2+ theme_classic() #local theme
pl2+ theme_economist()+ xlab('CLASS')+ylab('COUNT')+ggtitle('BAR CHART')


####### CREATING FUNCTIONS #######
plotgraph<- function(dat,horiz,vert,colr){
  pl<-ggplot(data = dat, aes(x=horiz,y=vert))
  pl2<-pl+geom_point(aes(color=colr),size=5)
  pl2+scale_color_gradient(low = 'blue',high = 'red')+theme_bw()
}
dd<-plotgraph(mtcars,mtcars$wt,mtcars$mpg,mtcars$hp)
dd

######Animation 3D plot###########
library(plotly)
library(ggplot2)
setwd("C:/Users/Folayan Tobi/Desktop")
gapminder<-read.csv("gapminder.csv")
dim(gapminder)
head(gapminder,4)
p_lot<-ggplot(gapminder,aes(gdpPercap,lifeExp,color=continent))+geom_point(aes(size=pop,
                                                                               frame=year,
                                                                               ids=country))+scale_x_log10()
p_lot              
ggplotly(p_lot)

######### publishing animation plot########
#https//plot.ly/r/fgetting-started
#to create sharable links to the chart
#setup api: https://plot.ly/r/getting-started
Sys.setenv("plotly_username"="FolayanR")
Sys.setenv("plotly_api_key"="5l50FkzQN9FiSzeh6RUD")
chart_link<-api_create(p_lot,filename = "Animation_plot")
chart_link



#########3D with car#####
library(rgl)
library(car)
#creating objects for each of the variable
head(Soils,4)
Na<- Soils$Na
ph<-Soils$pH
conduct<-Soils$Conduc
car3<-scatter3d(Na,ph,conduct,data=Soils,
                type="p",
                size=4,xlab = "sodium content",
                ylab = "pH",zlab = "conductivity",
                surface = F,
                #fit = "smooth",
                grid = F, ellipsoid = T,axis.col = c('red','blue','orange'))
aspect3d(1,0.7,1.2)

#get working directory
getwd()

#date and time
date()
Sys.time()

#load text mining and wordcloud packages
library(tm)
library(wordcloud)

#load and install gsubfn
install.packages("gsubfn")
library(gsubfn)

#read csv file...ask Brad if csv is built into R as opposed to the xlsx library
Tweets<-read.csv("Tweets.csv",header=T)
dim(Tweets)
head(Tweets)
class(Tweets)

#take subset of the csv file getting rid of the first column
TweetsSubset = Tweets[,c(2)]
head(TweetsSubset)
Tdf = data.frame(TweetsSubset)
class(Tdf)

#array will be used in for function
StringArray = c("@[^ ]+", "RT", "University of Miami", "http[^ ]+")

#take subset of the csv file getting rid of the first column. Same as above but I'm using an it for the for loop
TSub0 = Tweets[,c(2)]
head(TSub0)
Tdf = data.frame(TSub0)
class(Tdf)

#cleaning the data one variable at a time
Tsub1= gsub("@[^ ]+", "", TSub0, ignore.case=T)
Tsub2= gsub("RT", "", Tsub1, ignore.case=T)
Tsub3= gsub("University of Miami", "", Tsub2, ignore.case=T)
Tsub4= gsub("http[^ ]+", "", Tsub3, ignore.case=T)
Tsub4

#for function that does not work correctly
for(i in 1:length(StringArray))
{
	t = paste("TSub", i, sep="")
	v = paste("TSub", i-1, sep="")
	assign(t, (gsub(StringArray[i], "", v , ignore.case=T)))
}

#failed gsubfn function
gsubfn(".", list("RT"="", "@[^ ]+"=""), TweetsSubset)


WSC<-Corpus(VectorSource(Tsub2))
WSC<-tm_map(WSC,removePunctuation)
WSC<-tm_map(WSC,removeNumbers)

#stopwords fuction does not work with the csv file
#WSC<-tm_map(WSC,removeWords,stopwords("en"))

#generate wordcloud
wordcloud(WSC)

##########################################################

#function to replace a list of words with nothing
#credt to Theodore Lytras at http://stackoverflow.com/questions/15253954/replace-multiple-arguments-with-gsub 

gsubFunc = function(pattern, replace, x, ...){
	result = x
	for(i in 1:length(pattern)){
		result = gsub(pattern[i], replace, result, ...)
	}
	result
}

data = Tweets[,c(2)]

TwSubset=gsubFunc(c("RT", "@[^ ]+", "http[^ ]+", "University", "of", "Miami", "for", "the", "and"), "", data, ignore.case=T)

TwSubset


WSC<-Corpus(VectorSource(TwSubset))
WSC<-tm_map(WSC,removePunctuation)
WSC<-tm_map(WSC,removeNumbers)

#generate wordcloud
wordcloud(WSC)




#Original function by Theodore Lytras at http://stackoverflow.com/questions/15253954/replace-multiple-arguments-with-gsub
 
mgsub <- function(pattern, replacement, x, ...) {
  if (length(pattern)!=length(replacement)) {
    stop("pattern and replacement do not have the same length.")
  }
  result <- x
  for (i in 1:length(pattern)) {
    result <- gsub(pattern[i], replacement[i], result, ...)
  }
  result
}

mydata <- Tweets[,c(2)]
Tsub4=mgsub(c("RT", "University of Miami", "@[^ ]+", "http[^ ]+"), c("", "", "", ""), mydata)





